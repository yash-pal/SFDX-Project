global class ContactUpdateBatch  implements Database.Batchable<sObject>{
    global Integer recordsProcessed = 0;
    global Map<Id, SObject> IdToSObjectMap = new Map<Id, SObject>();
    global Map<Id, String> successMap = new Map<Id, String>();
    global Map<Id, String> errorMap = new Map<Id, String>();
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([select Id from Account]); 
    }
    
    
    global void execute(Database.BatchableContext bc,List<Account> scope){
        
        List<Account> acc =  new List<Account>();
        
        for(AggregateResult ar:[select AccountId a, count(Id) c from Contact where AccountId in : scope group by AccountId]){
            acc.add(new Account(Id = (Id) ar.get('a'),NumberofEmployees = (Integer) ar.get('c')));
        }
        update acc;
    }
    
    
    
    
    
    global void finish(Database.BatchableContext bc){
        
        List<Contact> contactList = [Select id,name , CreatedById, lastModifiedById, AccountId from Contact  Where Account.Name='YashTest'];
        
        string header = 'Record Id, Name , Created By, Modified By, Account Id\n';
        string finalstr = header ;
        for(Contact co: contactList)
        {
            string recordString = '"'+co.id+'","'+co.Name+'","'+co.CreatedById+'","'+co.lastModifiedById +'","'+co.AccountId+'"\n';
            finalstr = finalstr +recordString;
        }
        Messaging.EmailFileAttachment csvAttc = new Messaging.EmailFileAttachment();
        blob csvBlob = Blob.valueOf(finalstr);
        string csvname= 'Contact.csv';
        csvAttc.setFileName(csvname);
        csvAttc.setBody(csvBlob);
        Messaging.SingleEmailMessage email =new Messaging.SingleEmailMessage();
        String[] toAddresses = new list<string> {'palyash1997@gmail.com'};
            String subject ='Updated Contact List';
        email.setSubject(subject);
        email.setToAddresses( toAddresses );
        email.setPlainTextBody('Contact List  Has been updated');
        email.setFileAttachments(new Messaging.EmailFileAttachment[]{csvAttc});
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});            
        
        
        
        
        
        
    }
    
    
    
}