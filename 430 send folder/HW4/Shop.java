import java.io.*;
import java.sql.*;
import java.util.Scanner;
import java.util.Random;
import java.util.*;



class Shop{
	// the host name of the server and the server instance name/id
	public static final String oracleServer = "dbs3.cs.umb.edu";
	public static final String oracleServerSid = "dbs3";

    static String customerN;
    static int customerId;
    static int customerBud;
    static HashSet<Integer> IDS = new HashSet<Integer>();

	public static void main(String args[]) {
		Connection conn = null;
		conn = getConnection();
		if (conn==null)
			System.exit(1);

		//now execute query
		Scanner input = new Scanner(System.in);
        //if input = -1, create a new user
		try {
		  // Create statement object
		  Statement stmt = conn.createStatement();
          System.out.print("customer ID (Enter -1 for new customers.): ");
          int id = input.nextInt();
          customerId = id;
          if(customerId == -1){
            customerId = generatingCustId(conn);


            System.out.println();
            System.out.print("Enter your Name:");
            Scanner in = new Scanner(System.in);
            String name = in.nextLine();
            System.out.print("Please enter your Budget:");
            int  budget= in.nextInt();
            try {
               PreparedStatement p = conn.prepareStatement("insert into customers values(?,?,?)");
                p.clearParameters();
                customerN = name;
                customerBud = budget;
                p.setInt(1,customerId);
                p.setString(2, name);
                p.setInt(3,budget);
                p.executeUpdate();

            } catch (Exception e) {
                e.printStackTrace();
            }

          }
          PreparedStatement p100 = conn.prepareStatement("select name, cid from customers where cid= ?");
          p100.setInt(1,customerId);
          ResultSet r100 = p100.executeQuery();
          if(r100.next())
          {
            customerN = r100.getString("name");
            System.out.println("Hi,"+ customerN);
            System.out.println("Your customer ID is :" + r100.getInt("cid"));

          }
          else
          {
            System.out.print("NO customer exits");
            System.exit(1);
          }

          System.out.println();
          System.out.println("Welcome  "+customerN);
          System.out.println();
          while(true)
          {

            System.out.println("You can pick either options");

            System.out.println("Press P to list all products");
            System.out.println("Press O to order a product");
            System.out.println("Press R to Return a product");
            System.out.println("Press S for Product Search");
            System.out.println("Press E list all orders(Expenditures)");
            System.out.println("Press C for current Budget");
            System.out.println("Press X for Exit");

            String in = input.next();
            char c  = in.charAt(0);


            Character c1 = Character.toUpperCase(c);

            if (c1.equals('P'))
            {
                System.out.println("All Products Availabe in the Store");


                    PreparedStatement p = conn.prepareStatement("select pid, name, price from products");
                    ResultSet r1 = p.executeQuery();
                    //ResultSet r = s.executeQuery("select pid, name, price from products");
                    if(r1.next()){
                        do{
                            System.out.print("Product ID: "+r1.getString("pid")+" ");
                            System.out.print("Product Name: "+r1.getString("name")+" ");
                            System.out.println("Product Price: $"+r1.getString("price"));
                        }while(r1.next());
                    }
                    else
                        System.out.println("There are no products");



            }


            else if(c1.equals('O')){


                System.out.println("Welcome to Ordering Departement");
                System.out.println();
                System.out.print("Enter the product id: ");

                int pid = input.nextInt();
                System.out.print("Please Enter the quantity: ");
                int quantity  = input.nextInt();
                int totalCost  = 0;

                    PreparedStatement p = conn.prepareStatement("select price from products where pid =?");
                    p.setInt(1,pid);
                    ResultSet r = p.executeQuery();
                    if(r.next()){
                        int price= r.getInt("price");
                        totalCost = price * quantity;
                        System.out.println(customerBud);
                        if(totalCost <=customerBud){
                            PreparedStatement p4 = conn.prepareStatement("select pid from sales where cid=? and pid=?");
                            p4.setInt(1,customerId);
                            p4.setInt(2,pid);
                            ResultSet r4 = p4.executeQuery();
                            if(r4.next()){
                                System.out.println("You already order this products");
                            }
                            else{
                                customerBud = customerBud - totalCost;
                                PreparedStatement p1 = conn.prepareStatement("update customers set budget =? where cid =?");
                                p1.setInt(1,customerBud);
                                p1.setInt(2,customerId);
                                ResultSet r1 = p1.executeQuery();
                                if(r1.next()){
                                    PreparedStatement p2 = conn.prepareStatement("insert into sales values(?,?,?)");
                                    p2.setInt(1,customerId)
                                    ;p2.setInt(2,pid);
                                    p2.setInt(3,quantity);
                                    ResultSet r2 = p2.executeQuery();
                                    if(r2.next()){
                                        PreparedStatement p3 = conn.prepareStatement("select budget from customers where cid =?");
                                        p3.setInt(1,customerId);
                                        ResultSet r3 = p3.executeQuery();
                                        if(r3.next()){
                                            System.out.println("Succesfully placing the order");
                                            System.out.println("Your availabe budget is now:"+r3.getInt("budget"));
                                        }
                                        else {
                                            System.out.println("error getting  the budget. Please try again");
                                        }
                                    } else System.out.println("error in the placing the orders. ");
                                }else System.out.println("error when updating budget");
                            }
                        }else{
                            System.out.println("Your order is too  expensive. Your budget is not allow it.");

                        }
                    }




            }

            else if(c1.equals('R')){
                System.out.println("Welcome to Returning department");
                System.out.println();

                System.out.println();
                System.out.print("Enter the product ID: ");
                int pid = input.nextInt();

                    PreparedStatement p = conn.prepareStatement("select quantity from sales where cid =? and pid=?");
                    p.setInt(1,customerId);
                    p.setInt(2,pid);
                    ResultSet r = p.executeQuery();
                    if(r.next()){
                        int quantity = r.getInt("quantity");
                        if((quantity - 1)>=0){
                            PreparedStatement p1 = conn.prepareStatement("update sales set quantity =? where cid=? and pid =?");
                            p1.setInt(2,customerId);
                            p1.setInt(1,(quantity-1));
                            p1.setInt(3,pid);
                            ResultSet r1 = p1.executeQuery();
                            if(r1.next()){
                                PreparedStatement p2 = conn.prepareStatement("select price from products where pid=?");
                                p2.setInt(1,pid);
                                ResultSet r2 = p2.executeQuery();

                                if(r2.next()){
                                    customerBud += r2.getInt("price");
                                    PreparedStatement p3 = conn.prepareStatement("update customers set budget =? where cid =?");
                                    p3.setInt(1,customerBud);
                                    p3.setInt(2,customerId);
                                    ResultSet r3 = p3.executeQuery();

                                    if(r3.next()){
                                        System.out.println("Return Processed succefully \nBudget is now: $"+customerBud);

                                    }
                                }
                                else
                                    System.out.println("Failing to  getting product price");
                            }
                        }else
                         System.out.println("We apologize but cant  return  this product");
                    }else
                        System.out.println("Your records showed you didnt order that product.");

            }
            else if(c1.equals('S')){
                System.out.println();
                System.out.println();

                System.out.print("Enter the product's name:");

                 String name = input.next();
                 //I tried to work it with %?% but wasn't working.

                PreparedStatement p = conn.prepareStatement("select pid, name, price from products where name like '%"+name+"%'");
                ResultSet r = p.executeQuery();

                if(r.next()){
                    do{
                        System.out.print("Product ID: "+r.getString("pid")+" ");
                        System.out.print("Product Name: "+r.getString("name")+" ");
                        System.out.println("Product Price: $"+r.getString("price"));
                    }while(r.next());
                }
                else
                    System.out.println("Product does not exist in the list");

            }
            else if(c1.equals('E')){
                System.out.println("Your history of orders");

                System.out.println();
                    PreparedStatement p = conn.prepareStatement("select p.pid as pid, p.name as name, s.quantity as quantity, p.price * s.quantity as total" +
                                                                 " from products p, sales s where p.pid=s.pid and s.cid=?");
                    p.setInt(1,customerId);
                    ResultSet r = p.executeQuery();
                    if(r.next()){
                        System.out.println("All Orders");
                        do{
                            System.out.print("ProductID: "+r.getInt("pid")+" ");
                            System.out.print("Product Name:"+r.getString("name")+" ");
                            System.out.print("Quantity:"+r.getInt("quantity")+" ");
                            System.out.println("Total Amount of Money Spent: $"+r.getInt("total"));
                            System.out.println();
                        }while(r.next());
                    }
                    else
                        System.out.println("There are no orders");
                        System.out.println();


            }
            else if(c1.equals('C')){
                PreparedStatement p = conn.prepareStatement("select budget from customers where cid =?");
                p.setInt(1,customerId);
                ResultSet r  = p.executeQuery();
                if(r.next()){

                    customerBud = r.getInt("budget");
                    System.out.println("Your current budget is: " + customerBud);
                }
                else{
                    System.out.println("You currently  dont have any budegt availabe.");
                }

            }
            else if(c1.equals('X')){
                System.exit(1);

            }
            else{
                System.out.println("Please enter the valid option");
            }


          }



		} catch (SQLException e) {
			System.out.println ("ERROR");
			e.printStackTrace();
		}
	}

	public static Connection getConnection(){

		// first we need to load the driver
		String jdbcDriver = "oracle.jdbc.OracleDriver";
		try {
			Class.forName(jdbcDriver);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// Get username and password
		Scanner input = new Scanner(System.in);
		System.out.print("Username:");
		String username = input.nextLine();
		System.out.print("Password:");
		//the following is used to mask the password
		Console console = System.console();
		String password = new String(console.readPassword());
		String connString = "jdbc:oracle:thin:@" + oracleServer + ":1521:"
				+ oracleServerSid;

		System.out.println("Connecting to the database...");

		Connection conn;
		// Connect to the database
		try{
			conn = DriverManager.getConnection(connString, username, password);
			System.out.println("Connection Successful");
		}
		catch(SQLException e){
			System.out.println("Connection ERROR");
			e.printStackTrace();
			return null;
		}

		return conn;
	}

    public static int generatingCustId(Connection conn) {
        try{


        PreparedStatement p50 = conn.prepareStatement("select cid from customers");
            ResultSet r50 = p50.executeQuery();
            if(r50.next()){
                do{
                    IDS.add(r50.getInt("cid"));
                }while(r50.next());
            }
            Random rand = new Random();
            int rand_int = rand.nextInt(1050);
            if(IDS.contains(rand_int)){
                rand_int = rand.nextInt(1050);
                generatingCustId(conn); }
            else
                return (rand_int);
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return 0;

    }

}
