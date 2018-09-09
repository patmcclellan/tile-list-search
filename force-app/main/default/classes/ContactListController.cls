/**
 * Created by pmcclellan on 09/04/18
 */

public with sharing class ContactListController {

    //used by ContactList.cmp
    @AuraEnabled
    public static List<Contact> findAllContacts(String offset, String recordId) {
        if (recordId == null) 
        {
            return getConListNoRecordId(offset);
        } else if (recordId.Left(3) == Schema.SObjectType.Account.getKeyPrefix()) //it's an Account record
        {  
            system.debug('Looking for contacts by account: ' + recordId);
            return getConListForAccount(recordId);
        }
        return null;
    }
    
    @AuraEnabled
    public static Integer getContactsCount(String recordId) 
    {
        if (recordId == null) 
        {
            return [SELECT Count() FROM Contact ];
        } else if (recordId.Left(3) == Schema.SObjectType.Account.getKeyPrefix()) //it's an Account record
        {  
            return [SELECT Count() FROM Contact WHERE AccountId =: recordId];
        }
        return null;
    }

    //used by ContactList.cmp
    @AuraEnabled
    public static List<Contact> findContactsByKey(String searchKey) {
        String name = '%' + searchKey + '%';
        if (Contact.SObjectType.getDescribe().isAccessible()) {
            return [
                SELECT id, Name, Title, Account.Name, Phone, Email
                FROM Contact
                WHERE name LIKE :name OR Account.Name LIKE :name
                ORDER BY LastName ASC
                LIMIT 50];
        }
        return null;
    }

    


/*-------------------------------------------------------------------------------------*/

    private static List<Contact> getConListNoRecordId(String offset)
    {
        integer offsetI = integer.valueOf(offset);
        return [SELECT Id, Name, Title, Account.Name, Phone, Email
                FROM Contact
                ORDER by LastName
                LIMIT 50 
                OFFSET :offsetI];
    }

    // called by findAllContacts() when recordId is an accountId
    private static List<Contact> getConListForAccount(String recordId)
    {
        List<Contact> Contacts = new List<Contact>();
        if (Contact.SObjectType.getDescribe().isAccessible()) {
            return [
                SELECT id, Name, Title, Account.Name, Phone, Email
                FROM Contact
                WHERE AccountId = :recordId
                ORDER BY LastName ASC
            ];
        }
        return null;
    }
}
