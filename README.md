# tile-list-search

This is a demo of a common architecture pattern used in Lightning development.

The outer component in this demo is called ArchitectureDemo.cmp.
It provides the wrapper for placement of the integral components,
as well as provided a Label and Icon.

At the top of the layout, we have the SearchBar.cmp, with a scrollable
ContactList.cmp below. The server logic is contained in ContactList.

ContactList.cmp has an init handler that calls the ContactListController.cls, 
findAllContacts() method to pull in a list of all Contacts. With Contacts populated,
ContactList iterates each Contact with ContactTile.cmp for displaying the tiles
in the scrollable list.

To make this demo robust but responsive, ContactList uses incremental loading of records (100 per search)
that is triggered by scrolling to the bottom of the list.

The fastest way to find a record is to use the SearchBar. Each keystroke fires
a component event that is received by ContactList, which handles the event with
helper.searchContactsByKey(), which calls ContactListController.findContactsByKey(). 
This method takes the contact key and searches for that key at the beginning of
Contact firstName, lastName, and Account.Name, returning the result, which is 
assigned to Contacts and displayed in the list.

Cancel the search by clearing the SearchBar input and the list returns to the
previously loaded Contacts list, without a server call. This is done by
cloning the contacts list as it is built, then reverting to the clone when the
search is abandoned.

Clicking anywhere on the ContactTile fire the SelectContact event, with a data
payload of the Contact record. If we were simply passing this back up to ContactList,
a Component event would work. In this demo, I'm using an Application event, which is
received by a separate component on the page, SelectedContact.cmp, which simply
displays selected fields from the record.