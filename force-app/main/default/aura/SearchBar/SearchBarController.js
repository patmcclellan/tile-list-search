/**
 * Created by pmcclellan on 12/21/17.
 */
({

    searchKeyChange: function(component, event, helper) {
        var myEvent = component.getEvent("SearchKeyChange");
        myEvent.setParams({"searchKey": event.target.value});
        myEvent.fire();
        console.log("🔥 fired SearchKeyChange: " + JSON.stringify(myEvent.getParams("searchKey")));
    }

    //more code here
})