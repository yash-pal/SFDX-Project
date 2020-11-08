public class emailHelper {
    
    public list<contact> contactList{get;set;}
    public list<wrpper> wrpperList{get;set;}
    public contact cont{get;set;}
    public emailHelper(){
        contactList = new list<contact>();
        wrpperList = new list<wrpper>();
        list<contact> contList = [select id,name,LastName,FirstName,salutation,Approval__c,Rejection__c from contact];
        for(contact contt : contList)
        {
            wrpperList.add(new wrpper(contt,false));
        }
    }
    
    public PageReference SavePage()
    {
        list<contact> conList = new  list<contact>();
        system.debug('conts'+contactList);
        For(wrpper contss : wrpperList)
        {
            system.debug('chkkkk'+contss.chk);
            if(contss.chk)
            {
                system.debug('dddd');
                contss.cont.Approval__c = true;
                conList.add(contss.cont);
            }
        }
        update conList;
         Pagereference pr = new Pagereference('/apex/Authority');
         pr.setRedirect(true);
        return pr;
        
    }
    public class wrpper{
        public contact cont{get;set;}
        public boolean chk{get;set;}
         public boolean chk2{get;set;}
        public wrpper(contact cont,boolean chk)
        {
            chk = false;
            chk2 = false; 
            this.cont = cont;
            
        }
    }
    
}