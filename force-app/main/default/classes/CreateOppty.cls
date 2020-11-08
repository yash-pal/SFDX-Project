public class CreateOppty {
    @AuraEnabled 
    public static Opportunity newOppty(String oppName, Id caseId) {
        System.debug('Name: ' + oppName);
        System.debug('caseId: ' + CaseId);
        Case caseRecord = [Select AccountId FROM Case WHERE Id=:caseId];
        Date d = Date.today().addMonths(1);
        Opportunity newOpp = new Opportunity(Name=oppName, 
                                             AccountId=caseRecord.AccountId, 
                                             StageName='Perception Analysis', 
                                             CloseDate=d);
        
        insert newOpp;
        return newOpp;
    }
}