({
    doInit : function(component, event, helper)
    {
        helper.findAllContacts(component, event, helper);
    },

    onSearchKeyChange : function(component, event, helper)
    {
        helper.searchContactsByKey(component, event, helper);
    },
})
