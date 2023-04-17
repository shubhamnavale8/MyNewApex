public class LeadSourceUpdateQueue implements Queueable {
    public void execute(QueueableContext qc){
        List<Lead> leadobject=[select Id from Lead];
        List<Lead> leadObjectList=new List<Lead>();
        for(Lead leadObjectNew:leadobject){
            leadObjectNew.LeadSource='web';
            leadObjectList.add(leadObjectNew);
        }
        if(leadObjectList.size() >0 ){
             update leadObjectList;
         }
    }
}