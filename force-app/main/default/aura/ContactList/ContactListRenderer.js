({
    afterRender : function( component, event, helper ) 
    {
        console.log('👠👖👚');
        this.superAfterRender();
        var didScrolled;
        var div = component.find('scroll_container');
        
        console.log(JSON.stringify(div));
        if(!$A.util.isEmpty(div)){
            div = div.getElement();
            div.onscroll = function(){
                didScrolled = true;
                };
            //Interval function to check if the user scrolled or if there is a scrollbar
            var intervalId = setInterval($A.getCallback(function(){
                if(didScrolled){
                    console.log("didScrolled");
                    didScrolled = false;
                    if(div.scrollTop === (div.scrollHeight - div.offsetHeight)){
                        if(! component.get("v.searching"))
                        { 
                            helper.findAllContacts(component, event, helper);
                        }
                    }
                }
            }), 750);
            component.set('v.intervalId', intervalId);
        }
    },
    unrender: function( component) {
        this.superUnrender();
        var intervalId = component.get( 'v.intervalId' );
        if ( !$A.util.isUndefinedOrNull( intervalId ) ) {
            window.clearInterval( intervalId );
        }
    }
})