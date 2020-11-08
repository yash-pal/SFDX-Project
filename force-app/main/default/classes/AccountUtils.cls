public class AccountUtils {
    public static List<Account> accountsByState(String s){
        List<Account> acctList = [SELECT ID, Name FROM Account WHERE billingState = :s];
        return acctList;
    }

}