@isTest
public class testRestApiForContact {
    static testMethod void testPostMethod(){
        RestRequest request = new RestRequest();
        request.requestUri ='/services/apexrest/CreateContact';
        request.httpMethod = 'POST';
        RestContext.request = request;
        String strId = MyFirstRestAPIClass.doPost('Amit','2345678','12345');
        System.assert(strId !=null );
    }

}