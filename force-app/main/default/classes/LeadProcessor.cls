public class LeadProcessor implements Database.Batchable<sObject> {
    public Database.QueryLocator  start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
                'SELECT ID FROM Lead' );
        }
        // collect the batches of records or objects to be passed to execute
    
    public void execute(Database.BatchableContext bc, List<Lead> records){
            for(Lead l: records){
            l.LeadSource = 'Dreamforce';
        }
        update records;

        // process each batch of records
    }
    public void finish(Database.BatchableContext bc){

        // execute any post-processing operations
    }
}