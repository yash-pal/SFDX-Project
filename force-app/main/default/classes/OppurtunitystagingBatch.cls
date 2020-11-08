global class OppurtunitystagingBatch  implements Database.Batchable<sObject>
{
    global Database.QueryLocator start(Database.BatchableContext context){
        String query ='SELECT Id,FirstName,LastName FROM contact';
        return Database.getQueryLocator(query);
        
    }
    global void execute(Database.BatchableContext context,List<staging__c> stage)
    {
        /*List<staging__c> stg = new List<staging__c>();
        for(staging__c st :  stg){
            if(Individual_or_Organization__c==st){
                
            }
        }*/
        
    }
    global void finish(Database.BatchableContext context){
        
    }
    
}