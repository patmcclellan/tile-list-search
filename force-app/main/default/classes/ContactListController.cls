/**
 * Created by pmcclellan on 09/04/18
 */

public with sharing class ContactListController {

    //used by ContactList.cmp
    @AuraEnabled
    public static List<Contact> findAllContacts(String offset, String recordId) {
       if (recordId.Left(3) == Schema.SObjectType.Account.getKeyPrefix()) //it's an Account record
        {  
            system.debug('Looking for contacts by account: ' + recordId);
            return getConListForAccount(recordId);
        }else {
            return getConListNoRecordId(offset);
        }
    }
    
    @AuraEnabled
    public static Integer getContactsCount(String recordId) 
    {
        if (recordId.Left(3) == Schema.SObjectType.Account.getKeyPrefix()) //it's an Account record
        {  
            return [SELECT Count() FROM Contact WHERE AccountId =: recordId];
        } else
        {        
            return [SELECT Count() FROM Contact ];
        }

    }

    //used by ContactList.cmp
    @AuraEnabled
    public static List<Contact> findContactsByKey(String searchKey) {
        List<Contact> Contacts = new List<Contact>();
        String name = searchKey + '%';
        if (Contact.SObjectType.getDescribe().isAccessible()) {
            Contacts = [
                SELECT id, Name, Title, Account.Name, Phone, Email
                FROM Contact
                WHERE FirstName LIKE :name OR LastName LIKE :name OR Account.Name LIKE :name
                ORDER BY LastName ASC
                LIMIT 30];
        }
        return Contacts;
    }

    


/*-------------------------------------------------------------------------------------*/

    private static List<Contact> getConListNoRecordId(String offset)
    {
        integer offsetI = integer.valueOf(offset);
        return [SELECT Id, Name, Title, Account.Name, Phone, Email
                FROM Contact
                ORDER by LastName
                LIMIT 100 
                OFFSET :offsetI];
    }

    // called by findAllContacts() when recordId is an accountId
    private static List<Contact> getConListForAccount(String recordId)
    {
        List<Contact> Contacts = new List<Contact>();
        if (Contact.SObjectType.getDescribe().isAccessible()) {
            Contacts = [
                SELECT id, Name, Title, Account.Name, Phone, Email
                FROM Contact
                WHERE AccountId = :recordId
                ORDER BY LastName ASC
            ];
        }
        return Contacts;
    }
}
