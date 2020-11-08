global class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful {
    global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id,LeadSource FROM Lead'); 
        
    }
    global void execute(Database.BatchableContext bc,List<Lead> scope){
        
    	List<Lead> leadList = new List<Lead>();
        for(Lead ld : scope){
            ld.LeadSource = 'DreamForce';
            recordsProcessed = recordsProcessed + 1;
            leadList.add(ld);
        }
        update leadList;
    }
    
    
    global void finish(Database.BatchableContext bc){
        system.debug(recordsProcessed + 'records processed. Shazam!');
    }

}