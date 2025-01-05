trigger AccountAddressTrigger on Account ( before update,before insert){

    for(account acc : trigger.new){
        if(acc.match_billing_address__c==true &&  acc.BillingAddress!=null){
            acc.ShippingCity=acc.BillingCity;
        }
        
    }
    
    
}