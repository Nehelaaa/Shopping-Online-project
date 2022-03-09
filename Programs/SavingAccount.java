public class SavingAccount{

	int balance;


public SavingAccount(int Inbalance){

	balance = Inbalance;
}

public static void main(String[] args){
	SavingAccount saving = new SavingAccount(2000);

	System.out.println("Your total balance is" +saving.balance);

	int withdraw = saving.balance - 300;
	saving.balance = withdraw;

	System.out.println("You total amount after the withdraw is "+ saving.balance);

	//check balance 

	System.out.println("Hello your total balance");

	int afterDeposit = saving.balance + 500;
	saving.balance = afterDeposit;

	System.out.println("Your total balance is"+ " " + saving.balance);

	int 
	
}



}