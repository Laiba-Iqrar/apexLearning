public class AddPrimaryContact implements Queueable {
    private Contact contact;
    private String state;
    public AddPrimaryContact(Contact contact, String state) {
        this.contact = contact;
        this.state = state;
    }
    public void execute(QueueableContext context) {
        List<Account> accounts = [Select Id from Account where BillingState = :this.state LIMIT 200];
        List<Contact> newContacts = new List<Contact>();
        for (account a : accounts) {
            Contact newContact = contact.clone();
            newContact.AccountId = a.Id;
            newContacts.add(newContact);
        }
        insert newContacts;

        
    }
}