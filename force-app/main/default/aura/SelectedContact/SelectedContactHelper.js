({
    initNav : function(component) {
        var recordId = component.get("v.Contact.Id");
        console.log("recordId: " + recordId);
        var navService = component.find("navService");
        // Sets the route to /lightning/o/Account/view
        var pageReference = {
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                objectApiName: "Contact",
                actionName: "view"
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
    },
    
})
