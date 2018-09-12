({
    initNav : function(component, event, helper) {
        var navService = component.find("navService");
        // Sets the route to /lightning/o/Account/view
        var pageReference = {
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Contact',
                actionName: 'view'
            }
        };
        component.set("v.pageReference", pageReference);
        // Set the URL on the link or use the default if there's an error
        var defaultUrl = "#";
        navService.generateUrl(pageReference)
            .then($A.getCallback(function(url) {
                component.set("v.url", url ? url : defaultUrl);
            }), $A.getCallback(function(error) {
                component.set("v.url", defaultUrl);
            }));
        console.log("Url: " + component.get("v.url"));
    },
    
    onSelectContact : function(component, event, helper) {
        var contact = event.getParam("Contact");
        component.set("v.Contact", contact);
        component.set("v.cardTitle", contact.Name);
        component.set("v.hasContact", true);
        component.initNav(component);
    },
    
    handleClick: function(component, event, helper) {
        var navService = component.find("navService");
        // Uses the pageReference definition in the init handler
        var pageReference = component.get("v.url");
        event.preventDefault();
        navService.navigate(pageReference);
    },

    //more code here
 
})
