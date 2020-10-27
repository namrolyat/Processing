float[] firstPlotPos = new float[] {0, 0};
float[] panelDim = new float[] {250, 250};
float[] margins = new float[] {60, 70, 40, 30};

GPlot plotSetup(int plotnum){
  GPlot plot = new GPlot(this);
  switch (plotnum) {
    case '1': 
    plot.drawBox();
    plot.drawGridLines(GPlot.BOTH);
    plot.setYLim(0, 1024);
    plot.setFixedYLim(true);
    plot.setXLim(0, xAxes);
    plot.setFixedXLim(true);
    
    plot.drawXAxis();
    plot.drawYAxis();
    plot.drawTopAxis();
    plot.drawRightAxis();
    plot.drawTitle();
    plot.drawPoints();
    plot.drawLines();
    plot.setPointSize(3);
    
    
        //plot1.setPos(firstPlotPos);
        //plot1.setMar(0, margins[1], margins[2], 0);
        //plot1.getXAxis().setDrawTickLabels(false);
        //plot1.setDim(panelDim);
        //plot1.setAxesOffset(4);
        //plot1.setTicksLength(-4);
        //plot1.setYLim(0, 1024);
        //plot1.setFixedYLim(true);
        //plot1.setXLim(0, xAxes);
        //plot1.setFixedXLim(true);
        //plot1.getTitle().setText("Scope Values");
        //plot1.getXAxis().getAxisLabel().setText("x-axis");
        //plot1.getYAxis().getAxisLabel().setText("y-axis");

        return plot;
        //break;
//    case '2':
//        plot2.setPos(firstPlotPos[0] + margins[1] + panelDim[0], firstPlotPos[1]);
//        plot2.setMar(0, 0, margins[2], margins[3]);
//        plot2.getXAxis().setDrawTickLabels(false);
//        plot2.getYAxis().setDrawTickLabels(false);
//        plot2.setDim(panelDim);
//        plot2.setAxesOffset(4);
//        plot2.setTicksLength(-4);
//        break;
//    case '3':
//        plot3.setPos(firstPlotPos[0], firstPlotPos[1] + margins[2] + panelDim[1]);
//        plot3.setMar(margins[0], margins[1], 0, 0);
//        plot3.setDim(panelDim);
//        plot3.setAxesOffset(4);
//        plot3.setTicksLength(-4);
//        break;
        
    default:
        return plot1;
    //    break;
  }  
}
