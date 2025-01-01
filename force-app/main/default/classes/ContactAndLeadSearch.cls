public class ContactAndLeadSearch {
    /**
     * Searches for contacts and leads based on a given name (first or last).
     *
     * @param name The name to search for.
     * @return A list containing two lists: one of contacts and one of leads.
     */
    public static List<List<SObject>> searchContactsAndLeads(String name) {
        // Validate the incoming parameter
        if (String.isBlank(name)) {
            // Return empty lists if the parameter is blank or null
            return new List<List<SObject>> {
                new List<SObject>(), // Empty contact list
                new List<SObject>()  // Empty lead list
            };
        }

        // Perform a SOSL search for contacts and leads matching the name
        List<List<SObject>> searchResults = [
            FIND :name IN Name Fields
            RETURNING Contact (Id, Name), Lead (Id, Name)
        ];

        // Ensure the result is always two lists (contacts and leads)
        List<SObject> contacts = (searchResults.size() > 0) ? searchResults[0] : new List<SObject>();
        List<SObject> leads = (searchResults.size() > 1) ? searchResults[1] : new List<SObject>();

        return new List<List<SObject>> { contacts, leads };
    }
}
