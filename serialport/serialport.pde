// open a serial port
// expects a stream of input strings, in the form of "# #\n"
// so send it a number followed by a space followed by a number and a newline from your microcontroller

// include the serial library
import processing.serial.*;

// make some Serial objects 
int numPorts = 1; // how many serial ports you want to use in this sketch
int numPortInList = 0; // the port you want to use, not the comm number but which one in the list made in the initSerial() function
int numPortUsing = 0; // which port you refer to, if you opened more than one
Serial myPorts[] = new Serial[numPorts]; // an array of serial objects

// initializations
void setup() {
  size(300,300);
  frameRate(30);
  println("Program started");
  initSerial(); // call a user written function to initialize the serial port, if there are none then exit the program
}

// infinite loop
void draw() {
  // your program here 
  
  // if the mouse is pressed, write the x and y position of the mouse out of the port
  // if you loop the serial tx to its rx as a test, this code will read the x y position and print it to the debug window
  if (mousePressed == true) {
    println("mouse pressed");
    myPorts[numPortUsing].write(mouseX + " " + mouseY + "\n");
  }
}

// initialize the serial port
void initSerial() {
  println(Serial.list()); // List all the available serial ports in the debug window

  // see how many ports there are, if there aren't any then exit
  if (Serial.list().length > 0) {

    String portList = Serial.list()[numPortInList]; // grab the name of the port you want to use
    myPorts[numPortUsing] = new Serial(this, portList, 19200); // initialize the serial port with a baud rate of 19200

    // read bytes into a buffer until you get a linefeed (ASCII 10):
    myPorts[numPortUsing].bufferUntil('\n');
  }
  else { // uh oh, no ports, exit the program
    println("No serial ports found!");
    exit();
  }
}

// serial event. This event is triggered when bytes appear in the serial port buffer
// check which port generated the event, just in case there are more than 1 ports talking
// this code expects to see a string with a number, a space, a number and a newline
// it extracts the two number from the string and prints them to the debug window
void serialEvent(Serial thisPort) { 
  // variable to hold the number of the port
  int portNumber = -1;

  // iterate over the list of ports opened, and match the one that generated this event
  for (int p = 0; p < myPorts.length; p++) {
    if (thisPort == myPorts[p]) {
      portNumber = p;
    }
  }

  // read the serial buffer as a string until a newline appears
  String myString = thisPort.readStringUntil('\n');

  // if you got any bytes other than the newline
  if (myString != null) {

    myString = trim(myString); // ditch the newline

    // split the string at the spaces, save as integers, can't do floats
    int dataFromSerial[] = int(split(myString, ' '));

    // check to make sure its the right port and there are the correct number of integers in the packet
    if ((dataFromSerial.length == 2)&&(portNumber==numPortUsing)) {
      // print what it got in the debug window
      print(dataFromSerial[0]);
      print(" ");
      println(dataFromSerial[1]);
    }
  }
} // end serialEvent

