public class NewCaseListController {
    public List<Case> getNewCases()
    {
        List<Case> results = [SELECT CaseNumber FROM Case WHERE status='New'];
        return results;
     }
}