public with sharing class SendEmail {

    
    public list<Contact> conList{get;set;}
    
    public ApexPages.StandardController stcontrol;
    public string conId {get;set;}
    
    public SendEmail(ApexPages.StandardController stcontrol){
        this.stcontrol =  stcontrol;
        conList =[select id ,name,salutation,FirstName,LastName, Approval__c from contact ];
        
        
    }
    public void showpopup(){
        system.debug('conId'+conId);
    }    
    public void send(){
        Id recordId = stcontrol.getId();
        
            //system.debug('conId'+conId);
        
    /*    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'palyash1997@gmail.com'};
            mail.setToAddresses(toAddresses);
        mail.setBccSender(false);
        mail.setTargetObjectId( UserInfo.getUserId() );
        mail.setSaveAsActivity( false );
        mail.setSubject('Approved ');
        mail.setPlainTextBody('Hi, Your request has been approved');
        Messaging.SendEmailResult [] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
       
        
      */
        contact con = [select id ,Approval__c from contact where id =: conId];
        conList.add(con);
        update conList;
        
        
        
        
        
    }
    
}