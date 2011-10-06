/*
@Name             : StripePlan
@Author           : Aslam Bari/Sanjay Mankani (http://www.aslambari.com/stripe_apex_toolkit.html)
@Date             : 6 Oct, 2011
@Description      : This class Creates and retrieves a plan.A subscription plan contains the pricing information for different products and feature levels on your site.
                    For example, you might have a $10/month plan for basic features and a different $20/month plan for premium features. 

*/

public class StripePlan{

    public StripeGetResponseValues stripeGetResponseValue{get;set;}    
    public StripeResponseModel StripeResponseModel{get;set;}
    
    Integer statusCode;
    string response;
    
    String PLAN_URL='https://api.stripe.com/v1/plans'; 
    String API_KEY='';
    public StripePlan(String apikey){
        API_KEY=apikey;
        stripeGetResponseValue=new StripeGetResponseValues();
        StripeResponseModel=new StripeResponseModel();
    }
    
    public StripeResponseModel createPlan(String planName,String amount,String curency,String interval,String planLabel){
        HttpRequest http = new HttpRequest();
        http.setEndpoint(PLAN_URL);
        http.setMethod('POST');
        Blob headerValue = Blob.valueOf(API_KEY + ':');
        String authorizationHeader = 'BASIC ' +
        EncodingUtil.base64Encode(headerValue);
        http.setHeader('Authorization', authorizationHeader);
        http.setBody('id='+planName+'&amount='+amount+'&currency='+curency+'&interval='+interval+'&name='+planLabel);
        
        if(!Test.isRunningTest()){
            Http con = new Http();
            HttpResponse hs = con.send(http);
    
            system.debug('#### '+ hs.getBody());
            
            response = hs.getBody();
            system.debug('$$statusCode='+hs.getStatusCode());
            statusCode=hs.getStatusCode();
        }else{
            statusCode=200;
            response='"amount": 400,';
            response+='"currency": "usd",';
            response+='"id": "gold",';
            response+='"interval": "month",';
            response+='"livemode": false,';
            response+='"name": "my plan",';
            response+='"object": "plan"';
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
            StripeResponseModel.curency=stripeGetResponseValue.getValue(response,'"currency":'); 
            StripeResponseModel.amount=stripeGetResponseValue.getNumValue(response,'"amount":');
            StripeResponseModel.name=stripeGetResponseValue.getValue(response,'"name":');
            StripeResponseModel.interval=stripeGetResponseValue.getValue(response,'"interval":');
            //StripeResponseModel.description=stripeGetResponseValue.getValue(response,'"description":'); 
            StripeResponseModel.livemode=stripeGetResponseValue.getNumValue(response,'"livemode":'); 
            //StripeResponseModel.created=stripeGetResponseValue.getNumValue(response,'"created":'); 
                        
        }
        system.debug('**StripeResponseModel='+StripeResponseModel);
        return StripeResponseModel;
    }
    
    public StripeResponseModel retrievePlan(String planName){
        String mainUrl=PLAN_URL+'/'+planName;
        HttpRequest http = new HttpRequest();
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
            system.debug('$$statusCode='+hs.getStatusCode());
            statusCode=hs.getStatusCode();
        }else{
        
            statusCode=200;
            response='"amount": 400,';
            response+='"currency": "usd",';
            response+='"id": "gold",';
            response+='"interval": "month",';
            response+='"livemode": false,';
            response+='"name": "my plan",';
            response+='"object": "plan"';
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
            
            StripeResponseModel.curency=stripeGetResponseValue.getValue(response,'"currency":'); 
            StripeResponseModel.amount=stripeGetResponseValue.getNumValue(response,'"amount":');
            StripeResponseModel.name=stripeGetResponseValue.getValue(response,'"name":');
            StripeResponseModel.interval=stripeGetResponseValue.getValue(response,'"interval":');
            //StripeResponseModel.description=stripeGetResponseValue.getValue(response,'"description":'); 
            StripeResponseModel.livemode=stripeGetResponseValue.getNumValue(response,'"livemode":'); 
            //StripeResponseModel.created=stripeGetResponseValue.getNumValue(response,'"created":'); 
                        
        }
        system.debug('**StripeResponseModel='+StripeResponseModel);
        return StripeResponseModel;
    }
}