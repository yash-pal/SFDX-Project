public with sharing class GuideController {
	@AuraEnabled
    public static  Contact RelatedContacts(Id recordId)
    {
        return[select id ,Name, LastName , AccountId, Account.Name , Account.Industry from contact where Id =: recordId ];
    }
}