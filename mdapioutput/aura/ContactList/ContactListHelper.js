({
    findAllContacts : function(component, event, helper)
    {
        var recordId = component.get("v.recordId");
        if(!recordId) recordId = '';
        if (component.get("v.totalContacts")>=parseInt(component.get("v.offset")))
        { 
            console.log("😛 getting contacts from the server");
            var spinner = component.find("spinner");
            $A.util.toggleClass(spinner, "slds-hide");
            var offset =  component.get("v.offset");
            var findAllContacts = component.get("c.findAllContacts");
            findAllContacts.setStorable();
            findAllContacts.setParams({
                'offset' : offset,
                'recordId': recordId
            });

            findAllContacts.setCallback(this, function(response){
                var state = response.getState();
                if(component.isValid() && state === "SUCCESS")
                {
                    if (response.getReturnValue().length > 0)
                    {
                        console.log("🍊 returned contacts: " + response.getReturnValue().length);
                        component.set("v.Contacts", component.get("v.Contacts").concat(response.getReturnValue()));
                        component.set("v.hasContact", true);
                        $A.util.toggleClass(spinner, "slds-hide");
                        var offsetI = parseInt(offset);
                        offsetI += 100;
                        component.set('v.offset', offsetI.toString());

                        //make a clone of the contacts list for fast rebound after a search
                        component.set("v.AllContactsSoFar", component.get("v.Contacts").slice(0));
                    }else component.set("v.hasContact",false);
                }
            });
            $A.enqueueAction(findAllContacts);
        } else

        console.log("🙁 no more contacts to find, no server call");
    },

    getTotalContacts : function (component, event, helper)
    {   
        var recordId = component.get("v.recordId");
        if(!recordId) recordId = '';
        var action = component.get("c.getContactsCount");
        action.setParams({
            "recordId" : recordId
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
        var searchKey = event.getParam("searchKey");
        if(searchKey.trim() == '') // search is empty, return to previous list
        {
            component.set("v.searching", false);
            var oldContacts = [];
            Object.assign(oldContacts, component.get("v.AllContactsSoFar"));
            component.set("v.Contacts", oldContacts);
        }else 
        {
            var findContactsByKey = component.get("c.findContactsByKey");
            findContactsByKey.setStorable();
            findContactsByKey.setParams({
                "searchKey": searchKey.trim()
            });
            findContactsByKey.setCallback(this, function(response){
                var state = response.getState();
                if(component.isValid() && state === "SUCCESS")
                {
                    var Contacts = response.getReturnValue();
                    component.set("v.Contacts", Contacts);
                    if (Contacts.length > 0)
                    {
                        console.log('🔎 Found contacts: ' + Contacts.length);
                        component.set("v.hasContact", true);
                    }else
                    {
                        component.set("v.hasContact", false);
                    }
                }
            });
            component.set("v.searching", true);
            $A.enqueueAction(findContactsByKey);
        } 

        
    },
})
