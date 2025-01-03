public with sharing class AccountProcessor {
    @future(callout=true)
    public static void  countContacts(list<id> accIds) {

        List<Account> accList = [select id,Number_of_Contacts__c, (select id from contacts ) from account where id in :accIds];

        for (account a :accList){
            list<Contact> conList = a.contacts;

            a.Number_of_Contacts__c = conList.size();
        }
        update accList;

    }
}