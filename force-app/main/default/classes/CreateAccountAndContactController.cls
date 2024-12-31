// CreateAccountAndContactController.cls
public with sharing class CreateAccountAndContactController {
    @AuraEnabled(cacheable=false)
    public static void createAccountAndContact(String accountName, String contactFirstName, String contactLastName) {
        try {
            // Create Account
            Account acc = new Account(Name = accountName);
            insert acc;

            // Create Contact
            Contact con = new Contact(FirstName = contactFirstName, LastName = contactLastName, AccountId = acc.Id);
            insert con;
        } catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
}