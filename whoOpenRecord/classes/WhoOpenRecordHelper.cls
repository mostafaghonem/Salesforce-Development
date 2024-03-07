public  class WhoOpenRecordHelper {
    @AuraEnabled(cacheable=true)
    public static Case getCaseById(String recordId , String fieldApiName){
        String queryString = 'Select Id,'+fieldApiName+' from Case Where Id = \'' + recordId + '\' LIMIT 1';
        Case c = Database.query(queryString);
        return c;
    }
}