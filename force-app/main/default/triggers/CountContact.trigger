trigger CountContact on Contact (after insert, after update ,after delete ,after undelete) { 
    
    CountContactHandler.TotalCount(Trigger.IsInsert,Trigger.IsUpdate,Trigger.IsDelete,Trigger.Isundelete,Trigger.new ,Trigger.old);
   
}