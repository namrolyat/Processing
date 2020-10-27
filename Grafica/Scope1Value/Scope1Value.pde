/*
    /// Programmer: Uriel Plones
    /// Date: 16-10-2020
    /// Version: 1.0
    
    Copied the base from grafica\Defaultplot examples
    Adjusted it to an ascilloscope function.
    
    A serial event occurs whenever a serial string is read on the specified com port.
    In the interrupt routine, the string is split at comma's and the split parts are converted to floats.
    The values are sored in a float array and a boolean is set, indicating there's new data.
    
    main loop:
    Whenever new data is received, a point is added to a graph. This continues until the last value of the
    x-axis is reached. Another new data point will delete the previous data and set the x-value back to zero.
    This repeats until you quit.
    
    The documentation, and the examples helped that comes with this library helped me a lot to get this to work. 
    
 */

import grafica.*;
import processing.serial.*;

Serial myPort;

GPoint graphPoint = new GPoint(0,0);
GPlot plot;
float inBytes[] = {0.0, 0.0};   // incoming serial data
boolean newData = false;
float yAxes, yAxes2;
int xAxes = 30;
float scale= 5;
int lastStepTime = 0;
int step =0;

void setup() {
  size(500, 350);

  myPort = new Serial(this, "com7", 115200);
  myPort.bufferUntil('\n');

  // Prepare the first set of points
  int nPoints1 = xAxes;
  GPointsArray points1 = new GPointsArray(nPoints1);
  
  for (int i = 0; i < nPoints1; i++) {
    points1.add(i,0);
  }


  // Create a new plot and set its position on the screen
  plot = new GPlot(this, 25, 25);
  //plot = new GPlot(this, 25, 25, 300, 300);
  
  plot.setYLim(0,1024);
  plot.setFixedYLim(true);
  plot.setXLim(0, xAxes);
  plot.setFixedXLim(true);
  
  // Set the plot title and the axis labels
  plot.getTitle().setText("Scope Values");
  plot.getXAxis().getAxisLabel().setText("x-axis");
  plot.getYAxis().getAxisLabel().setText("y-axis");
  
  // Activate the panning effect
  //plot.activatePanning();
  
  // Add the set of points to the plot
  plot.setPoints(points1);
}


void draw() {
  background(150);
  
  plot.beginDraw();
  plot.drawBackground();
  plot.drawBox();
  plot.drawXAxis();
  plot.drawYAxis();
  plot.drawTitle();
  //plot.drawGridLines(GPlot.BOTH);
  plot.drawLines();
  plot.drawPoints();
  plot.endDraw();
  
  if (newData) {
      //
      println(step, yAxes);
      graphPoint.setXY(step,yAxes);
    
      //plot.removePoint(step);
      plot.addPoint(graphPoint);
      
      step++;
      if( step >= xAxes) {
        step = 0;
        plot.setPoints(new GPointsArray());
      }
          
      //delay(10);

  } // if(newData)
  
}

void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
  try {
    if (inString != null) {
      inString = trim(inString);                // trim off whitespaces.
      inBytes = float(split(inString, ','));

      //scope1.setYAxes(inBytes[0]);
      //scope2.setYAxes(inBytes[1]);
      yAxes = inBytes[0];
      yAxes2 = inBytes[1];

      newData = true;
    }
  } 
  catch (Exception e) {
    print("Exception: " + e);
  }
}
