/**
 * Created by pmcclellan on 12/21/17.
 */
({
    onSelectContact : function(component, event, helper)
    {
        // console.log("onSelectContact: " + component.get("v.Contact.Name"));

        //set ConversationId  and GroupName and fire SelectConversation event
        var Contact = component.get("v.Contact");
        var SelectContact = $A.get("e.c:SelectContact");
        SelectContact.setParams({"Contact": Contact});
        SelectContact.fire();
        // console.log("🔥 SelectContact fired | Contact: " + Contact.Name);
    },
    //more code here
})
