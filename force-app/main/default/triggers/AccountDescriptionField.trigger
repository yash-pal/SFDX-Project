trigger AccountDescriptionField on Contact (after insert,after update,after delete,after undelete) {
    
    Set<Id> accId = new set<Id>();
    if(Trigger.isInsert || trigger.isUpdate){
        for(Contact co :Trigger.new){
            accId.add(co.AccountId);
        }
    }
    if(Trigger.isUpdate || trigger.isdelete){
        for(Contact co:trigger.old){
            accId.add(co.AccountId);
        }
    }
    
    List<Account> UpdateDes = new List<Account>();
    for(Account ac:[select Id,Name,Description,(select Id,FirstName,LastName From Contacts)From Account where Id IN:accId]){
        
        List<String> dfString = new List<String>();
        for(Contact con :ac.contacts ){
            if(con.LastName != null){
                dfString.add(con.LastName);
            }
            ac.Description = String.join(dfstring, ',');
        } 
        updateDes.add(ac);
    } 
    if(updateDes.size() >0)
    update updateDes;
    
}