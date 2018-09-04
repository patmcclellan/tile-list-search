({
    findCasesByAcc : function(component, event, helper)
    {
        //console.log("Case: " + component.get("v.recordId"));
        if(component.get("v.AccountId") != null)
        {
            var findCases = component.get("c.findCaseByAccountId");
            findCases.setStorable();
            findCases.setParams({
                'AccountId': component.get("v.AccountId")
            });

            findCases.setCallback(this, function(response){
                var state = response.getState();
                if(component.isValid() && state === "SUCCESS")
                {
                    if (response.getReturnValue().length > 0)
                    {
                        component.set("v.Cases", response.getReturnValue());
                        console.log(JSON.stringify(component.get("v.Cases")));
                    }else component.set("v.hasCase",false);
                }

            });
            $A.enqueueAction(findCases);
        } else component.set("v.hasCase", false);
    },


    searchCasesByKey : function(component, event, helper)
    {
        var searchKey = event.getParam("searchKey");
        console.log("CaseList caught SearchKeyCase:" + searchKey);
        var searchCases = component.get("c.searchCases");
        searchCases.setStorable();
        searchCases.setParams({
            "searchKey": searchKey
        });
        searchCases.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && state === "SUCCESS")
            {
                var Cases = response.getReturnValue();
                component.set("v.Cases", Cases);
                if (Cases.length > 0)
                {
                    component.set("v.hasCase", true);
                }else
                {
                    component.set("v.hasCase", false);
                }
                // console.log("🍉 Cases: " + Cases);
            }
        });
        $A.enqueueAction(searchCases);
    },

    //more code here
})