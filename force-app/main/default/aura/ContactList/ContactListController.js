({
    doInit : function(component, event, helper)
    {
        helper.findAllContacts(component, event, helper);
    },

    onSearchKeyChange : function(component, event, helper)
    {
        console.log("🐝 onSearchKeyChange: " + event.getParam("searchKey"));
        helper.searchContactsByKey(component, event, helper);
    },
})
