/**
 * Created by pmcclellan on 12/22/17.
 */
({
    doInit : function(component, event, helper)
    {
        helper.findCasesByAcc(component, event, helper);
    },

    onSearchKeyCase : function(component, event, helper)
    {
        helper.searchCasesByKey(component, event, helper);
    },

   // more code here

})