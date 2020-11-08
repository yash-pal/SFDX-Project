public class ContactAndLeadSearch {
    public static List<List<sObject>> searchContactsAndLeads(String lastName) {
       /* Account acct = new Account(Name = 'whatever inc');
        insert acct;
        ID acctID = acct.ID;
        Contact ct = new Contact(lastname = 'Smith', AccountId=acctID);
        insert ct;
        Lead ld = new Lead(lastname = 'Smith', Company = 'ACD company');
        insert ld;*/
        
        List<List<sObject>> searchList = [FIND :lastName IN NAME Fields RETURNING Contact(FirstName,LastName),Lead(FirstName,LastName)];
        
        return searchList;
    }
}