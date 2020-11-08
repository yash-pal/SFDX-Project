public class AccountObjectPop{
Public List<Account>AccList{get;set;}
public string accid {get;set;}
public boolean show {get;set;}
public account acc {get;set;}


Public AccountObjectPop(){
    show = false ;
    AccList = New List<Account>();
    acc = new account();
    AccList = [Select Id,Name,Phone,Industry,Rating From Account limit 1000];
   
    }
    public void showpopup(){
        show = true;
         acc = [Select Id,Name,Phone,Industry,Rating From Account  where id =:accid];
    }
    public void closepopup(){
        show = false;
    }
    Public void Saved(){  
        upsert acc;
        show=true;
         acc = [Select Id,Name,Phone,Industry,Rating From Account  where id =:accid];
    }
    Public void Deleted(){
        delete Acc;
        acc=new account();
        show = true;
        AccList = [Select Id,Name,Phone,Industry,Rating From Account limit 1000];
    }
}