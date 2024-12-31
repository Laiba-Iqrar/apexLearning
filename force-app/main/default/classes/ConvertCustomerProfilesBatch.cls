global class ConvertCustomerProfilesBatch implements Database.Batchable<sObject>, Database.Stateful {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([
            SELECT Id, Name, Phone__c, City__c, Converted__c, Duplicate_Identifier__c 
            FROM Customer_Profile__c
        ]);
    }

    global void execute(Database.BatchableContext bc, List<Customer_Profile__c> scope) {
        List<Account> accountsToInsert = new List<Account>();
        List<Junction_Object__c> junctionObjectsToInsert = new List<Junction_Object__c>();
        Set<String> profileIdentifiers = new Set<String>();
        
        //  map of existing Accounts
        Map<String, Account> existingAccountsMap = new Map<String, Account>();
        for (Account acc : [SELECT Id, Duplicate_Identifier__c FROM Account]) {
            existingAccountsMap.put(acc.Duplicate_Identifier__c, acc);
        }
        
        // Iterate  Customer Profiles
        for (Customer_Profile__c cp : scope) {
            String profileIdentifier = generateProfileIdentifier(cp);
            
            // Check if a duplicate Account already exists
            if (existingAccountsMap.containsKey(profileIdentifier)) {
                cp.Duplicate__c = true;
                
                // Create a Junction Object record
                Junction_Object__c junction = new Junction_Object__c();
                junction.Account__c = existingAccountsMap.get(profileIdentifier).Id;
                junction.Customer_Profile__c = cp.Id;
                junctionObjectsToInsert.add(junction);
            } else {
                // Create a new Account and mark Customer Profile as converted
                Account acc = new Account(
                    Name = cp.Name,
                    Phone = cp.Phone__c,
                    BillingCity = cp.City__c
                    // Populate other relevant fields from Customer Profile
                );
                accountsToInsert.add(acc);
                
                cp.Converted__c = true;
                cp.Account__c = acc.Id;
                
                // Add profile identifier to set for checking duplicates
                profileIdentifiers.add(profileIdentifier);
            }
        }
        
        // Insert Account records
        if (!accountsToInsert.isEmpty()) {
            insert accountsToInsert;
        }
        
        // Insert Junction Object records
        if (!junctionObjectsToInsert.isEmpty()) {
            insert junctionObjectsToInsert;
        }
        
        update scope;
    }

    global void finish(Database.BatchableContext bc) {
    }
    
    // Helper method to generate profile identifier
    private String generateProfileIdentifier(Customer_Profile__c cp) {
        return cp.Name + '-' + cp.Phone__c + '-' + cp.City__c;
    }
}