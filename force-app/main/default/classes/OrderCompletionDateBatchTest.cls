@isTest
public class OrderCompletionDateBatchTest{
    @testSetup
    static void setup(){
        Account testAccount = new Account(Name='Test Account');
        insert testAccount;
        List<Order> orders = new List<Order>();
        for (Integer i = 0; i< 100; i++){
            Order ord=new Order(
                Name='TestOrder'+i,
                AccountId=testAccount.Id,
                EffectiveDate=Date.today(),
                Status='Draft'
            );
            orders.add(ord);
        }
        insert orders;
    }


    

    @isTest
    static void testNoOrders() {
        delete [SELECT Id FROM Order];
        Test.startTest();
        OrderCompletionDateBatch batch = new OrderCompletionDateBatch();
        Id batchJobId = Database.executeBatch(batch);
        Test.stopTest();   
        List<Order> orders = [SELECT Id, Order_Completion_Date__c FROM Order];
        System.assertEquals(0, orders.size(), 'should be no ordersto process');
    }

    @isTest
    static void testOrdersWithCompletionDates() {
        Account testAccount=[SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1];
        List<Order> orders=new List<Order>();
        for (Integer i = 0; i < 3; i++){
            Order ord=new Order(
                Name='Test Order with Date ' + i,
                AccountId=testAccount.Id,
                EffectiveDate=Date.today(),
                Status ='Complete',
                Order_Completion_Date__c = Date.today()
            );
            orders.add(ord);
        }
        insert orders;
        Test.startTest();
        OrderCompletionDateBatch batch = new OrderCompletionDateBatch();
        Id batchJobId = Database.executeBatch(batch);
        Test.stopTest();
        List<Order> updatedOrders = [SELECT Id, Order_Completion_Date__c FROM Order WHERE Name LIKE 'Test Order with Date%'];
        for (Order ord : updatedOrders) {
            System.assertNotEquals(null, ord.Order_Completion_Date__c, 'Ordercompletion Date should remain set');
            System.assertEquals(Date.today(), ord.Order_Completion_Date__c.date(), 'Order Completion Date should match the expected date');
        }
    }

    //  wrapper to history records
    @isTest
    static void testHistoryWrapperUsage() {
        Id orderId = [SELECT Id FROM Order LIMIT 1].Id;   
        OrderHistoryWrapper historyRecord = new OrderHistoryWrapper('Status',orderId,'Draft','Complete',DateTime.now());  
        System.assertEquals('Draft', historyRecord.OldValue);
        System.assertEquals('Complete', historyRecord.NewValue);
        System.assertEquals(orderId, historyRecord.OrderId, 'OrderId should match');
        System.assertNotEquals(null, historyRecord.CreatedDate, 'CreatedDate should be set');
    }
}