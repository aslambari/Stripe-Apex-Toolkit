/*
@Name             : StripeCardResponseModel
@Author           : Aslam Bari/Sanjay Mankani (http://www.aslambari.com/stripe_apex_toolkit.html)
@Date             : 6 Oct, 2011
@Description      : This class contains Credit card variables.
                      
*/

public class StripeCardResponseModel{
    public string country {get;set;}
    public string cObject {get;set;}
    public string cvc_check {get;set;}
    public string ctype {get;set;}
    public string exp_month {get;set;}
    public string exp_year {get;set;}
    public string last4 {get;set;}
}