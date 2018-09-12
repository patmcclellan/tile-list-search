/**
 * Created by pmcclellan on 2/25/18.
 */

@isTest
private class ContactListControllerTest
{
    
    @isTest private static void test_ContactListController(){
        List<Account> accounts = new List<Account>();
        for (integer i=0; i<10; i++)
        {
            accounts.add(new Account(Name='account' + i));
        }
        insert accounts;

        List<Contact> contacts = new List<Contact>();
        for (Integer i=0; i<40; i++ )
        {
            Contact c = new Contact();
            c.LastName = i + 'test';
            c.FirstName = 'bob' + i;
            c.AccountId = accounts[Math.mod(i,10)].Id;
            contacts.add(c);
        }
        insert contacts;

        System.assertEquals(40,ContactListController.getContactsCount(''));

        List<Contact> nullRecContacts = ContactListController.findAllContacts('0', '');
        System.assertEquals(40,nullRecContacts.size());

        String recId1 = Contacts[3].id;
        List<Contact> allContacts = ContactListController.findAllContacts('0', recId1);
        System.assertEquals(40,allContacts.size());

        String recId2 = accounts[1].id;
        System.assertEquals(4,ContactListController.getContactsCount(recId2));
        List<Contact> accountContacts = ContactListController.findAllContacts('0', recId2);
        System.assertEquals(4,accountContacts.size());

        List<Contact> searchContacts1 = ContactListController.findContactsByKey('0');
        System.assertEquals(1, searchContacts1.size()); //only 1 contact with name beginning with '0'

        List<Contact> searchContacts2 = ContactListController.findContactsByKey('bob3');
        System.assertEquals(11, searchContacts2.size()); // bob3, bob30...39
    }
}