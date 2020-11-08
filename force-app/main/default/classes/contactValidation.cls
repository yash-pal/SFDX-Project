public with sharing class contactValidation {
    
    List<contact> coList{get;set;}
    public list<wrpper> wrpperList{get;set;}
    public Integer totalSize = 0;
    public Integer PageSize = 0; 
    
    
    public contactValidation(){
        wrpperList = new list<wrpper>();
        list<contact> contList = [select id,name,LastName,FirstName,salutation,Approval__c,Rejection__c from contact];
        
        for(contact contt : contList)
        {
            wrpperList.add(new wrpper(contt,false));
        }
    }
    
    public PageReference Action(){
        list<contact> conList = new  list<contact>();
        For(wrpper contss : wrpperList){
            if(contss.wrp){
                contss.cont.Approval__c = true;
                conList.add(contss.cont);
            }
        }
        Pagereference pr = new Pagereference('/apex/visualTable');
        pr.setRedirect(true);
        return pr;
    }   
    public class wrpper{
        public contact cont{get;set;}
        public boolean wrp{get;set;}
        
        public wrpper(contact cont,boolean chk)
        {
            wrp = false;
            this.cont = cont;
            
        }
    }
    public boolean Next(){
        
        return null;
    }
    public boolean Previous(){
        return null;
    }
    public boolean Last(){
        return null;  
    }
}