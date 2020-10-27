/*
    /// Programmer: Uriel Plones
 /// Date: 16-10-2020
 /// Version: 1.1
 
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
 
 Revision 1.1: This version expands the numer of values read and data plots plotted an the screen. Used the
 example MultiPanels as inspiration.
 Revision 2_1: make a function plotSetup
 */

import grafica.*;
import processing.serial.*;

Serial myPort;

GPlot plot1;  //declare plot1 globally

void setup() {
  size(750, 700);   //(500, 350);
  background(255);

  myPort = new Serial(this, "com7", 115200);
  myPort.bufferUntil('\n');

  for (int i = 0; i < xAxes; i++) {
    points1.add(i, 0);
    points2.add(i, 0);
    points3.add(i, 0);
    points4.add(i, 0);
  }
  /***********************************************************************************/
  
  
  // Create four plots to represent the 4 panels
  
  plot1 = new GPlot(this);
  //plot1 = plotSetup(1);
  
  plot1.setPos(firstPlotPos);
  plot1.setMar(0, margins[1], margins[2], 0);
  plot1.setDim(panelDim);
  plot1.setAxesOffset(0);
  //plot1.setTicksLength(-4);
  plot1.getXAxis().setDrawTickLabels(false);
  plot1.setPointSize(3);

  //plot2 = new GPlot(this);
  ////plotSetup(2);

  //plot2.setPos(firstPlotPos[0] + margins[1] + panelDim[0], firstPlotPos[1]);
  //plot2.setMar(0, 0, margins[2], margins[3]);
  //plot2.setDim(panelDim);
  //plot2.setAxesOffset(0);
  ////plot2.setTicksLength(-4);
  //plot2.getXAxis().setDrawTickLabels(false);
  //plot2.getYAxis().setDrawTickLabels(false);
  //plot2.setPointSize(3);

  //plot3 = new GPlot(this);
  ////plotSetup(3);
  
  //plot3.setPos(firstPlotPos[0], firstPlotPos[1] + margins[2] + panelDim[1]);
  //plot3.setMar(margins[0], margins[1], 0, 0);
  //plot3.setDim(panelDim);
  //plot3.setAxesOffset(0);
  ////plot3.setTicksLength(-4);
  //plot3.setPointSize(3);

  //plot4 = new GPlot(this);
  //plot4.setPos(firstPlotPos[0] + margins[1] + panelDim[0], firstPlotPos[1] + margins[2] + panelDim[1]);
  //plot4.setMar(margins[0], 0, 0, margins[3]);
  //plot4.setDim(panelDim);
  //plot4.setAxesOffset(0);
  ////plot4.setTicksLength(-4);
  //plot4.getYAxis().setDrawTickLabels(false);
  //plot4.setPointSize(3);

  /*****************************************************************************************/

  //plot1.setYLim(0, 1024);
  //plot1.setFixedYLim(true);
  //plot1.setXLim(0, xAxes);
  //plot1.setFixedXLim(true);

  // Set the plot title and the axis labels
  //plot1.getTitle().setText("Scope Values");
  //plot1.getXAxis().getAxisLabel().setText("x-axis");
  //plot1.getYAxis().getAxisLabel().setText("y-axis");

  //plot2.setYLim(0, 1024);
  //plot2.setFixedYLim(true);
  //plot2.setXLim(0, xAxes);
  //plot2.setFixedXLim(true);

  //plot3.setYLim(0, 1024);
  //plot3.setFixedYLim(true);
  //plot3.setXLim(0, xAxes);
  //plot3.setFixedXLim(true);
  
  //plot4.setYLim(0, 1024);
  //plot4.setFixedYLim(true);
  //plot4.setXLim(0, xAxes);
  //plot4.setFixedXLim(true);

  //// Add the set of points to the plot
  //plot1.setPoints(points1);
  //plot2.setPoints(points2);
  //plot3.setPoints(points3);
  //plot4.setPoints(points4);
}


void draw() {
  //background(150);

  Draw(plot1);
  //Draw(plot2);
  //Draw(plot3);
  //Draw(plot4);
 
  if (newData) {
  //  //
  //  print(step); print("  "); print(yAxes1); print("  "); print(yAxes2); 
  //  print("  "); print(yAxes3); print("  "); println(yAxes4);
    graphPoint1.setXY(step,yAxes1);
  //  graphPoint3.setXY(step,yAxes1);
    plot1.addPoint(graphPoint1);
  //  plot3.addPoint(graphPoint3);
    
  //  graphPoint2.setXY(step,yAxes2);
  //  graphPoint4.setXY(step,yAxes2);
  //  plot2.addPoint(graphPoint2);
  //  plot4.addPoint(graphPoint4);
    

    step++;
    if ( step >= xAxes) {
      step = 0;
      plot1.setPoints(new GPointsArray());
  //    plot2.setPoints(new GPointsArray());
  //    plot3.setPoints(new GPointsArray());
  //    plot4.setPoints(new GPointsArray());
    }

    delay(100);
  } // if(newData)
}
