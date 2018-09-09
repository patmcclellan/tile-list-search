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
                        var contacts = component.get("v.Contacts");
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

    getTotalContacts : function (component, event, helper)
    {
        var action = component.get("c.getContactsCount");
        action.setParams({
            "recordId" : component.get("v.recordId")
        });
        action.setCallback(this, $A.getCallback(function(response){
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS"){
                component.set("v.totalContacts", response.getReturnValue());
                console.log("Total: " + component.get("v.totalContacts"));
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.error(errors);
            }
        }));
        $A.enqueueAction(action);
        
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
