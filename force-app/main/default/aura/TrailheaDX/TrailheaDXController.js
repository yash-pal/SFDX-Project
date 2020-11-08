({
    navigate : function(component, event, helper) {
         var address = component.find("address").get("v.myURL");
        var urlEvent = $A.get("e.force:navigateToURL");
    urlEvent.setParams({
      "url": 'https://www.salesforce.com/campaign/destination-success/overview/' + address
    });
    urlEvent.fire();
    }
})