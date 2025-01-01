trigger RestrictContactByName on Contact (before insert, before update) {
    // Check contacts prior to insert or update for invalid data
    for (Contact c : Trigger.New) {
        if (c.LastName == 'INVALIDNAME') {
            // INVALIDNAME is not allowed as a last name
            c.addError('The Last Name "' + c.LastName + '" is not allowed for DML');
        }
    }
}
