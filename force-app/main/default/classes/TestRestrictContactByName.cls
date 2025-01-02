@isTest
public class TestRestrictContactByName {

    @isTest
    static void testInsertInvalidLastName() {
        // Test Case: Attempt to insert a contact with an invalid last name
        Contact invalidContact = new Contact(FirstName = 'John', LastName = 'INVALIDNAME');
        
        Test.startTest();
        // Attempt the DML operation and verify it fails
        try {
            insert invalidContact;
            System.assert(false, 'Expected an exception when inserting a contact with INVALIDNAME as LastName');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('The Last Name "INVALIDNAME" is not allowed for DML'),
                'Expected error message for invalid last name');
        }
        Test.stopTest();
    }

    @isTest
    static void testUpdateInvalidLastName() {
        // Test Case: Attempt to update a contact to have an invalid last name
        Contact validContact = new Contact(FirstName = 'Jane', LastName = 'Doe');
        insert validContact;

        validContact.LastName = 'INVALIDNAME';
        
        Test.startTest();
        // Attempt the DML operation and verify it fails
        try {
            update validContact;
            System.assert(false, 'Expected an exception when updating a contact to INVALIDNAME as LastName');
        } catch (DmlException e) {
            System.assert(e.getMessage().contains('The Last Name "INVALIDNAME" is not allowed for DML'),
                'Expected error message for invalid last name');
        }
        Test.stopTest();
    }

    @isTest
    static void testValidLastName() {
        // Test Case: Verify successful DML operations for valid last names
        Contact validContact = new Contact(FirstName = 'Alice', LastName = 'Smith');

        Test.startTest();
        insert validContact;
        validContact.LastName = 'Johnson';
        update validContact;
        Test.stopTest();

        // Verify no errors and the record was successfully modified
        Contact updatedContact = [SELECT LastName FROM Contact WHERE Id = :validContact.Id];
        System.assertEquals('Johnson', updatedContact.LastName, 'Expected the LastName to be updated successfully');
    }
}
