import processing.serial.*;
 
 Serial myPort;        // The serial port
 int xPos = 1;         // horizontal position of the graph
 
 void setup () {
 // set the window size:
 size(300, 300);
 smooth(); 
 
 // List all the available serial ports
 println(Serial.list());
 // I know that the first port in the serial list on my mac
 // is always my  Arduino, so I open Serial.list()[0].
 // Open whatever port is the one you're using.
 myPort = new Serial(this, Serial.list()[4], 9600);
 // don't generate a serialEvent() unless you get a newline character:
 myPort.bufferUntil('\n');
 // set inital background:
 //background(0);
 }
 void draw () {
   
  // background(0,0,0,100);
 // everything happens in the serialEvent()
 }
 
 void serialEvent (Serial myPort) {
 // get the ASCII string:
 String inString = myPort.readStringUntil('\n');
 
 //if (inString != null) {
 // trim off any whitespace:
 //inString = trim(inString);
 // convert to an int and map to the screen height:
 float inByte = float(inString); 
 inByte = map(inByte, 0, 1023, 0, width);
 
 // draw the line:
 translate(width/2, height/2);
 
 pushMatrix();
 rotate(radians(inByte));
 rectMode(CENTER);
 rect(0,0,inByte,inByte);
 //point(xPos, height - inByte);
 popMatrix();
 
 // at the edge of the screen, go back to the beginning:
 if (xPos >= width) {
 xPos = 1;
  
 } 
 else {
 // increment the horizontal position:
 //xPos++;
 //}
 }
 }
 
