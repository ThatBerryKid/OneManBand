//JW.Berry
//Fernanda
//Alessio
//Partick

//Piezo's trigger most of the effects of this code

import processing.serial.*;
import cc.arduino.*;
import ddf.minim.*;

Arduino arduino;
Minim minim;

AudioSample kick;
AudioSample snare;


color beatCol;

void setup() {
  //fullScreen();
  size(550, 550);
  printArray(Serial.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  minim = new Minim(this);

  kick = minim.loadSample( "BD.mp3", 512 );
  if ( kick == null ) println("Didn't get kick!");

  snare = minim.loadSample("SD.wav", 512);
  if ( snare == null ) println("Didn't get snare!");


  beatCol = color(205, 5, 0);

  for (int i = 0; i <= 13; i++)
    arduino.pinMode(i, Arduino.INPUT);
}


void draw() {
  background(204, 200, 206);

  //I set some test thresholds
  //to change the color
  int thresholdCol = 377;
  //to trigger sounds
  int thresholdSound = 200;
  if ((arduino.analogRead(0) >=thresholdCol) || (arduino.analogRead(1) >=thresholdCol)|| (arduino.analogRead(2) >=thresholdCol)) {
    beatCol = color(random(255), random(255), random(255));
  }

  fill(beatCol);
  //display test ellipses
  //gave them a starting dimension, the drum adds on to the original diameter
  ellipse(width/3, height/2, 50+arduino.analogRead(0)/2, 50+arduino.analogRead(0)/2);

  ellipse(width/2, height/2, 50+arduino.analogRead(1)/2, 50+arduino.analogRead(1)/2);

  ellipse(width-width/3, height/2, 50+arduino.analogRead(2)/2, 50+arduino.analogRead(2)/2);

  //keep track of the numbers, so you can set a threshold number
  println("Drum 1: " + arduino.analogRead(0) + " Drum 2: " + arduino.analogRead(1) + " Drum 3: " + arduino.analogRead(2));

  //trigger sound by threshold
  if (arduino.analogRead(0) >=thresholdSound) {
    snare.trigger();
  }
  if (arduino.analogRead(3) >=thresholdSound) {
    kick.trigger();
  }
}
/* Testing test sounds
 void keyPressed() 
 {
 if ( key == 's' ) snare.trigger();
 if ( key == 'k' ) kick.trigger();
 }
*/