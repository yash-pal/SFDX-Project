public class AccountTriggerHandler {
    public static void CreateAccounts(List<Account> accList){
	for(Account account : acclist)
    {
        if(account.ShippingState!= account.BillingState)
        {
            account.ShippingState=account.BillingState;
        }
    }
    }

}