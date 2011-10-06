/*
@Name             : StripeInvoice
@Author           : Aslam Bari/Sanjay Mankani (http://www.aslambari.com/stripe_apex_toolkit.html)
@Date             : 6 Oct, 2011
@Description      : This class Creates and retrieves an invoice Item.Sometimes you want to add a charge or credit to a customer but only actually charge
                    the customer's card at the end of a regular billing cycle. This is useful for combining several charges to minimize 
                    per-transaction fees or having Stripe tabulate your usage-based billing totals. 

*/

public class StripeInvoice{

    StripeResponseModel StripeResponseModel{get;set;}
    public StripeGetResponseValues stripeGetResponseValue{get;set;}    
    
    Integer statusCode;
    string response;
    
    String INVOICE_URL='https://api.stripe.com/v1/invoiceitems';
    String API_KEY='';
    public StripeInvoice(String apikey){
        API_KEY=apikey;
        StripeResponseModel=new StripeResponseModel();
        stripeGetResponseValue=new StripeGetResponseValues();
    }
    
    public StripeResponseModel createInvoice(String customer,String amount,String curency,String description){    
        HTTpRequest http=new HTTpRequest();
        http.setEndPoint(INVOICE_URL);
         http.setMethod('POST');
        Blob headerValue = Blob.valueOf(API_KEY + ':');
        String authorizationHeader = 'BASIC ' +
        EncodingUtil.base64Encode(headerValue);
        http.setHeader('Authorization', authorizationHeader);
        http.setBody('customer='+customer+'&amount='+amount+'&currency='+curency+'&description='+description);
        
        if(!Test.isRunningTest()){
                
            Http con = new Http();
            HttpResponse hs = con.send(http);
    
            system.debug('#### '+ hs.getBody());
            
            response = hs.getBody();
            statusCode=hs.getStatusCode();
        
        }else{
        
            statusCode=200;
            response='"amount": 400,';
            response+='"currency": "usd",';
            response+='"customer": "cus_wCA0LuIzUzRYZp",';
            response+='"date": 1317826369,';
            response+='"description": "test",';
            response+='"id": "ii_JwpRLT7TOQLZvK",';
            response+='"livemode": false,';
            response+='"object": "invoiceitem"';
            response+='}';
            response+='}';                    
                    
        }
        
        if(statusCode!=200){
            StripeResponseModel.errorResponse.code=statusCode;
            StripeResponseModel.errorResponse.message=stripeGetResponseValue.getValue(response,'"message":');            
            StripeResponseModel.errorResponse.param =stripeGetResponseValue.getValue(response,'"param":');
            //StripeResponseModel.errorResponse.error_type=stripeGetResponseValue.getValue(response,'"type":'); 
            StripeResponseModel.errorResponse.error_type=stripeGetResponseValue.getLastValue(response,'"type":'); 
            StripeResponseModel.isError=true;            
            
        }else{
               
            StripeResponseModel.isError=false;            
            StripeResponseModel.id=stripeGetResponseValue.getValue(response,'"id":');
            //StripeResponseModel.rObject=stripeGetResponseValue.getValue(response,'"object":');
            StripeResponseModel.rObject=stripeGetResponseValue.getLastValue(response,'"object":');
            StripeResponseModel.description=stripeGetResponseValue.getValue(response,'"description":'); 
            StripeResponseModel.curency=stripeGetResponseValue.getValue(response,'"currency":'); 
            StripeResponseModel.amount=stripeGetResponseValue.getNumValue(response,'"amount":'); 
            StripeResponseModel.created=stripeGetResponseValue.getNumValue(response,'"date":');                         
            StripeResponseModel.livemode=stripeGetResponseValue.getNumValue(response,'"livemode":');                         
                                         
        }
        system.debug('**StripeResponseModel='+StripeResponseModel);
        return StripeResponseModel;
        
    }
    
    public StripeResponseModel retreiveInvoice(String invoiceId){
    String mainUrl=INVOICE_URL+'/'+invoiceId;
    HTTpRequest http=new HTTpRequest();
    http.setEndPoint(mainUrl);
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
        response='"amount": 400,';
        response+='"currency": "usd",';
        response+='"customer": "cus_wCA0LuIzUzRYZp",';
        response+='"date": 1317826369,';
        response+='"description": "test",';
        response+='"id": "ii_JwpRLT7TOQLZvK",';
        response+='"livemode": false,';
        response+='"object": "invoiceitem"';
        response+='}';
        response+='}';                    
    }
        
        if(statusCode!=200){
            StripeResponseModel.errorResponse.code=statusCode;
            StripeResponseModel.errorResponse.message=stripeGetResponseValue.getValue(response,'"message":');            
            StripeResponseModel.errorResponse.param =stripeGetResponseValue.getValue(response,'"param":');
            //StripeResponseModel.errorResponse.error_type=stripeGetResponseValue.getValue(response,'"type":'); 
            StripeResponseModel.errorResponse.error_type=stripeGetResponseValue.getLastValue(response,'"type":'); 
            StripeResponseModel.isError=true;            
            
        }else{
               
            StripeResponseModel.isError=false;            
            StripeResponseModel.id=stripeGetResponseValue.getValue(response,'"id":');
            //StripeResponseModel.rObject=stripeGetResponseValue.getValue(response,'"object":');
            StripeResponseModel.rObject=stripeGetResponseValue.getLastValue(response,'"object":');
            
            StripeResponseModel.description=stripeGetResponseValue.getValue(response,'"description":'); 
            StripeResponseModel.curency=stripeGetResponseValue.getValue(response,'"currency":'); 
            StripeResponseModel.amount=stripeGetResponseValue.getNumValue(response,'"amount":'); 
            StripeResponseModel.created=stripeGetResponseValue.getNumValue(response,'"date":');                         
            StripeResponseModel.livemode=stripeGetResponseValue.getNumValue(response,'"livemode":');                         
                                         
        }
        system.debug('**StripeResponseModel='+StripeResponseModel);
        return StripeResponseModel;
    
    }
}