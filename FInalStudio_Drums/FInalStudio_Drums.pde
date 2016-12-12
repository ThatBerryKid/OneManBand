//Drums for Mr. Daniel
//JW.Berry
//Alessio
//Fernanda
//Patrick


import processing.sound.*;
import processing.serial.*;
import cc.arduino.*;
import ddf.minim.*;

SoundFile soundfile, myNameIs;
Arduino arduino;
Minim minim;
PImage rightHand1, leftHand1, rightHand2, leftHand2;
AudioSample beat1;
AudioSample beat2;

boolean sound1 = false;
boolean sound2;
boolean filledScreen=false;

void setup() {
  //comment out fr fullscreen modes
  //fullScreen(); filledScreen=true;
  //comment this, if fullScreen ^ are on/true
  size(600, 600);
  background(255);

  soundfile  = new SoundFile(this, "hihat.wav");
  myNameIs   = new SoundFile(this, "myNameIs.wav");
  rightHand1 = loadImage("mrDaniel_RHand_Up.png");
  rightHand2 = loadImage("mrDaniel_RHand_Down.png");
  leftHand1  = loadImage("mrDaniel_LHand_Up.png");
  leftHand2  = loadImage("mrDaniel_LHand_Down.png");
  //soundfile.loop();
  printArray(Serial.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  minim = new Minim(this);
  beat1 = minim.loadSample( "Sound7.wav", 512 );
  if ( beat1 == null ) println("Didn't get Hi Hat");
  arduino.pinMode(0, Arduino.INPUT);
  arduino.pinMode(1, Arduino.INPUT);
  myNameIs.play();
  myNameIs.rate(.5);
}

void draw() {
  background(247, 168, 150);
  int thresholdSound = 30;
  int bodyWidth = 250;
  int bodyHeight = 800;
  float servoWidth = 12.5;
  int servoDialWidth = 25;
  noStroke();
  
  //head
  fill(220);
  rect(width/2-bodyWidth/2, height/16, bodyWidth, 165, 9);
  
  //his left arm
  if (filledScreen) {
    image(leftHand1, width/2, height/11, 300, 395);
  } else {
    if (arduino.analogRead(1)<=thresholdSound) {
      image(leftHand1, width/2, -15, 300, 395);
    }
  } 
  fill(205);
  rect(width/2+bodyWidth/2, height/2, servoDialWidth, 25);

  fill(0, 0, 255, 150);
  rect(width/2+bodyWidth/2, height/2, servoWidth, 80);

  //his right arm
  if (filledScreen) {
    image(rightHand1, width/2-bodyWidth, height/11, 300, 395);
  } else {
    if (arduino.analogRead(0)<=thresholdSound) {
      image(rightHand1, width/2-bodyWidth, -15, 300, 395);
    }
  }  

  fill(205);
  rect(width/2-bodyWidth/2-servoDialWidth, height/2, servoDialWidth, 25);

  fill(0, 0, 255, 150);
  rect(width/2-bodyWidth/2-servoWidth, height/2, servoWidth, 80);




  //body
  fill(187);
  rect(width/2-bodyWidth/2, height/3, bodyWidth, bodyHeight, 9);
  
  fill(230);
  rect(width/2-bodyWidth/2, height/3, bodyWidth-15, bodyHeight, 9);
  


  //right & left arms drummin
  if (!filledScreen) {
    if (arduino.analogRead(0)>=thresholdSound) {
      image(rightHand2, width/2-bodyWidth, height/2-15, 300, 395);    
      fill(205);
      rect(width/2-bodyWidth/2-servoDialWidth, height/2, servoDialWidth, 25);
      fill(0, 0, 255, 150);
      rect(width/2-bodyWidth/2-servoWidth, height/2, servoWidth, 80);
    }
  }
  if (!filledScreen) {
    if (arduino.analogRead(1)>=thresholdSound) {
      image(leftHand2, width/2, height/2-15, 300, 395);    
      fill(205);
      rect(width/2+bodyWidth/2, height/2, servoDialWidth, 25);
      fill(0, 0, 255, 150);
      rect(width/2+bodyWidth/2, height/2, servoWidth, 80);
    }
  }






  rect(width-50, height-50, 40, -40-arduino.analogRead(0)/2);
  rect(width-110, height-50, 40, -40-arduino.analogRead(1)/2);

  if (arduino.analogRead(0) >=thresholdSound) {
    soundfile.play();
  }
  if (arduino.analogRead(1) >=thresholdSound) {
    beat1.trigger();
  }
  
  
  println(arduino.analogRead(0) + " " + arduino.analogRead(1));
}