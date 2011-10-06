/*
@Name             : StripeCustomer
@Author           : Aslam Bari/Sanjay Mankani (http://www.aslambari.com/stripe_apex_toolkit.html)
@Date             : 6 Oct, 2011
@Description      : This class Creates and retrieves a customer.Customer objects allow you to perform recurring charges
                    and track multiple charges that are associated with the same customer.

*/

public class StripeCustomer{

    public StripeGetResponseValues StripeGetResponseValue{get;set;}    
    public StripeResponseModel StripeResponseModel{get;set;}
    
    Integer statusCode;
    string response;
    
    String CUSTOMER_URL = 'https://api.stripe.com/v1/customers';
    String API_KEY = '';
    public StripeCustomer(String apikey){
        API_KEY=apikey;
        StripeGetResponseValue=new StripeGetResponseValues();
        StripeResponseModel=new StripeResponseModel();
    }
    
    public StripeResponseModel createCustomer(String cnumber,String exp_month,String exp_year,String cvc,String name,String addressLine1,String addressLine2,String zip,String state,String country,String email,String description){
        HttpRequest http = new HttpRequest();
        http.setEndpoint(CUSTOMER_URL);
        http.setMethod('POST');
        Blob headerValue = Blob.valueOf(API_KEY + ':');
        String authorizationHeader = 'BASIC ' +
        EncodingUtil.base64Encode(headerValue);
        http.setHeader('Authorization', authorizationHeader);
        http.setBody('card[number]='+cnumber+'&card[exp_year]='+exp_year+'&card[exp_month]='+exp_month+'&card[cvc]='+cvc+'&card[name]='+name+'&card[address_line1]='+addressLine1+'&card[address_line2]='+addressLine2+'&card[address_zip]='+zip+'&card[address_state]='+state+'&card[address_country]='+country+'&email='+email+'&description='+description);    

        if(!Test.isRunningTest()){
            Http con = new Http();
            HttpResponse hs = con.send(http);
    
            system.debug('#### '+ hs.getBody());
            
            response = hs.getBody();
            statusCode=hs.getStatusCode();
            system.debug('$$statusCode='+hs.getStatusCode());
        }else{
            statusCode=200;
            response='"created": 1317825831,';
            response+='"description": "testing",';
            response+='"email": "gamer.sanjay@gmail.com",';
            response+='"id": "cus_wCA0LuIzUzRYZp",';
            response+='"livemode": false,';
            response+='"object": "customer",';
            response+='"active_card": {';
            response+='"address_country": "India",';
            response+='"address_line1": "add1",';
            response+='"address_line1_check": "pass",';
            response+='"address_line2": "add22",';
            response+='"address_state": "Rajasthan",';
            response+='"address_zip": "123123",';
            response+='"address_zip_check": "pass",';
            response+='"country": "US",';
            response+='"cvc_check": "pass",';
            response+='"exp_month": 12,';
            response+='"exp_year": 2013,';
            response+='"last4": "4242",';
            response+='"name": "sanjay",';
            response+='"object": "card",';
            response+='"type": "Visa"';
            response+='}';
            response+='}';      
        }
        if(statusCode!=200){
        
            StripeResponseModel.errorResponse.code=statusCode;
            StripeResponseModel.errorResponse.message=StripeGetResponseValue.getValue(response,'"message":');            
            StripeResponseModel.errorResponse.param =StripeGetResponseValue.getValue(response,'"param":');
            //StripeResponseModel.errorResponse.error_type=StripeGetResponseValue.getValue(response,'"type":'); 
            StripeResponseModel.errorResponse.error_type=StripeGetResponseValue.getLastValue(response,'"type":'); 
            StripeResponseModel.isError=true;            
            
        }else{
               
            StripeResponseModel.isError=false;            
            StripeResponseModel.id=StripeGetResponseValue.getValue(response,'"id":');
            StripeResponseModel.rObject=StripeGetResponseValue.getValue(response,'"object":');
            StripeResponseModel.description=StripeGetResponseValue.getValue(response,'"description":'); 
            StripeResponseModel.livemode=StripeGetResponseValue.getNumValue(response,'"livemode":'); 
            StripeResponseModel.created=StripeGetResponseValue.getNumValue(response,'"created":'); 
            
            //StripeResponseModel.card.ctype=StripeGetResponseValue.getValue(response,'"type":');
            StripeResponseModel.card.ctype=StripeGetResponseValue.getLastValue(response,'"type":');
            
            StripeResponseModel.card.cObject=StripeGetResponseValue.getValue(response,'"object":');
            StripeResponseModel.card.country =StripeGetResponseValue.getValue(response,'"country":');
            StripeResponseModel.card.exp_month=StripeGetResponseValue.getNumValue(response,'"exp_month":'); 
            StripeResponseModel.card.last4 =StripeGetResponseValue.getValue(response,'"last4":');
            StripeResponseModel.card.exp_year=StripeGetResponseValue.getNumValue(response,'"exp_year":');        
                                         
        }
        system.debug('**StripeResponseModel='+StripeResponseModel);
        return StripeResponseModel;
    }
    
    
    public StripeResponseModel retrieveCustomer(String customerId){    
        HttpRequest http = new HttpRequest();
        String mainUrl=CUSTOMER_URL+'/'+customerId;
        http.setEndpoint(mainUrl);
        http.setMethod('GET');
        Blob headerValue = Blob.valueOf(API_KEY + ':');
        String authorizationHeader = 'BASIC ' +
        EncodingUtil.base64Encode(headerValue);
        http.setHeader('Authorization', authorizationHeader);
        
        if(!Test.isRunningTest()){
            Http con = new Http();
            HttpResponse hs = con.send(http);
    
            system.debug('#### '+ hs.getBody());
            
            response = hs.getBody();
            statusCode=hs.getStatusCode();
        }else{
            statusCode=200;
            response='"created": 1317825831,';
            response+='"description": "testing",';
            response+='"email": "gamer.sanjay@gmail.com",';
            response+='"id": "cus_wCA0LuIzUzRYZp",';
            response+='"livemode": false,';
            response+='"object": "customer",';
            response+='"active_card": {';
            response+='"address_country": "India",';
            response+='"address_line1": "add1",';
            response+='"address_line1_check": "pass",';
            response+='"address_line2": "add22",';
            response+='"address_state": "Rajasthan",';
            response+='"address_zip": "123123",';
            response+='"address_zip_check": "pass",';
            response+='"country": "US",';
            response+='"cvc_check": "pass",';
            response+='"exp_month": 12,';
            response+='"exp_year": 2013,';
            response+='"last4": "4242",';
            response+='"name": "sanjay",';
            response+='"object": "card",';
            response+='"type": "Visa"';
            response+='}';
            response+='}';      
        }
        
        if(statusCode!=200){        
            StripeResponseModel.errorResponse.code=statusCode;
            StripeResponseModel.errorResponse.message=StripeGetResponseValue.getValue(response,'"message":');            
            StripeResponseModel.errorResponse.param =StripeGetResponseValue.getValue(response,'"param":');
            //StripeResponseModel.errorResponse.error_type=StripeGetResponseValue.getValue(response,'"type":'); 
            StripeResponseModel.errorResponse.error_type=StripeGetResponseValue.getLastValue(response,'"type":'); 
            StripeResponseModel.isError=true;            
            
        }else{
               
            StripeResponseModel.isError=false;            
            StripeResponseModel.id=StripeGetResponseValue.getValue(response,'"id":');
            StripeResponseModel.rObject=StripeGetResponseValue.getValue(response,'"object":');
            StripeResponseModel.description=StripeGetResponseValue.getValue(response,'"description":'); 
            StripeResponseModel.livemode=StripeGetResponseValue.getNumValue(response,'"livemode":'); 
            StripeResponseModel.created=StripeGetResponseValue.getNumValue(response,'"created":'); 
            
            //StripeResponseModel.card.ctype=StripeGetResponseValue.getValue(response,'"type":');
            StripeResponseModel.card.ctype=StripeGetResponseValue.getLastValue(response,'"type":');
            
            StripeResponseModel.card.cObject=StripeGetResponseValue.getValue(response,'"object":');
            StripeResponseModel.card.country =StripeGetResponseValue.getValue(response,'"country":');
            StripeResponseModel.card.exp_month=StripeGetResponseValue.getNumValue(response,'"exp_month":'); 
            StripeResponseModel.card.last4 =StripeGetResponseValue.getValue(response,'"last4":');
            StripeResponseModel.card.exp_year=StripeGetResponseValue.getNumValue(response,'"exp_year":');        
                                         
        }
        system.debug('**StripeResponseModel='+StripeResponseModel);
        return StripeResponseModel;
    }
}