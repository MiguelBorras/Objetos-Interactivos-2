import processing.serial.*;
import oscP5.*;
import netP5.*;

 OscP5 oscP5;
 NetAddress myRemoteLocation;
 
 Serial myPort;        // The serial port
 int xPos = 1;         // horizontal position of the graph
 
 void setup () {
 size(1200, 300);
 oscP5 = new OscP5(this,12001);

 myRemoteLocation = new NetAddress("127.0.0.1",12001); 
 
 // List all the available serial ports
 println(Serial.list());
 // I know that the first port in the serial list on my mac
 // is always my  Arduino, so I open Serial.list()[0].
 // Open whatever port is the one you're using.
 myPort = new Serial(this, Serial.list()[4], 9600);
 // don't generate a serialEvent() unless you get a newline character:
 myPort.bufferUntil('\n');
 // set inital background:
 background(0);
 }
 void draw () {
   
 }
 
 void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}
 
 void serialEvent (Serial myPort) {
 // get the ASCII string:
 String inString = myPort.readStringUntil('\n');
 
 if (inString != null) {
 // trim off any whitespace:
 inString = trim(inString);
 // convert to an int and map to the screen height:
 float inByte = float(inString); 
 inByte = map(inByte, 0, 1023, 0, height);
 
  OscMessage m = new OscMessage("soundSensor");
   m.add(inByte);
   oscP5.send(m, myRemoteLocation);
 
 // draw the line:
 stroke(0,255,0);
 line(xPos, height/2, xPos, height/2 - inByte);
 
 // at the edge of the screen, go back to the beginning:
 if (xPos >= width) {
 xPos = 0;
 background(0); 
 } 
 else {
 // increment the horizontal position:
 xPos++;
 }
 }
 }
 
 
