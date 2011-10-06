/*
@Name             : TestStripe
@Author           : Aslam Bari/Sanjay Mankani (http://www.aslambari.com/stripe_apex_toolkit.html)
@Date             : 6 Oct, 2011
@Description      : This class is common test class for all stripe related class.
                      
*/
public class TestStripe{
    
    @isTest
    public static void testStripe(){
        Stripe str=new Stripe('y001LvDyqiGbNZclWQfgVQ7JixuOJk8w');
        str.createCharge('4242424242424242','2013','12','123','200','usd','test');
        str.createCharge('cus_wCA0LuIzUzRYZp','200','usd','test');
        str.retrieveCharge('ch_GhUBmjVvkX3Wmd');
        str.createCustomer('4242424242424242','12','2013','123','sanjay','add1','add2','305001','Rajasthan','India','gamer.sanjay@gmail.com','Test');
        str.retrieveCustomer('cus_wCA0LuIzUzRYZp');
        
        str.createInvoice('cus_wCA0LuIzUzRYZp','200','usd','Test');
        str.retreiveInvoice('ii_JwpRLT7TOQLZvK');
        str.createPlan('gold','200','usd','month','Test Plan');
        str.retrievePlan('gold');
    }
    
    @isTest    
    public static void testStripeCharge(){
        StripeCharge StrChr=new StripeCharge('y001LvDyqiGbNZclWQfgVQ7JixuOJk8w');
        StripeResponseModel StripeResponseModel=new StripeResponseModel();
        StripeResponseModel=strChr.CreateCharge('4242424242424242','2013','12','123','200','usd','description');
        system.assert(StripeResponseModel!=null,'Invalid');
        
        StripeResponseModel StripeResponseModel1=new StripeResponseModel();
        StripeResponseModel1=strChr.retrieveCharge('ch_GhUBmjVvkX3Wmd');
        system.assert(StripeResponseModel1!=null,'Invalid');
        
        StripeResponseModel StripeResponseModel2=new StripeResponseModel();
        StripeResponseModel2=strChr.CreateCharge('cus_wCA0LuIzUzRYZp','200','usd','Test');
        system.assert(StripeResponseModel2!=null,'Invalid');        
    }        
    
    @isTest
    public static void testStripeCustomer(){
        StripeCustomer strCust= new StripeCustomer('y001LvDyqiGbNZclWQfgVQ7JixuOJk8w');
        StripeResponseModel StripeResponseModel=new StripeResponseModel();
        StripeResponseModel=strCust.createCustomer('4242424242424242','12','2013','123','sanjay','add1','add2','305001','Rajasthan','India','gamer.sanjay@gmail.com','Test');
        system.assert(StripeResponseModel!=null,'Invalid');
        
        StripeResponseModel StripeResponseModel1=new StripeResponseModel();
        StripeResponseModel1=strCust.retrieveCustomer('cus_wCA0LuIzUzRYZp');
        system.assert(StripeResponseModel1!=null,'Invalid');
    }
        
    @isTest
    public static void testStripeInvoice(){
        StripeInvoice strInv=new StripeInvoice('y001LvDyqiGbNZclWQfgVQ7JixuOJk8w');
        StripeResponseModel StripeResponseModel=new StripeResponseModel();
        StripeResponseModel=strInv.createInvoice('cus_wCA0LuIzUzRYZp','200','usd','Test');
        system.assert(StripeResponseModel!=null,'Invalid');
        
        StripeResponseModel StripeResponseModel1=new StripeResponseModel();
        StripeResponseModel1=strInv.retreiveInvoice('ii_JwpRLT7TOQLZvK');
        system.assert(StripeResponseModel1!=null,'Invalid');
    }
    
    @isTest
    public static void testStripePlan(){
        StripePlan strPlan=new StripePlan('y001LvDyqiGbNZclWQfgVQ7JixuOJk8w');
        StripeResponseModel StripeResponseModel=new StripeResponseModel();
        StripeResponseModel=strPlan.createPlan('gold','200','usd','month','Test Plan');
        system.assert(StripeResponseModel!=null,'Invalid');
        
        StripeResponseModel StripeResponseModel1=new StripeResponseModel();
        StripeResponseModel1=strPlan.retrievePlan('gold');
        system.assert(StripeResponseModel1!=null,'Invalid');
                
    }
}