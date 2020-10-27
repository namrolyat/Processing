void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');
  try {
    if (inString != null) {
      inString = trim(inString);                // trim off whitespaces.
      inBytes = float(split(inString, ','));

      //scope1.setYAxes(inBytes[0]);
      //scope2.setYAxes(inBytes[1]);
      yAxes1 = inBytes[0];
      yAxes2 = inBytes[1];
      yAxes3 = inBytes[2];
      yAxes4 = inBytes[3];
      newData = true;
    }
  } 
  catch (Exception e) {
    print("Exception: " + e);
  }
}
