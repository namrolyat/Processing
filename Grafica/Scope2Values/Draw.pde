void Draw(GPlot plot) {
  plot.beginDraw();
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
  plot.endDraw();
}
