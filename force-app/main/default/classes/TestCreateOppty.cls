@isTest
public class TestCreateOppty {
    public static testMethod void newOpptyValid(){
        Account a = new Account(Name = 'Burlington Acme');
        insert a;
        Case c = new Case(AccountId = a.Id);
        insert c;        
        String oppName = 'Burlington Acme 1000 TVs';
        
        List<Opportunity> lob = [SELECT Name, AccountId, StageName, CloseDate From Opportunity];
        System.assertEquals(0, lob.size());
        CreateOppty.newOppty(oppName, c.id);
        List<Opportunity> lo = [SELECT Name, AccountId, StageName, CloseDate From Opportunity];
        System.assertEquals(1, lo.size());
        System.assertEquals(lo[0].Name, oppName);
        System.assertEquals(lo[0].AccountId, a.Id);
        System.assertEquals(lo[0].StageName, 'Perception Analysis');
        System.assertEquals(lo[0].CloseDate, Date.today().addMonths(1));
    }
}