public class OrderCompletionDateBatch implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator([SELECT Id, Status FROM Order WHERE Status='Complete']);
    }

    public void execute(Database.BatchableContext BC, List<SObject> scope) {
        List<Order> ordersToUpdate = new List<Order>();
        for (Order ord : (List<Order>)scope) {
            // Assuming there is a field or some logic to check if the order was previously in 'Draft'
            // Add your logic here to check if the order was in 'Draft' before being set to 'Complete'
            if (ord.Status == 'Complete') {
                ord.Order_Completion_Date__c = Date.today();
                ordersToUpdate.add(ord);
            }
        }
        update ordersToUpdate;
    }

    public void finish(Database.BatchableContext BC) {
    }
}