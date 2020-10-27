/*
Hacked together by Gadget Reboot 2018 from two separate sources:
https://arduining.com/2013/08/05/arduino-and-processing-graph-example/
https://forum.processing.org/two/discussion/14060/#Comment_57867
 Based on the Tom Igoe example.
 Mofified by Arduining 17 Mar 2012:
  -A wider line was used. strokeWeight(4);
  -Continuous line instead of vertical lines.
  -Bigger Window size 600x400.
-------------------------------------------------------------------------------
This program takes ASCII-encoded strings
from the serial port at 9600 baud and graphs them. It expects values in the
range 0 to 1023, followed by a newline, or newline and carriage return
Created 20 Apr 2005
Updated 18 Jan 2008
by Tom Igoe
This example code is in the public domain.
-------------------------------------------------------------------------------

*/

import processing.serial.*;

Serial myPort;                // The serial port
float sensors[] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0};        // Array to read incoming serial data
float pSensors[] = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0};       // Array with previous value of sensors

boolean newData = false;
int xPos = 1;         // horizontal position of the graph 

//Variables to draw a continuous line.
int lastPosX = 1;
float[] lastPosY = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0};

void setup () {
  // set the window size:
  size(600, 400);        

  // List all the available serial ports
  // println(Serial.list());

  //myPort = new Serial(this, "ENTER_YOUR_COM_PORT_NAME_HERE!!!!!", 9600);  
  myPort = new Serial(this, "com7", 115200);  

  // A serialEvent() is generated when a newline character is received :
  myPort.bufferUntil('\n');
  background(0);      // set inital background:
}
void draw () {
    if (newData) {
        //Drawing a line from Last inByte to the new one.
        stroke(127,34,255);     //stroke color
        strokeWeight(2);        //stroke wider
    
        for(int numSens=0; numSens < sensors.length; numSens++) {
           switch(numSens){  
               case(0):
                   line(lastPosX, lastPosY[numSens], xPos, height - sensors[numSens]); 
                   lastPosY[numSens] = int(height-sensors[numSens]);
                   break;
                case(1):
                    stroke(127,134,155);
                    line(lastPosX, lastPosY[numSens], xPos, height - sensors[numSens]); 
                    lastPosY[numSens] = int(height-sensors[numSens]);
                    break;
                case(2):
                    stroke(27,200,155);
                    line(lastPosX, lastPosY[numSens], xPos, height - sensors[numSens]); 
                    lastPosY[numSens] = int(height-sensors[numSens]);
                    break;
                case(3):
                    stroke(0,249,255);
                    line(lastPosX, lastPosY[numSens], xPos, height - sensors[numSens]); 
                    lastPosY[numSens] = int(height-sensors[numSens]);
                    break;
                case(4):
                    stroke(249,0,255);
                    line(lastPosX, lastPosY[numSens], xPos, height - sensors[numSens]); 
                    lastPosY[numSens] = int(height-sensors[numSens]);
                    break;
                case(5):
                    stroke(149,200,0);
                    line(lastPosX, lastPosY[numSens], xPos, height - sensors[numSens]); 
                    lastPosY[numSens] = int(height-sensors[numSens]);
                    break;
                default:
                    break;
            }
        }
        lastPosX = xPos;
        // at the edge of the window, go back to the beginning:
        if (xPos >= width) {
            xPos = 0;
            lastPosX = 0;
            background(0);  //Clear the screen.
        } else {
            // increment the horizontal position:
            xPos++;
        }
        newData =false;
    } // if(newData)  
}  // draw

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);                // trim off whitespaces.
    //println(inString);
    
    // split the string at the commas and convert the sections into floats:
    pSensors = sensors;   // store sensor values before refreshing
    sensors = float(split(inString, ','));
    //println(sensors);
    
    for(int numSens=0; numSens < sensors.length; numSens++) {
        sensors[numSens] = map(sensors[numSens], 0, 1023, 0, height); //map to the screen height.  
        //print("Sensor " + numSens + ": " +  sensors[numSens] + "\t");
    }
    //print("\n");
    newData = true;
  }
}
