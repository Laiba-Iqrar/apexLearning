public class DailyLeadProcessor implements Schedulable {
    public void execute(SchedulableContext ctx) {
            List<Lead> updateLeads = new List<Lead>();
            List<Lead> leads = [SELECT Id, LeadSource FROM Lead WHERE LeadSource = null LIMIT 200];
        
            for(Lead l: leads) {
                l.LeadSource = 'Dreamforce';
                updateLeads.add(l);
            }

            update updateLeads;
    }
        
}        
            
        
        

   