({
    findAllContacts : function(component, event, helper)
    {
        if (component.get("v.totalContacts")>=parseInt(component.get("v.offset")))
        {
            var spinner = component.find("spinner");
            $A.util.toggleClass(spinner, "slds-hide");
            var offset =  component.get("v.offset");
            var findAllContacts = component.get("c.findAllContacts");
            findAllContacts.setStorable();
            findAllContacts.setParams({
                'offset' : offset,
                'recordId': component.get("v.recordId")
            });

            findAllContacts.setCallback(this, function(response){
                var state = response.getState();
                if(component.isValid() && state === "SUCCESS")
                {
                    if (response.getReturnValue().length > 0)
                    {
                        var newContacts = response.getReturnValue();
                        var contacts = component.get("v.Contact");
                        contacts.push(newContacts);
                        component.set("v.Contacts", contacts);
                        component.set("v.hasContact", true);
                        console.log(JSON.stringify(component.get("v.Contacts")));
                        $A.util.toggleClass(spinner, "slds-hide");
                        var offsetI = parseInt(offset);
                        offsetI += 50;
                        component.set('v.offset', offsetI.toString());
                    }else component.set("v.hasContact",false);
                }
            });
            $A.enqueueAction(findAllContacts);
        }
    },

    getDataMap : function(component, event, helper) 
    {
        if (component.get("v.totalContacts")>=parseInt(component.get("v.offset")))
        {
            var spinner = component.find("spinner");
            $A.util.toggleClass(spinner, "slds-hide");
            var action = component.get("c.getContactsMap");
            var offset =  component.get("v.offset");
            var recordId =  component.get("v.recordId");
            var currentMap = component.get("v.ContactsMap");
            action.setParams({
                "offset": offset,
                "contactsMap": currentMap,
                "recordId": recordId
            });
            action.setCallback(this, $A.getCallback(function (response) {
                var state = response.getState();
                if (component.isValid() && state === "SUCCESS"){
                    var contactsMap = response.getReturnValue();
                    // console.log('🍇 ' + JSON.stringify(contactsMap));
                    component.set("v.ContactsMap", contactsMap);
                    // console.log("🍎 ContactsMap: " + JSON.stringify(component.get("v.ContactsMap")));
                    var mapClone = {};
                    Object.assign(mapClone, contactsMap);
                    component.set("v.ContactsMapCopy", mapClone);
                    
                    var contacts = Object.values(contactsMap);
                    var formatter = new Intl.NumberFormat('en-US', {
                        style: 'currency',
                        currency: 'USD',
                        minimumFractionDigits: 2,
                    });
                    for(var i in contacts)
                    {
                        contacts[i].Payments = formatter.format(contacts[i].Payments__c);
                    }
                    component.set('v.Contacts', contacts);
                    //clone Contacts
                    component.set("v.ContactsCopy", Object.values(contactsMap));
                    $A.util.toggleClass(spinner, "slds-hide");
                    var offsetI = parseInt(offset);
                    offsetI += 50;
                    component.set('v.offset', offsetI.toString());
                    // console.log("offset: " + offsetI + " | totalContacts: " + component.get("v.totalContacts"));
                    
                } else if (state === "ERROR") {
                    var errors = response.getError();
                    console.error(errors);
                }
            }));
            $A.enqueueAction(action);
        }
    },


    searchContactsByKey : function(component, event, helper)
    {
        
        //make a clone of the contacts list for fast rebound after a search
        component.set("v.AllContactsSoFar", component.get("v.Contacts").slice(0));

        var searchKey = event.getParam("searchKey");
        var findContactsByKey = component.get("c.findContactsByKey");
        findContactsByKey.setStorable();
        findContactsByKey.setParams({
            "searchKey": searchKey
        });
        findContactsByKey.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS")
            {
                var Contacts = response.getReturnValue();
                component.set("v.Contacts", Contacts);
                if (Contacts.length > 0)
                {
                    component.set("v.hasContact", true);
                }else
                {
                    component.set("v.hasContact", false);
                }
            }
        });
        $A.enqueueAction(findContactsByKey);
    },
})
