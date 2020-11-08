global class AccountUpdateBatch implements Database.Batchable<SObject>, Database.Stateful{
    global Map<Id, String> errorMap;
    global Map<Id, SObject> IdToSObjectMap;
    global Map<Id, String> successMap;
    global String baseURL;
   
    global AccountUpdateBatch(){
        errorMap = new Map<Id, String>();
        successMap = new Map<Id, String>();
        IdToSObjectMap = new Map<Id, SObject>();
        baseURL = URL.getSalesforceBaseUrl().toExternalForm();
    }
   
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('Select Id, OwnerId, Name From Account WHERE LastModifiedDate = Today');
    }
   
    global void execute(Database.BatchableContext BC, List<SObject> scope) {
        List<Account> accountList = new List<Account>();
        for(SObject s : scope){
            Account acct = (Account) s;
            //Add Logic to update fields on the Account
           for(AggregateResult ar:[select AccountId a, count(Id) c from Contact where AccountId in : scope group by AccountId]){
             accountList.add(new Account(Id = (Id) ar.get('a'),NumberofEmployees = (Integer) ar.get('c')));
        
            accountList.add(acct);
        }
        
        update  accountList;
        }
       
        if(accountList.size() > 0) {
            List<Database.SaveResult> dsrs = Database.Update(accountList, false);
            Integer index = 0;
            for(Database.SaveResult dsr : dsrs){
                if(!dsr.isSuccess()){
                    String errMsg = dsr.getErrors()[0].getMessage();
                    errorMap.put(accountList[index].Id, errMsg);
                   
                } else {
                    String sucMsg = baseURL + '/' + accountList[index].Id;
                    successMap.put(accountList[index].Id, sucMsg);
                }
                IdToSObjectMap.put(accountList[index].Id, accountList[index]);
                index++;
            }
        }
    }
   
    global void finish(Database.BatchableContext BC) {
        if(! IdToSObjectMap.isEmpty()) {
            //Send an email to the User after your batch completes
            AsyncApexJob a = [SELECT id, ApexClassId,
                              JobItemsProcessed, TotalJobItems,
                              NumberOfErrors, CreatedBy.Email
                              FROM AsyncApexJob
                              WHERE id = :BC.getJobId()];
            String body = 'Your batch job '
                + 'AccountUpdateBatch '
                + 'has finished. \n'
                + 'There were total'
                + IdToSObjectMap.size()
                + ' records. Please find the attached success and error records CSV.';
            String subject = 'Account - Apex Batch Result for AccountUpdateBatch';
            // Define the email
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            // Define email file attachment list
            Messaging.EmailFileAttachment[] emailAttList = new List<Messaging.EmailFileAttachment>();
            if(!errorMap.isEmpty()){
                // Creating the CSV file for error
                String finalstr = 'Id, Name, Error \n';
               
                String attName = 'AccountErrors' + system.now().format('YYYYMMDDhhmm') + '.csv';
                for(Id id  : errorMap.keySet()){
                    string err = errorMap.get(id);
                    Account acct = (Account) IdToSObjectMap.get(id);
                    string recordString = '"'+id+'","'+acct.Name+'","'+err+'"\n';
                    finalstr = finalstr +recordString;
                }
                               
                // Create the email attachment    
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName(attName);
                efa.setBody(Blob.valueOf(finalstr));
                emailAttList.add(efa);
            }
            if(! successMap.isEmpty()) {
                // Creating the CSV file for successful updates
                String finalstr = 'Id, Name, Link \n';
                String attName = 'AccountSuccess' + system.now().format('YYYYMMDDhhmm') + '.csv';
                for(Id id  : successMap.keySet()){
                    string suc = successMap.get(id);
                    Account acct = (Account) IdToSObjectMap.get(id);
                    string recordString = '"'+id+'","'+acct.Name+'","'+suc+'"\n';
                    finalstr = finalstr +recordString;
                }
               
                // Create the email attachment    
                Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                efa.setFileName(attName);
                efa.setBody(Blob.valueOf(finalstr));
                emailAttList.add(efa);
                 
            }
            // Sets the paramaters of the email
            email.setSubject( subject );
            email.setToAddresses( new String[] {a.CreatedBy.Email} );
            email.setPlainTextBody( body );
            email.setFileAttachments(emailAttList);
           
            // Sends the email
            Messaging.SendEmailResult [] r =
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        }
    }
}