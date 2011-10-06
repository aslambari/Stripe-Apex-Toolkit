/*
@Name             : StripeErrorModel
@Author           : Aslam Bari/Sanjay Mankani (http://www.aslambari.com/stripe_apex_toolkit.html)
@Date             : 6 Oct, 2011
@Description      : This class contains error variables.
                      
*/

public class StripeErrorModel{
    public Integer code {get;set;}
    public string message {get;set;}
    public string param {get;set;}
    public string error_type {get;set;}
}