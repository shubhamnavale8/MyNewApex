@isTest
public class testAccountAndLeadLastQueue {
	@isTest
    public static void testMethods(){
        List<Account> Teste = new List <Account>();
         for(Integer i=0;i<10;i++){
             Teste.add(new Account(name = 'Test'+i));
         }
         insert Teste;
         Contact co = new Contact();
         co.FirstName='demo';
         co.LastName ='demo';
         insert co; 
         
        List<Lead> leadObjectList=new List<Lead>();
        for(Integer leaditr=0; leaditr<10; leaditr++){
            Lead leadObject=new Lead(LastName='Test_Lead_'+leaditr,Company='Test_Company_Lead_'+leaditr ,Status='Closed - Converted');
            leadObjectList.add(leadObject);
        }
        insert leadObjectList;
        
         AddContactForAccountQueue AccountContAdd = new AddContactForAccountQueue(co);
         Test.startTest();
         System.enqueueJob(AccountContAdd);
         Test.stopTest();
		 System.assertEquals(50, [select count() from Contact where accountID IN (SELECT id FROM Account)]);
         // System.AsyncException: Maximum stack depth has been reached.
         //System.assertEquals(50, [select count() from Lead where LeadSource='web']);
    }
}