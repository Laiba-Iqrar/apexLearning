@isTest
public class OrderTriggerTest {
   
    @isTest
    static void testOrderStatusRemainsUnchanged() {
        // Create an Account for the Order
        Account acc = new Account(
            Name = 'Test Account'
        );
        insert acc;

        // Create an Order with a valid status 'Draft' and associate it with the Account
        Order ord = new Order(
            Name = 'Test Order',
            Status = 'Draft',
            AccountId = acc.Id,
            EffectiveDate = Date.today()
        );
        insert ord;

        // Update the Order status to the same status (unchanged)
        ord.Status = 'Draft';
        update ord;

        // Retrieve the updated Order
        Order updatedOrder = [SELECT Id, Status, Order_Completion_Date__c FROM Order WHERE Id = :ord.Id];

        // Verify that the Order_Completion_Date__c field is not set
        System.assertEquals(null, updatedOrder.Order_Completion_Date__c);
    }

    @isTest
    static void testOrderCompletionDate() {
       Account acc = new Account(
            Name = 'Test Account'
        );
        insert acc;

        // Create an Order with a valid status 'Draft' and associate it with the Account
        Order testorder = new Order(
            Name = 'Test Order2',
            Status = 'Draft',
            AccountId = acc.Id,
            EffectiveDate = Date.today()
        );
        insert testorder;
        
        // Verify that the Order_Completion_Date__c field is initially null
        Order insertedOrder = [SELECT Id, Order_Completion_Date__c FROM Order WHERE Id = :testOrder.Id];
        System.assertEquals(null, insertedOrder.Order_Completion_Date__c);
        
        
        // Update the status to 'Complete' to trigger the OrderTrigger
        //testOrder.Status = 'Activated';
        testOrder.Status = 'Complete';
        update testOrder;
        
        // Verify that the Order_Completion_Date__c field is set to the current date and time
        Order updatedOrder = [SELECT Id, Order_Completion_Date__c FROM Order WHERE Id = :testOrder.Id];
        System.assertNotEquals(null, updatedOrder.Order_Completion_Date__c);
        System.assertEquals(DateTime.now().date(), updatedOrder.Order_Completion_Date__c.date());
    }
}