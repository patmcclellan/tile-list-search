# tile-list-search

This is a demo of a common architecture pattern used in Lightning development.
For this example, I'm using a common object, Contacts, though it works with
any standard or custom object with a little modification.

The outer component, ArchitectureDemo.cmp provides the Label, Icon and wrapper for  
the integral components, SearchBar.cmp and ContactList.cmp. The server logic is 
contained in ContactList, which designates its controller=ContactListController.

ContactList.cmp has an init handler that calls findAllContacts() to pull in a 
list of all Contacts. With Contacts populated, ContactList iterates each Contact 
with ContactTile.cmp for displaying the tiles in the scrollable list.

To make this demo robust but responsive, ContactList uses incremental loading 
of records (100 per search) that is triggered by scrolling to the bottom of the list.
Each subsequent server pull is concatenated onto the existing Contacts list, so 
there's no redundant search.

The fastest way to find a record is to use the SearchBar. Each keystroke fires
a component event that is received by ContactList, which handles the event with
helper.searchContactsByKey() calling ContactListController.findContactsByKey(). 
This method takes the SearchBar input and searches for that key at the beginning of
Contact firstName, lastName, and Account.Name, returning the resulting list, which is 
assigned to Contacts and passed on in iteration to ContactTile.cmp.

Cancel the search by clearing the SearchBar input and the list returns to the
previously loaded Contacts list, without a server call. This is done by
cloning the contacts list as it is built, then reverting to the clone when the
search is abandoned.

Clicking anywhere on the ContactTile fire the SelectContact event, with a data
payload of the Contact record. If we were simply passing this back up to ContactList,
a Component event would work. In this demo, I'm using an Application event, which is
received by a separate component on the page, SelectedContact.cmp, which simply
displays selected fields from the record.