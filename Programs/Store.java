public class Store {
	
	//isntance field 

	String productTotal;

	// storing the instance varb into the constructor 
	public Store(String Total) {

	productTotal = Total;

}
	public static void main(String[] args){

		Store dominos = new Store("Pizza");
		Store pizzaHut = new Store("Chicken");

		System.out.println(dominos.productTotal);
		System.out.println(pizzaHut.productTotal);
	}
}
