public class HandlerForCandidateTrigger {
    public static void validateSalaryMethod(List<Candidate_Shubham__c> candidateObjectList){
        for(Candidate_Shubham__c candidateObject:candidateObjectList){
            if(candidateObject.Expected_Salary__c==null){
                candidateObject.Expected_Salary__c.addError('Expected Salary field is missing');
            }
        }
    }
    public static void ActiveJobsMethod(List<Candidate_Shubham__c> candidateObjectList){
        for(Candidate_Shubham__c candidateObject :candidateObjectList){
            List<Job_Shubham__c> jobObjectList=[select Id, Active__c from Job_Shubham__c where Id=:candidateObject.Job_Shubham__c];
            for(Job_Shubham__c jobObject:jobObjectList){
                if(jobObject.Active__c==false){
                    candidateObject.Job_Shubham__c.addError('This Job is not active');
                }
            }
        }
    }
    public static void ApplicationDateMethod(List<Candidate_Shubham__c> candiDateObjectPass){
            List<Candidate_Shubham__c> candidateList = new List<Candidate_Shubham__c>();
            for(Candidate_Shubham__c candidateObj : candiDateObjectPass) {
                /*Candidate_Shubham__c temp = candidateObj.clone(true,true,true,true);
                temp.Application_Date__c = Date.newInstance(candidateObj.CreatedDate.year(), candidateObj.CreatedDate.month(), candidateObj.CreatedDate.day());
                candidateList.add(temp);
				*/
                /* 
                Candidate_Shubham__c cloneObject = candidateObj.clone(true,true,true,true);
                cloneObject.Application_Date__c = candidateObj.CreatedDate.date();
                */
                Candidate_Shubham__c cloneObject = candidateObj.clone(true,true,true,true);
                DateTime createdDateTime = cloneObject.CreatedDate;
        		String createdDateString = createdDateTime.format('yyyy-MM-dd');
        		cloneObject.Application_Date__c = Date.valueOf(createdDateString);
        		System.debug(cloneObject.Application_Date__c);
                candidateList.add(cloneObject);
            }
            Database.update(candidateList);
            //update candidateList;
    }
    public static Boolean candidateNumberMatchApplicant(List<Candidate_Shubham__c> candidateObjectList ){
        Boolean EmailSendcheck=false;
		List<Job_Shubham__c> jobListObject=new List<Job_Shubham__c>();
        for(Candidate_Shubham__c obj : candidateObjectList){
           Job_Shubham__c jobObjects=[select Id,Manager__c,LastModifiedDate , Total_position__c, Hired_Applicants__c,Active__c from Job_Shubham__c where Id =:obj.Job_Shubham__c];
           System.debug(jobObjects);
            if(jobObjects.Total_position__c <= jobObjects.Hired_Applicants__c){
                jobObjects.Active__c=false;
                List<Contact> contactList=[select Id, Email from Contact where Id=:jobObjects.Manager__c];
                for(Contact contactObject:contactList){
                    EmailMissionSpecialist emailspl = new EmailMissionSpecialist();
                	EmailSendcheck=emailspl.sendMail(contactObject.Email,'Application is Full','All required candidate has been hired for this job on Job Last Modified Date '+jobObjects.LastModifiedDate);   
                }
            	jobListObject.add(jobObjects);
            }
            
        }
        Database.update(jobListObject,false);
        return EmailSendcheck;
    }
}