public class abc {
    
    @InvocableMethod(label='Handle Closed Won')
    public static void handleClosedWon(List<Opportunity> newOpportunities) {
        // Map to store the account IDs of opportunities transitioning to 'Closed Won'
        Set<Id> accountIds = new Set<Id>();

        // Retrieve old opportunities data
        //Map<Id, Opportunity> oldOppMap = new Map<Id, Opportunity>([SELECT Id, StageName, AccountId FROM Opportunity WHERE Id IN :newOpportunities]);

		for (Opportunity newOpp : newOpportunities) {
          //  Opportunity oldOpp = oldOppMap.get(newOpp.Id);

            // Checking if the stage changed to Closed Won
            if (newOpp.StageName == 'Closed Won' && newOpp.AccountId != null) {
                // Add the account ID to the set
                
                accountIds.add(newOpp.AccountId);
            }
        }

        // Query for related contacts for all identified account IDs
        Map<Id, List<Contact>> accountToContactsMap = new Map<Id, List<Contact>>();
        for (Contact contact : [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIds]) {
            if (!accountToContactsMap.containsKey(contact.AccountId)) {
                accountToContactsMap.put(contact.AccountId, new List<Contact>());
            }
            accountToContactsMap.get(contact.AccountId).add(contact);
        }

        // List of Opportunity Contact Role records to be inserted
        List<OpportunityContactRole> ocrList = new List<OpportunityContactRole>();

        for (Opportunity newOpp : newOpportunities) {
            if (accountToContactsMap.containsKey(newOpp.AccountId)) {
                List<Contact> relatedContacts = accountToContactsMap.get(newOpp.AccountId);
                for (Contact con : relatedContacts) {
                    OpportunityContactRole ocr = new OpportunityContactRole();
                    ocr.OpportunityId = newOpp.Id;
                    ocr.ContactId = con.Id;
                    ocrList.add(ocr);
                }
            }
        }

        // Inserting Opportunity Contact Roles
        if (!ocrList.isEmpty()) {
            insert ocrList;
        }
    }
}