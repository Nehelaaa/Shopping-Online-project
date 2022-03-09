 public class Market{


 public void greetCustomer(String customer){
    System.out.println("Welcome to the store, " + customer + "!");
  }
  // main method
  public static void main(String[] args) {
    Market lemonadeStand = new Market("Lemonade");
    lemonadeStand.greetCustomer("Ahmad");
    
  }
}