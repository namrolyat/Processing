/*
    Copied the base from grafica\Defaultplot examples
 Trying to combine Scope_Class_2
 */

import grafica.*;
import processing.serial.*;

Serial myPort;

float inBytes[] = {0.0, 0.0};   // incoming serial data
boolean newData = false;
float yAxes, yAxes2;
int xAxes = 20;

public GPlot plot;

//Scope scope1; //, scope2;


void setup() {
  size(500, 350);

  myPort = new Serial(this, "com4", 115200);
  myPort.bufferUntil('\n');

  // Create a new plot and set its position on the screen
  plot = new GPlot(this, 25, 25);
  // Set the plot title and the axis labels
  plot.getTitle().setText("Mouse position");
  plot.getXAxis().getAxisLabel().setText("mouseX");
  plot.getYAxis().getAxisLabel().setText("-mouseY");
  plot.beginDraw();
  // Set the plot title and the axis labels
  plot.getTitle().setText("Mouse position");
  plot.getXAxis().getAxisLabel().setText("mouseX");
  plot.getYAxis().getAxisLabel().setText("-mouseY");
  plot.setYLim(0,1024);
  plot.setFixedYLim(true);
  //plot.setHorizontalAxesNTicks(20);
  plot.setXLim(0,20);
  plot.setFixedXLim(true);

  plot.drawBackground();
  plot.drawBox();
  plot.drawXAxis();
  plot.drawYAxis();
  plot.drawTitle();
  plot.drawGridLines(GPlot.BOTH);
  plot.drawLines();
  plot.drawPoints();
  plot.endDraw();
}


void draw() {
  background(150);
  
  //GPoint lastPoint = plot.getPointsRef().getLastPoint();

  if (newData) {
    for (int i =0; i < xAxes; i++) {
      print(i); print("  "); println(yAxes);
      plot.addPoint(i, yAxes);
     
      plot.beginDraw();
      plot.drawBackground();
      plot.drawBox();
      plot.drawXAxis();
      plot.drawYAxis();
      plot.drawTitle();
      plot.drawGridLines(GPlot.BOTH);
      plot.drawLines();
      plot.drawPoints();
      plot.endDraw();
     
      delay(1000);
      if ( i >= (xAxes - 1) ) {
        plot.setPoints(new GPointsArray());
        //i = 0;
      }

      
      // Reset the points if the user pressed the space bar
      if (keyPressed && key == ' ') {
        plot.setPoints(new GPointsArray());
      }
    } //for
  } // if
  
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
