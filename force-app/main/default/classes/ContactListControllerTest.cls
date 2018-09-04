/**
 * Created by pmcclellan on 2/25/18.
 */

@isTest
private class ContactListControllerTest
{
    /*
    @isTest private static void test_findAllContactsLeadsUsers(){
        Account acc = new Account();
        acc.Name = 'testAccount';
        insert acc;

        Opportunity opportunity = new Opportunity(Name = 'TestOpp', StageName = 'Prospecting', CloseDate = date.today(), AccountId = acc.Id);
        insert opportunity;

        Asset asset = new Asset(Name = 'TestAsset', AccountId = acc.Id);
        insert asset;

        Order order = new Order(Name = 'TestOrder', AccountId = acc.Id, Status = 'Draft', EffectiveDate = date.today());
        insert order;

        List<Contact> Contacts = new List<Contact>();
        for (Integer i=0; i<15; i++ )
        {
            Contact c = new Contact();
            c.LastName = 'test' + i;
            c.FirstName = 'bob';
            c.AccountId = acc.Id;
            if (i<4) {
                c.MobilePhone = '+123456789' + i;
            }
            Contacts.add(c);
        }
        insert Contacts;
        System.debug('inserting Contacts: ' + Contacts.size());

        List<Lead> Leads = new List<Lead>();
        for (Integer i=0; i<15; i++)
        {
            Lead l = new Lead();
            l.LastName = 'leadTest' + i;
            l.FirstName = 'ann';
            l.Company = 'leadCompany' + i;
            l.Status = 'Open - Not Contacted';
            if(i<4) {
                l.MobilePhone = '+1987654321' + i;
            }
            Leads.add(l);
        }
        insert Leads;
        System.debug('inserting Leads: ' + Leads.size());

        List<User> Users = new List<User>();
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        for (Integer i=0; i<10; i++)
        {
                User u = new User();
                u.Alias = 'standt' + i;
                u.Email='standardpig' + i + '@testorg.com';
                u.EmailEncodingKey='UTF-8';
                u.LastName='Testing' + i;
                u.LanguageLocaleKey='en_US';
                u.LocaleSidKey='en_US';
                u.MobilePhone='+1234567800' + i;
                u.ProfileId = p.Id; 
                u.TimeZoneSidKey='America/Los_Angeles';
                u.UserName= DateTime.now().getTime() + i + '@testpig.com'; 
                Users.add(u);
        }
        insert Users;

        List<List<SObject>> testContactsLeadsUsers = ContactListController.findAllContactsLeadsUsers(Users[0].Id);
        System.debug('testContactsLeadsUsers: ' + testContactsLeadsUsers);
        List<Contact> testContacts = testContactsLeadsUsers[0];
        List<Lead> testLeads = testContactsLeadsUsers[1];
        List<User> testUsers = testContactsLeadsUsers[2];
        System.debug('testContacts: ' + testContacts.size());
        System.debug('testLeads: ' + testLeads.size());
        System.assert(testContacts.size()== 4);
        System.assert(testLeads.size()== 4);
        System.assert(testUsers.size()==5);

        List<List<SObject>> testCLUForAccount = ContactListController.findAllContactsLeadsUsers(acc.Id);
        List<Contact> testContactsForAccount = testCLUForAccount[0];
        System.debug('testContactsForAccount: ' + testContactsForAccount.size());
        System.assert(testContactsForAccount.size() == 4);

        List<List<SObject>> testCLUForAsset = ContactListController.findAllContactsLeadsUsers(asset.Id);
        testContactsForAccount = testCLUForAsset[0];
        System.debug('testContactsForAccount: ' + testContactsForAccount.size());
        System.assert(testContactsForAccount.size() == 4);

        List<List<SObject>> testCLUForOpportunity = ContactListController.findAllContactsLeadsUsers(opportunity.Id);
        testContactsForAccount = testCLUForOpportunity[0];
        System.debug('testContactsForAccount: ' + testContactsForAccount.size());
        System.assert(testContactsForAccount.size() == 4);

        List<List<SObject>> testCLUForOrder = ContactListController.findAllContactsLeadsUsers(order.Id);
        testContactsForAccount = testCLUForOrder[0];
        System.debug('testContactsForAccount: ' + testContactsForAccount.size());
        System.assert(testContactsForAccount.size() == 4);


    }

    @isTest private static void test_findContactsLeadsUsers(){
        List<Contact> Contacts = new List<Contact>();
        for (Integer i=0; i<5; i++ )
        {
            Contact c = new Contact();
            c.LastName = 'testContact' + i;
            c.MobilePhone = '+1234567890'+ i;
            Contacts.add(c);
        }
        for (Integer i=0; i<4; i++ )
        {
            Contact c = new Contact();
            c.LastName = 'testContactKey' + i;
            c.MobilePhone = '+1098765432'+ i;
            Contacts.add(c);
        }
        for (Integer i=0; i<5; i++)
        {
            Contact c = new Contact();
            c.LastName = 'testContactNoMobileKey' + i;
            Contacts.add(c);
        }
        insert Contacts;

        List<Lead> Leads = new List<Lead>();
        for (Integer i=0; i<5; i++)
        {
            Lead l = new Lead();
            l.LastName = 'leadTest' + i;
            l.Company = 'leadCompany' + i;
            l.Status = 'Open - Not Contacted';
            l.MobilePhone = '+1123456789' + i;
            Leads.add(l);
        }
        for (Integer i=0; i<4; i++)
        {
            Lead l = new Lead();
            l.LastName = 'leadTestKey' + i;
            l.Company = 'leadCompany' + i;
            l.Status = 'Open - Not Contacted';
            l.MobilePhone = '+1987654321' + i;
            Leads.add(l);
        }
        for (Integer i=0; i<5; i++)
        {
            Lead l = new Lead();
            l.LastName = 'leadTestNoMobileKey' + i;
            l.Company = 'leadCompany' + i;
            l.Status = 'Open - Not Contacted';
            Leads.add(l);
        }
        insert Leads;
        List<User> Users = new List<User>();
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        for (Integer i=0; i<5; i++) //mobile no 'key'
        {
                User u = new User(Alias = 'standt' + i, Email='standarduser' + i + '@testorg.com',
                EmailEncodingKey='UTF-8', LastName='Testing' + i, LanguageLocaleKey='en_US',
                LocaleSidKey='en_US', MobilePhone='+1234567800' + i, ProfileId = p.Id, 
                TimeZoneSidKey='America/Los_Angeles',
                UserName= DateTime.now().getTime() + '@testorg' + i +'.com'); 
                Users.add(u);
        }
        for (Integer i=5; i<9; i++) //'key' with mobile
        {
                User u = new User(Alias = 'standt' + i, Email='standarduser' + i + '@testorg.com',
                EmailEncodingKey='UTF-8', LastName='TestKey' + i, LanguageLocaleKey='en_US',
                LocaleSidKey='en_US', MobilePhone='+1234567800' + i, ProfileId = p.Id, 
                TimeZoneSidKey='America/Los_Angeles',
                UserName= DateTime.now().getTime() + '@testorg' + i +'.com'); 
                Users.add(u);
        }
        for (Integer i=9; i<14; i++) //'key' no mobile
        {
                User u = new User(Alias = 'standt' + i, Email='standarduser' + i + '@testorg.com',
                EmailEncodingKey='UTF-8', LastName='TestKeyNoMobile' + i, LanguageLocaleKey='en_US',
                LocaleSidKey='en_US', ProfileId = p.Id, 
                TimeZoneSidKey='America/Los_Angeles',
                UserName=DateTime.now().getTime() + '@testorg' + i +'.com'); 
                Users.add(u);
        }
        insert Users;
        
        List<List<SObject>> testContactsLeadsUsers = ContactListController.findContactsLeadsUsers('Key');
        List<Contact> testContacts = testContactsLeadsUsers[0];
        List<Lead> testLeads = testContactsLeadsUsers[1];
        List<User> testUsers = testContactsLeadsUsers[2];
        System.assert(testContacts.size()== 4);
        System.assert(testLeads.size()== 4);
        System.assert(testUsers.size()== 4);
    }

    @isTest private static void test_searchAssets(){
        Account acc = new Account();
        acc.name = 'testAccName';
        insert acc;

        List<Asset> assets = new List<Asset>();
        for (integer i = 0; i<10; i++)
        {
            assets.add(new Asset(Name = 'TestAsset' + i, AccountId = acc.Id));
        }
        insert assets;
        System.assertEquals(10, ContactListController.findAssetByAccountId(acc.Id).size());
        System.assertEquals(1, ContactListController.searchAssets('set3').size());
    }

    @isTest private static void test_searchCampaigns(){
        List<Campaign> Campaigns = new List<Campaign>();
        for (integer i = 0; i<10; i++)
        {
            Campaigns.add(new Campaign(Name = 'TestCampaign' + i));
        }
        insert Campaigns;
        System.assertEquals(10, ContactListController.findCampaignByLastViewed().size());
        System.assertEquals(1, ContactListController.searchCampaigns('ign3').size());
    }

    @isTest private static void test_findCaseByAccountId(){
        //also tests searchCases()
        List<Account> Accounts = new List<Account>();
        Account acc = new Account();
        acc.Name = 'redAccount';
        Accounts.add(acc);
        Account acc2 = new Account();
        acc2.Name = 'blueAccount';
        Accounts.add(acc2);
        insert Accounts;
        List<Case> Cases = new List<Case>();
        for(Integer i = 0; i<7; i++)
        {
            Case c = new Case();
            c.Status = 'New';
            c.Origin = 'Phone';
            c.Subject = 'testSubject' + i;
            if (i<4) {
                c.AccountId = Accounts[0].Id; //redAccount
            }else {
                c.AccountId = Accounts[1].Id; //blueAccount
            }
            Cases.add(c);
        }
        Insert Cases;
        if(!Case.SObjectType.getDescribe().isAccessible()) {
            System.debug('😀 Asserts (Case) not accessible');
            System.assertEquals(null, ContactListController.findCaseByAccountId(Accounts[0].Id));
            System.assertEquals(null, ContactListController.searchCases('blue').size());
        }else {
            System.debug('😀 Asserts (Case) accessible');
            System.assertEquals(4, ContactListController.findCaseByAccountId(Accounts[0].Id).size());
            System.assertEquals(3, ContactListController.searchCases('blue').size());
        }
    }

    @isTest private static void test_searchContracts(){
        List<Account> Accounts = new List<Account>();
        Accounts.add(new Account(Name='red'));
        Accounts.add(new Account(Name='blue'));
        insert Accounts;
        List<Contract> Contracts = new List<Contract>();
        for (integer i = 0; i < 5; i++)
        {
            Contracts.add(new Contract(Name = 'TestContract' + i, AccountId=Accounts[0].Id, Status='Draft', StartDate= date.today(), ContractTerm = 4 ));
        }
        for (integer i = 5; i < 10; i++)
        {
            Contracts.add(new Contract(Name = 'TestContract' + i, AccountId=Accounts[1].Id, Status='Draft', StartDate= date.today(), ContractTerm = 4 ));
        }
        insert Contracts;
        System.assertEquals(5, ContactListController.findContractByAccountId(Accounts[0].Id).size());
        System.assertEquals(5, ContactListController.searchContracts('blue').size());
    }

    @isTest private static void test_findOpportunityByAccountId(){
        // also tests searchOpps()
        List<Account> Accounts = new List<Account>();
        Account acc = new Account();
        acc.Name = 'redAccount';
        Accounts.add(acc);
        Account acc2 = new Account();
        acc2.Name = 'blueAccount2';
        Accounts.add(acc2);
        insert Accounts;
        List<Opportunity> Opportunities = new List<Opportunity>();
        for(Integer i = 0; i<7; i++)
        {
            Opportunity opp = new Opportunity();
            opp.Name = 'testOpp' + i;
            opp.StageName = 'Prospecting';
            opp.CloseDate = date.today() + 4;
            if (i<4) {
                opp.AccountId = Accounts[0].Id;
            }else {
                opp.AccountId = Accounts[1].Id;
            }
            Opportunities.add(opp);
        }
        Insert Opportunities;

        if(!Opportunity.SObjectType.getDescribe().isAccessible()) {
            System.debug('😀 Asserts (opps) not accessible');
            System.assertEquals(null, ContactListController.findOpportunityByAccountId(Accounts[0].Id));
            System.assertEquals(null, ContactListController.searchOpps('blue').size());
        }else {
            System.debug('😀 Asserts (opps) accessible');
            System.assertEquals(4, ContactListController.findOpportunityByAccountId(Accounts[0].Id).size());
            System.assertEquals(3, ContactListController.searchOpps('blue').size());
        }
    }

    @isTest private static void test_searchOrders(){
        Account acc = new Account();
        acc.name = 'testAccName';
        insert acc;

        Contract contract = new Contract(Name = 'TestContract', AccountId=acc.Id, Status='Draft', StartDate= date.today(), ContractTerm = 4 );
        insert contract;

        List<Order> Orders = new List<Order>();
        for (integer i = 0; i<10; i++)
        {
            Orders.add(new Order(Name = 'TestOrder' + i, AccountId = acc.Id, Status = 'Draft', EffectiveDate = date.today()));
        }
        insert Orders;
        System.assertEquals(10, ContactListController.findOrderByAccountId(acc.Id).size());
        System.assertEquals(1, ContactListController.searchOrders('der3').size());
    }

    @isTest private static void test_searchProduct2s(){
        List<Product2> Products = new List<Product2>();
        for (integer i = 0; i<15; i++)
        {
            Products.add(new Product2(Name = 'TestProduct' + i));
        }
        insert Products;
        System.assertEquals(10, ContactListController.findProduct2ByLastViewed().size());
        System.assertEquals(1, ContactListController.searchProduct2s('uct3').size());
    }

     @isTest private static void test_RecordLinkList(){
        Account acc = new Account(Name = 'testAcc');
        insert acc;
        List<Contact> Contacts = new List<Contact>();
        for (Integer i=0; i<10; i++ )
        {
            Contact c = new Contact();
            c.LastName = 'testContact' + i;
            c.MobilePhone = '+1234567890'+ i;
            c.Account = acc;
            Contacts.add(c);
        }
        insert Contacts;
        Conversation__c cv = new Conversation__c();
        cv.Group_Name__c = 'testGroupName';
        cv.OurFromNumber__c = '+15556667777';
        insert cv; // insert so new member records can reference the Id
        List<Member__c> Members = new List<Member__c>();
        for (Integer i=0; i<15; i++)
        {
            Member__c m = new Member__c();
            m.Conversation__c = cv.Id;
            if(i<9){
                m.Contact__c = Contacts[i].Id; // Members 0-8 are linked to Contacts 0-8
            }else{
                m.Contact__c = Contacts[9].Id; // Members 9-14 are linked to Contact 9
            }
            Members.add(m);
        }
        insert Members;
        String memberName = [SELECT Name FROM Member__c LIMIT 1].Name;
        String searchKey = memberName.right(3);
        System.assertEquals(15, ContactListController.findRecordsByRecordId(cv.Id, 'Member__c').size());
        System.assertEquals(1, ContactListController.searchRecords(searchKey,'Member__c').size());
     }
*/
}