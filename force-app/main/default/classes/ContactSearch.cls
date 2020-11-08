public class ContactSearch {
    public static List<Contact> searchForContacts(String s, String sh){
        return [SELECT LastName,MailingPostalCode FROM Contact ORDER BY LastName, MailingPostalCode DESC];
    } 

}