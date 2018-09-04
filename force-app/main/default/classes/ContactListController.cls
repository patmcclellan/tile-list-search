/**
 * Created by pmcclellan on 09/04/18
 */

public with sharing class ContactListController {

    //used by ContactList.cmp
    @AuraEnabled
    public static List<Contact> findAllContacts(String recordId) {
        if (recordId != null && recordId.left(3) == Schema.SObjectType.Account.getKeyPrefix()) // it's an Account record
        {
            return getContactsForAccount(recordId);
        } else {
            if (Contact.SObjectType.getDescribe().isAccessible()) {
                return [
                    SELECT id, Name, Title, Account.Name, FirstName
                    FROM Contact
                    ORDER BY LastName ASC
                    LIMIT 30
                ];
            }
        }
        return null;
    }

    // called by findAllContacts() when recordId is an accountId
    private static List<Contact> getContactsForAccount(String recordId)
    {
        List<Contact> Contacts = new List<Contact>();
        if (Contact.SObjectType.getDescribe().isAccessible()) {
            return [
                SELECT id, Name, Title, Account.Name, FirstName
                FROM Contact
                WHERE AccountId = :recordId
                ORDER BY LastName ASC
                LIMIT 30
            ];
        }
        return null;
    }

    //used by ContactList.cmp
    @AuraEnabled
    public static List<Contact> findContactsByKey(String searchKey) {
        String name = '%' + searchKey + '%';
        if (Contact.SObjectType.getDescribe().isAccessible()) {
            return [
                SELECT id, Name, Title, Account.Name, FirstName
                FROM Contact
                WHERE name LIKE :name OR Account.Name LIKE :name
                ORDER BY LastName ASC
                LIMIT 10];
        }
        return null;
    }
}
