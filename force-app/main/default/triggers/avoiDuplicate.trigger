trigger avoiDuplicate on Account (before insert) {
    for(Account a : Trigger.new){
        for(Account a1 : [select Id,name from Account])
        {
            if(a.name == a1.name){
                a.name.addError('This is a duplicate Name');
            }
        }
    }
    
}