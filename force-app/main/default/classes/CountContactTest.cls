@isTest
public class CountContactTest {
    
    @testsetup static void setup(){
        
        Account acct = new Account();
        acct.Name = 'Test1';
        
        insert acct;
        
        Contact Con = new Contact();
        Con.LastName = 'Test0001';
        con.AccountId = acct.id;
        insert Con;
  
        update acct;
        
        
            }
    static testmethod void Test(){
       
        Test.startTest();
        CountContacts cct = new CountContacts();
        Id batchId = Database.executeBatch(cct);
        Test.stopTest();
        
    }
}