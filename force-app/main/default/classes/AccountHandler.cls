public class AccountHandler {
    public static Account insertNewAccount(String name) {
        try {
            Account acct = new Account(Name = name);   
            insert acct;
    
            return acct;
        } catch (DmlException e) {
            return null;
        }
    }
}
