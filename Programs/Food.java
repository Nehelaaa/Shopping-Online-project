public class Food {

	///instance field 
	String productType;


	public Food(String product){
		productType = product;
	}


	public void advertise() {
		String message = "Selling" + productType + "!";
		System.out.println("message");
	}

public void GreetCustomers(String customers){

	System.out.println("Welcome to the our Store" + customers + "!");

}

public static void main(String[] args){

Food fools = new Food("chicken");
fools.GreetCustomers("Ahmad");
}

}