({
    
    onSelectContact : function(component, event, helper) {
        var contact = event.getParam("Contact");
        component.set("v.Contact", contact);
        component.set("v.cardTitle", contact.Name);
        component.set("v.hasContact", true);
        helper.initNav(component);
    },
    
    //more code here
 
})
