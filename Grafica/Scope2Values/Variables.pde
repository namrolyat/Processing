/******** Variables from version 1.0 **************************/

GPoint graphPoint1 = new GPoint(0,0);
GPoint graphPoint2 = new GPoint(0,0);
GPoint graphPoint3 = new GPoint(0,0);
GPoint graphPoint4 = new GPoint(0,0);
GPlot plot1, plot2, plot3, plot4;  

float inBytes[] = {0.0, 0.0};   // incoming serial data
boolean newData = false;        // boolean to indicate new data is read
float yAxes1, yAxes2, yAxes3, yAxes4;   // global variables for data read
int xAxes = 60;                 // x-axis value                
int step = 0;                   // variable to step through the xAxes

// Prepare the points for the four plots
GPointsArray points1 = new GPointsArray(xAxes);
GPointsArray points2 = new GPointsArray(xAxes);
GPointsArray points3 = new GPointsArray(xAxes);
GPointsArray points4 = new GPointsArray(xAxes);
  


/******** Added values for version 1.1 **************************/

  float[] firstPlotPos = new float[] {0, 0};
  float[] panelDim = new float[] {250, 250};
  float[] margins = new float[] {60, 70, 40, 30};
