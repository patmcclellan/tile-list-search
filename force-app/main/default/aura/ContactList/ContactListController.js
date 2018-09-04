({
    doInit : function(component, event, helper)
    {
        helper.findAllContacts(component, event, helper);
    },

    onSearchKeyCase : function(component, event, helper)
    {
        helper.searchContactsByKey(component, event, helper);
    },
})
