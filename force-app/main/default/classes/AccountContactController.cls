public with sharing class AccountContactController{
	public List<Contact> contactList{ get; set; }

	public AccountContactController(){
		this.contactList = new List<Contact>();
	}

	@AuraEnabled(cacheable=true)
	public static list<Contact> getContacts(string searchKey){
		List<Contact> lst = new List<Contact>([SELECT Id, AccountId,FirstName,LastName,Name,Title, Phone, Email,Guide1__Is_Primary_Contact__c
		                                       FROM Contact
		                                       WHERE Accountid = :searchKey]);
		return lst;
	}

	@AuraEnabled
	public static void deleteContacts(List<Id> lstConIds){
		try{
			list<Contact> lstConsToDelete = new list<Contact>();
			for (Id idCon : lstConIds){
				lstConsToDelete.add(new Contact(Id = idCon));
			}
			if (!lstConsToDelete.isEmpty()){
				delete lstConsToDelete;
			}
		} catch (Exception e){
			throw new AuraHandledException(e.getMessage());
		}
	}

	@AuraEnabled
	public static void updateContacts(String lstRecordId){
		try{
			contact con =  [SELECT Id,Accountid,Guide1__Is_Primary_Contact__c FROM Contact WHERE Id =: lstRecordId];
			con.Guide1__Is_Primary_Contact__c = true;
			update con;
			system.debug('abfbsd' + con);
			/*Contact co = [SELECT Id,Accountid,Guide1__Is_Primary_Contact__c FROM Contact WHERE AccountId =: con.Accountid AND Id !=: lstRecordId AND Guide1__Is_Primary_Contact__c = True];
			co.Guide1__Is_Primary_Contact__c = false;
			update co;
			*/
				/*for(Contact con : [SELECT id,LastName,Email,Phone,Guide1__Is_Primary_Contact__c FROM Contact WHERE Id IN : lstRecordId ]){
				con.Guide1__Is_Primary_Contact__c = true;
				lstConsToUpdate.add(con);
				system.debug('bashdb' + con);
				//lstConsToUpdate.add(new Contact(Id = idCon));
			}*/
			
			/*if (!lstConsToUpdate.isEmpty()){
				update lstConsToUpdate;
			}*/
			
		} catch (Exception e){
			throw new AuraHandledException(e.getMessage());
		}
	}

}