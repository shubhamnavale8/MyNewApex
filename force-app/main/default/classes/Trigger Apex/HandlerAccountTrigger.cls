public with sharing class HandlerAccountTrigger {
    
    public static void billingToShippingMethod(List<Account> accountObject){
        for(Account a:accountObject){
            //a.ShippingAddress = a.BillingAddress;  
            a.ShippingCity = a.BillingCity;
            a.ShippingCountry = a.BillingCountry;
            a.ShippingPostalCode = a.BillingPostalCode;
            a.ShippingState = a.BillingState;
            a.ShippingStreet = a.BillingStreet;          
        }    
    }
    public static void changeFieldMethodOnetoAnother(List<Account> accountObjectNew,List<Account> accountObjectOld){
        for(Account accountObject : accountObjectNew){
            if(accountObject.Industry=='Finance'){
                for(Account accountObject1 : accountObjectOld){
                    if((accountObject.Id==accountObject1.Id) && (accountObject1.Industry=='Engineering')){
                        accountObject.Active__C=true;
                    }
                }
            }
        }
    }
    public static void priventFromDeletMethod(List<Account> oldAccountObject){

            for(Account accountObjectForDelete: oldAccountObject){
                 List<Opportunity> opportunityObject =[select Id from opportunity where AccountId =:accountObjectForDelete.Id];
                 if(accountObjectForDelete.Active__c==true){
                    accountObjectForDelete.Active__c.addError('You cant delete a record because its in active state');
                 }else if(opportunityObject.size()>0  ){
                    accountObjectForDelete.Id.addError('You cant delete a record because Opportunity Records are associated with This Account ');
                 }
            }
    }
    public static void taskCreatedForActivityMethod(List<Account> accountObjectForNewRecord){
       
        for(Account acoountObject: accountObjectForNewRecord){
            if(acoountObject.AnnualRevenue>50000){
                Date myDate1=date.newInstance(2023, 5, 5);
                Task newTaskCreate = new Task();
                newTaskCreate.Subject='Follow Up Test Task for Acoount : '+acoountObject.Name;
                newTaskCreate.WhatId=acoountObject.Id;
                newTaskCreate.ActivityDate=myDate1;
                newTaskCreate.Status='In Progress';
                insert newTaskCreate;
            }  
        }
    }
    public static void phoneOfAccountUpdateWithContactMethod(List<Account> oldAccountList,List<Account> accountObjectForUpdate){
        for(Account accountObject: accountObjectForUpdate){
            List<Contact> contactObject=[select Id,Phone,AccountId from Contact WHERE AccountId=:accountObject.Id];
            List<Contact> forUpdateListContact=new List<Contact>();
            for(Account olaAccnt: oldAccountList){
                 if(accountObject.Phone!=olaAccnt.Phone){
                    for(Contact c : contactObject){
                        c.Phone = accountObject.Phone;
                        c.OtherPhone = olaAccnt.Phone;
                        c.HomePhone = accountObject.Phone;
                        forUpdateListContact.add(c);
                    }
                 }
            }
            Database.update(forUpdateListContact);
        }
    }
    public static void sendMailforDeletedAccountMethod(List<Account> oldAccountList){
        for(Account accountObject: oldAccountList){
            List<Contact> contactList=[select Id,Email,AccountId from Contact WHERE AccountId=:accountObject.Id];
            for(Contact contactObject : contactList){
                EmailMissionSpecialist emailspl = new EmailMissionSpecialist();
                System.debug(contactObject.Email+'cccccccccccccccccccccccccccccc');
                emailspl.sendMail(contactObject.Email,'Account Deletion','Dear User, Your Account Has been deleted.');
            }
        }
    }
}