({
    doInit : function(component, event, helper)
    {
        helper.findAllContacts(component, event, helper);
    },

    onSearchKeyChange : function(component, event, helper)
    {
        console.log("🐝 searchKey: " + event.getParam("searchKey"));
        helper.searchContactsByKey(component, event, helper);
    },
})
