@isTest
public class LeadProcessorTest {
    @testsetup static void setup()
    {
        List<Lead> ld = new List<Lead>();
        for(Integer i=0;i<200;i++)
        {
            ld.add(new lead(LastName='Lead'+i,Company='test'));
            
        }
        insert ld;
    }
    static testmethod void test(){
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
        System.assertEquals(200,[select count() from lead where LeadSource = 'Dreamforce']);
    }  
}