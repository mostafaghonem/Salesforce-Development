public  class WhoOpenRecordHelper {
    @AuraEnabled(cacheable=true)
    public static SObject getObjectById(String recordId , String fieldApiName , String objectName){
        return Database.query('Select Id,'+fieldApiName+' from '+objectName+' Where Id = \'' + recordId + '\' LIMIT 1');
    }
}