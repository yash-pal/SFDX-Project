trigger updateAccount on Account (after insert) {
    Contact con = new Contact();
    con.AccountId = Trigger.new[0].Id;
    con.LastName = Trigger.new[0].name;
    insert con;
    system.debug('yash'+ con.LastName);

}