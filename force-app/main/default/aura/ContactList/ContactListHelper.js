({
    findAllContacts : function(component, event, helper)
    {
        var findAllContacts = component.get("c.findAllContacts");
        findAllContacts.setStorable();
        findAllContacts.setParams({
            'recordId': component.get("v.recordId")
        });

        findAllContacts.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS")
            {
                if (response.getReturnValue().length > 0)
                {
                    component.set("v.Contacts", response.getReturnValue());
                    component.set("v.hasContact", true);
                    console.log(JSON.stringify(component.get("v.Contacts")));
                }else component.set("v.hasContact",false);
            }
        });
        $A.enqueueAction(findAllContacts);
    },


    searchContactsByKey : function(component, event, helper)
    {
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
