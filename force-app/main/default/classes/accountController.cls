public with sharing class accountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        return [SELECT Id, Name, Phone, Website FROM Account WITH USER_MODE LIMIT 10];
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> findAccounts(String searchKey) {
        String key = '%' + searchKey + '%';
        return [
            SELECT Id, Name, Phone, Website
            FROM Account
            WHERE Name LIKE :key 
            WITH USER_MODE
            LIMIT 200
        ];
    }
}