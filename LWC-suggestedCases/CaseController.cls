public with sharing class CaseController {
    @AuraEnabled(cacheable=true)
    public static List<Case> getSuggestedCases(String caseId) {
        List<Case> lstCase = new List<Case>();
        //retrieve case subject of existing case
        Case caseObj = [SELECT Subject, Type FROM Case WHERE Id = :caseId];

        //since all the keywords need to searched so, need to put 'OR' condition between the keywords
        List<String> strList = caseObj.Subject.split(' ');
        String strSearch = String.join(strList, ' OR ') + '*';

        System.debug('strSearch=' + strSearch);
        //strSearch=Seeking' OR 'guidance' OR 'on' OR 'electrical' OR 'wiring' OR 'installation' OR 'for' OR 'GC5060*

        //retrieve cases which are already closed, created recently and eliminating current case
        List<List<SObject>> searchList = [
            FIND :strSearch
            IN ALL FIELDS
            RETURNING
                Case(
                    Id,
                    CaseNumber,
                    Subject,
                    Type
                    WHERE Id != :caseId AND Type = :caseObj.Type
                    ORDER BY CreatedDate DESC
                    LIMIT 20)
        ];

        if (searchList.size() > 0) {
            return searchList[0];
        }
        return lstCase;
    }
}
