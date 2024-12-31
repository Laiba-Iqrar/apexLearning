public class MyDemo {
    public static void updateAccountPhone(){
        List<Account> accList = new List<Account>();
        Account a = new account();    
        for (Account acc : [SELECT Id ,Name FROM Account WHERE Phone = '0333243811']){
            a.id = acc.id;    
            a.Phone = '100101';
            accList.add(a);
        }
        
        if(!accList.isEmpty()){
            update accList;
            
        }
        
    }
    
}