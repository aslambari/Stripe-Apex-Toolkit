/*
@Name             : StripeGetResponseValues
@Author           : Aslam Bari/Sanjay Mankani (http://www.aslambari.com/stripe_apex_toolkit.html)
@Date             : 6 Oct, 2011
@Description      : This class contains methods to parse response from Stripe.
                      
*/

public class StripeGetResponseValues{

    public string getValue(string accRecordJson, string fieldName){
        integer startIdx = accRecordJson.indexOf(fieldName);
        integer endIdx = -1;
        if(startIdx > 0){
            endIdx = accRecordJson.indexOf('",', startIdx);
        }
        if(startIdx > 0 && endIdx > startIdx){
            
            return accRecordJson.substring(startIdx + fieldName.length() + 2,endIdx);
        }
        return '';
   }
  
   public string getNumValue(string accRecordJson, string fieldName){
    integer startIdx = accRecordJson.indexOf(fieldName);
    integer endIdx = -1;
    if(startIdx > 0){
        endIdx = accRecordJson.indexOf(',', startIdx);
    }
    if(startIdx > 0 && endIdx > startIdx){
        //system.debug('### ' +startIdx + '---' + endIdx);
        return accRecordJson.substring(startIdx + fieldName.length() + 1,endIdx);
    }
    return '';
   }
   
   public string getLastValue(string accRecordJson, string fieldName){
        integer startIdx = accRecordJson.indexOf(fieldName);
        integer endIdx = -1;
        if(startIdx > 0){
            endIdx = accRecordJson.indexOf('"\n', startIdx);
        }
        system.debug('$$startIdx='+startIdx);
        system.debug('$$endIdx='+endIdx);
        if(startIdx > 0 && endIdx > startIdx){                    
            return accRecordJson.substring(startIdx + fieldName.length() + 2,endIdx);
        }
        return '';
   }
   
   /*public string getLastNumValue(string accRecordJson, string fieldName){
        integer startIdx = accRecordJson.indexOf(fieldName);
        integer endIdx = -1;
        if(startIdx > 0){
            endIdx = accRecordJson.indexOf('\n', startIdx);
        }
        system.debug('$$startIdx='+startIdx);
        system.debug('$$endIdx='+endIdx);
        if(startIdx > 0 && endIdx > startIdx){                    
            return accRecordJson.substring(startIdx + fieldName.length() + 2,endIdx);
        }
        return '';
   }*/
}