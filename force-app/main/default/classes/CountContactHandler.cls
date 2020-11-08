public class CountContactHandler {
    public static void TotalCount(Boolean IsInsert , Boolean IsUpdate ,Boolean IsDelete,Boolean IsUndelete,List<Contact> conListNew, List<Contact> ConListOld){
        Set<Id> accId = new Set<Id>();
        List<Account> UpdateAccount = new List<Account>();
        if(IsInsert || IsUpdate ||IsUndelete ){
            for(Contact co:conListNew){
                accId.add(co.accountId);
            }
            
        }
       
        if(IsUpdate || IsDelete){
            for(Contact co:ConListOld){
                accId.add(co.accountId);
                
            }
        }
        for(Account ac:[SELECT Id,Name,Total_Contact__c,(SELECT Id,name FROM Contacts) FROM Account where Id IN:accId]){
            system.debug('Size' + ac.Contacts.size());
            ac.Total_Contact__c = ac.Contacts.size();
            UpdateAccount.add(ac);
            
            
        }
        if(UpdateAccount.size() > 0)
            update UpdateAccount;
        
    }
    
    
}