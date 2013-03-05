import processing.pdf.*;
import processing.serial.*;

/* 
Figura Organica
1101es13@gmail.com
mar 26 2011

*/

Serial myPort;       
int xPos = 1;

float currentRotation=0;

float perlinPosition=0;
float perlinSpeed=0.01;


float t=0.0;

void setup (){

  size(600,600);
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[4], 9600);
  myPort.bufferUntil('\n');
  
  smooth();

}

void draw(){
  
  void serialEvent (Serial myPort) {
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
  inString = trim(inString);
  float inByte = float(inString); 
  inByte = map(inByte, 0, 1023, 0, height);
  stroke(0,255,0);
  line(xPos, height, xPos, height - inByte);
  if (xPos >= width) {
  xPos = 0;
  background(0); 
  } 
  else {
  xPos++;
  }
  }
  }
  
  background(255,100);
  translate(width/2,height/2);
  rotate(currentRotation);
  strokeWeight(0.4);
  float arm=noise(perlinPosition)*300;
  
  stroke(255,0,0);
  line(0,0,arm,0);
  fill(255);
  ellipse(arm,0,10,10);
  
  currentRotation= currentRotation+0.01;
  perlinPosition= perlinPosition+perlinSpeed;
  
}


