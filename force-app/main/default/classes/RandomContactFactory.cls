public with sharing class RandomContactFactory {
    public  static  List<Contact> generateRandomContacts(integer num, string lastName) {
            List<Contact> conts = new List<Contact>();

            for(Integer i = 0; i < num; i++) {
                Contact cont = new Contact(FirstName = 'Test ' + i, LastName = lastName);
                conts.add(cont);
            }
            insert conts;
            return conts;
    }
}