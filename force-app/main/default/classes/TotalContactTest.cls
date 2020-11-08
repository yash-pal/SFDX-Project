@isTest

public class TotalContactTest {
    Static testmethod void myTest(){
        Account acc =  new Account();
        acc.Name = 'YashTest';
        insert acc;
        
        Contact co =  new Contact();
        co.LastName = 'TestContact';
        co.AccountId = acc.Id;
        insert co;
        
        update acc;
        
        update co;
        
        
      }
}