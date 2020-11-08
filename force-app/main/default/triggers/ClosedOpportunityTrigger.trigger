trigger ClosedOpportunityTrigger on Opportunity (after insert, after update){
    List<Task> listTask = new List<Task>();
    for(Opportunity occ: Trigger.new)
    {
        if(occ.StageName == 'Closed Won' && ( trigger.isInsert || (trigger.isUpdate && trigger.oldMap.get(occ.Id).StageName != 'Closed Won') ))
        {
            Task t = new Task();
            t.Subject='Follow up Task';
            t.WhatId=occ.Id;
            listTask.add(t);
        }
    }
    if(listTask.size() > 0){
        insert listTask;
    }
}