/*
@Name             : StripeResponseModel
@Author           : Aslam Bari/Sanjay Mankani (http://www.aslambari.com/stripe_apex_toolkit.html)
@Date             : 6 Oct, 2011
@Description      : This class contains variables for gathering information contained in response from Stripe.
                      
*/

public class StripeResponseModel{
    public string id {get;set;}
    public string rObject{get;set;}
    public string amount {get;set;}
    public string paid {get;set;}
    public String curency{get;set;}
    public string fee {get;set;}
    public string created {get;set;}
    public string livemode {get;set;}
    public string description {get;set;}
    public string refunded {get;set;}
    public boolean isError {get;set;}
    public String name{get;set;}
    public String interval{get;set;}
    
    public StripeCardResponseModel card {get;set;}
    public StripeErrorModel errorResponse {get;set;}
    
    public StripeResponseModel(){
        card=new StripeCardResponseModel();
        errorResponse=new StripeErrorModel();
    }
}