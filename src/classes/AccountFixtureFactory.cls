@isTest
public class AccountFixtureFactory {


    public static Account newAccount ( String name, String documentNumber
                                     , City__c city, Cnae__c cnae ) {

        Account account = newAccount (name, documentNumber);

        account.BillingCity = city.Id;
        account.BillinCity__r = city;
        account.Cnae__c = cnae.Id;
        account.Cnae__r = cnae;
    
        

        return account;

    }

    public static Account newAccount (  String category, Decimal annualRevenue) {   
        return new Account ( Category__c = category
                            , AnnualRevenue = annualRevenue );
    }

    public static Account createAccount ( String category, Decimal annualRevenue ) {

        return createAccount(newAccount(category, annualRevenue) );
    }


    public static Account newAccount ( String name, String documentNumber ) {
        return new Account ( Name = name
                , DocumentNumber__c = documentNumber);
    }

    public static Account createAccount ( String name, String documentNumber ) {

        return createAccount ( newAccount(name, documentNumber) );
    
    }

    public static Account createAccount ( String name, String documentNumber
                                     , City__c city, Cnae__c cnae )  {
        return createAccount(newAccount(name, documentNumber, city, cnae) );
    }

    public static Account createAccount ( Account account) {

        insert account;
        return account;
    
    }

    public static Account newDefaultAccount () {
        
        String payload = '{"Name":"GenePoint","Type":"Customer - Channel","BillingStreet":"345 Shoreline Park\nMountain View, CA 94043\nUSA","BillingCity":"Mountain View","BillingState":"CA","BillingAddress":{"city":"Mountain View","country":null,"geocodeAccuracy":null,"latitude":null,"longitude":null,"postalCode":null,"state":"CA","street":"345 Shoreline Park\nMountain View, CA 94043\nUSA"},"ShippingStreet":"345 Shoreline Park\nMountain View, CA 94043\nUSA","ShippingAddress":{"city":null,"country":null,"geocodeAccuracy":null,"latitude":null,"longitude":null,"postalCode":null,"state":null,"street":"345 Shoreline Park\nMountain View, CA 94043\nUSA"},"Phone":"(650) 867-3450","Fax":"(650) 867-9895","AccountNumber":"CC978213","Sic":"3712","Industry":"Biotechnology","AnnualRevenue":30000000,"NumberOfEmployees":265,"Ownership":"Private","Description":"Genomics company engaged in mapping and sequencing of the human genome and developing gene-based drugs","Rating":"Cold","CustomerPriority__c":"Low","SLA__c":"Bronze","Active__c":"Yes","NumberofLocations__c":1,"UpsellOpportunity__c":"Yes","SLASerialNumber__c":"7324","SLAExpirationDate__c":"2021-06-20"}';

        return (Account) JSON.deserialize(payload, Account.class);
    }

    public static Account froJson(String payload){

        return (Account) JSON.deserialize(payload, Account.class);
    }


    public static Map<String, SObject> createIntegratedScenario () {

        Map<String, SObject> records = new Map<String, SObject>();

        City__c city = CityFixtureFactory.createCity ();
        records.put ('city-CTBA', city);
        
        Cnae__c cnae = CnaeFixtureFactory.createCnae ();
        records.put ('cnae', cnae);
        
        Account account = createAccount( 'Premium', 150000);
        records.put ('accountPremiumAboveMillion', account);

        account = createAccount( 'Premium', 60000);
        records.put ('accountPremiumUnderMillion', account);

        account = createAccount( 'Standard', 10000);
        records.put ('accountStandard', account);
        
        account = createAccount('Souza Account', '13508213064', city, cnae);
        records.put ('account', cnae);
        
        return records;

    } 


}