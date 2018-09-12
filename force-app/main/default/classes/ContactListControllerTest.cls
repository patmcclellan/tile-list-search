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

        List<Contact> Contacts = new List<Contact>();
        for (Integer i=0; i<40; i++ )
        {
            Contact c = new Contact();
            c.LastName = i + 'test';
            c.FirstName = 'bob' + i;
            c.AccountId = accounts[Math.mod(i,10)].Id;
            Contacts.add(c);
        }
        insert Contacts;

        List<Contact> allContacts = ContactListController.findAllContacts(null);
        System.assertEquals(40,allContacts.size());
    
        List<Contact> accountContacts = ContactListController.findAllContacts(accounts[1].Id);
        System.assertEquals(4,accountContacts.size());

        List<Contact> searchContacts1 = ContactListController.findContactsByKey('0');
        System.assertEquals(1, searchContacts1.size()); //only 1 contact with name beginning with '0'

        List<Contact> searchContacts2 = ContactListController.findContactsByKey('bob3');
        System.assertEquals(11, searchContacts2.size()); // bob3, bob30...39
    }
}