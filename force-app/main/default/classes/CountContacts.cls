global class CountContacts  implements Database.Batchable<sObject>{
    global Integer recordsProcessed = 0;
    global Map<Id, SObject> IdToMap = new Map<Id, SObject>();
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([select Id from Account WHERE LastModifiedDate = Today]); 
    }
    
    
    global void execute(Database.BatchableContext bc,List<Account> scope){
        
        List<Account> acc =  new List<Account>();
        
        for(AggregateResult ar:[select AccountId a, count(Id) c from Contact where AccountId in : scope group by AccountId]){
            acc.add(new Account(Id = (Id) ar.get('a'),NumberofEmployees = (Integer) ar.get('c')));
        }
        update acc;
    }
    global void finish(Database.BatchableContext bc){
        if(IdToMap != null){
      
            List<Account> accountList = new List<Account>([Select id ,Name, Total_Contact__c from Account where Total_Contact__c > 1 limit 2000]);
            string header = 'Account Name, Total Number of Contacts ';
            string finalstr = header ;
            for(Account acc : accountList)
            {
                string recordString = '"'+acc.Name+'","'+acc.Total_Contact__c+'"\n';
                finalstr = finalstr +recordString;
            }
            Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
            blob csvBlob = Blob.valueOf(finalstr);
            string csvname= 'Contact.csv';
            csvAttc.setFileName(csvname);
            csvAttc.setBody(csvBlob);
            Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
            email.setTargetObjectId(UserInfo.getUserId());
            email.setSaveAsActivity( false );
            String[] toAddresses = new list<string> {'palyash1997@gmail.com'};
                String subject ='Updated Contact List';
            email.setSubject(subject);
            email.setToAddresses( toAddresses );
            email.setPlainTextBody('Contact List  Has been updated');
            email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
            Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});       
        }
        
    }
}