public class ContactSearch {
    /**
     * Searches for contacts based on last name and mailing postal code.
     *
     * @param lastName The last name to match.
     * @param postalCode The mailing postal code to match.
     * @return A list of Contact records with ID and Name fields.
     */
    public static List<Contact> searchForContacts(String lastName, String postalCode) {
        // Validate incoming parameters
        if (String.isBlank(lastName) || String.isBlank(postalCode)) {
            // Return an empty list if either parameter is blank or null
            return new List<Contact>();
        }

        // Query for contacts matching the criteria
        List<Contact> contacts = [
            SELECT Id, Name
            FROM Contact
            WHERE LastName = :lastName AND MailingPostalCode = :postalCode
        ];

        // Return the list of contacts
        return contacts;
    }
}
