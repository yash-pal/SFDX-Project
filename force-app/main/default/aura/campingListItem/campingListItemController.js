({
    packItem : function(component, event, helper) {
        
        var a = component.get("v.item");
        a.Name = 'Item2';
        a.Quantity__c = 20;
        a.Price__c = 200;
        a.Packed__c = true;
        component.set("v.item",a);
        
        var btnClicked = event.getSource();
        btnClicked.set("v.disabled",true);
        
    }
})