({
    doInit : function(component, event, helper) {
        var oppty = {};
        component.set("v.oppty", oppty);
    },
    saveOppty : function(component, event, helper) {
        debugger;
        var oppty = component.get("v.oppty");
        
        var oppName = oppty.Name ? oppty.Name : "Upsell";
        var RecordCaseId = component.get("v.recordId");        

        var action = component.get("c.newOppty");
        action.setParams({"oppName":oppName, "caseId":RecordCaseId});
        
        action.setCallback(this, function(response) {
            debugger;
            var state = response.getState();
            if(component.isValid() && state == "SUCCESS"){
                console.log('Success');
                $A.get("e.force:closeQuickAction").fire();
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Success!",
                    "message": "The upsell Opportunity has been created."
                });
                toastEvent.fire();
                $A.get('e.force:refreshView').fire();
            } else {
                console.log('There was a problem and the state is: '+state);
            }
        });
        
        $A.enqueueAction(action);
    },
    
    cancel : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    }
})