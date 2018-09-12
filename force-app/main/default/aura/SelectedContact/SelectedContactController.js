({
    onSelectContact : function(component, event, helper) {
        var contact = event.getParam("Contact");
        component.set("v.Contact", contact);
        component.set("v.cardTitle", contact.Name);
        component.set("v.hasContact", true);
    },
    
    handleClick: function(component, event, helper) {
        var navService = component.find("navService");
        // Uses the pageReference definition in the init handler
        var pageReference = component.get("v.Contact.Id");
        event.preventDefault();
        navService.navigate(pageReference);
    },

    //more code here
 
})
