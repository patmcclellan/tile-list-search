({
    onSelectContact : function(component, event, helper) {
        var contact = event.getParam("Contact");

        // set the handler attributes based on event data
        component.set("v.Contact", contact);
        component.set("v.cardTitle", contact.Name);
        component.set("v.hasContact", true);
    }
})
