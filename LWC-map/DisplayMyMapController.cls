public with sharing class DisplayMyMapController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getOfficeLocations(String accountId) {
        //String str = accountNameIntial + '%';
        return [
            SELECT
                Id,
                name,
                BillingStreet,
                BillingCity,
                BillingState,
                BillingPostalCode,
                BillingCountry,
                ShippingCity,
                ShippingPostalCode,
                ShippingCountry,
                ShippingState,
                ShippingStreet
            FROM Account
            WHERE Id = :accountId
        ];
    }
}
