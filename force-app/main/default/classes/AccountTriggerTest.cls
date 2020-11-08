/**
 * @File Name          : AccountTriggerTest.cls
 * @Description        : 
 * @Author             : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Group              : 
 * @Last Modified By   : ChangeMeIn@UserSettingsUnder.SFDoc
 * @Last Modified On   : 24/5/2019, 3:14:04 PM
 * @Modification Log   : 
 *==============================================================================
 * Ver         Date                     Author      		      Modification
 *==============================================================================
 * 1.0    24/5/2019, 3:14:04 PM   ChangeMeIn@UserSettingsUnder.SFDoc     Initial Version
**/
@isTest

public class AccountTriggerTest {
    
    @isTest static void testCreateRecords(){
        List<Account> accts = new List<Account>();
        for(Integer i=0;i<200;i++)
        {
            Account acct = new Account(Name='Test Account ' + i, BillingState = 'CA');
            accts.add(acct);
            Test.startTest();
            Insert accts;
            Test.stopTest();
            System.assertEquals(200, [SELECT Count() FROM Account WHERE ShippingState = 'CA']);
        }
    }

}