public class MyJavaClass {
    private int myState = 42;

    public static void main(String [] args) {
	System.out.println("Welcome to MyJavaClass, " + args[0] + ".");

	MyJavaClass myInstance = new MyJavaClass();
	System.out.println(" An object of this type happens to have state: " + myInstance.getState());
    }

    public int getState() {
	return myState;
    }


}

