public class OpportunityFlowHandler {
    @InvocableMethod(label='Add Opportunity Contact Roles')
    public static void addOpportunityContactRoles(List<Id> accountIds) {
        List<OpportunityContactRole> oppContactRoles = new List<OpportunityContactRole>();
        
        for (Id accId : accountIds) {
            List<Contact> contactsToAdd = [SELECT Id FROM Contact WHERE AccountId = :accId];
            
            for (Contact con : contactsToAdd) {
                oppContactRoles.add(new OpportunityContactRole(
                    OpportunityId = accId,
                    ContactId = con.Id,
                    Role = 'Decision Maker' // Set the appropriate role here
                ));
            }
        }
        
        if (!oppContactRoles.isEmpty()) {
            insert oppContactRoles;
        }
    }
}