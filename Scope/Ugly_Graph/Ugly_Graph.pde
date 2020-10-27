import processing.serial.*;
 
Serial myPort; 
int xPos = 0;
float currentValue;
boolean newData = false;
 
void setup () { 
  size(400, 600);
  myPort = new Serial(this, Serial.list()[1], 115200);
  myPort.bufferUntil('\n'); 
  background(255); 
  stroke(0);
} 
void draw () { 
 
  if (newData) {
    // draw the line: 
    line(xPos, height, xPos, height - currentValue);
 
    // at the edge of the screen, go back to the beginning: 
    if (xPos >= width) { 
      xPos = 0; 
      background(255);
    } else { 
      xPos++;
    }
 
    newData =false;
  }
}
 
void serialEvent (Serial myPort) { 
  String inString = myPort.readStringUntil('\n');
 
  if (inString != null) { 
    inString = trim(inString); 
    currentValue = float(inString);
    currentValue = map(currentValue, 0, 1023, 0, height); 
    newData = true;
  }
}
