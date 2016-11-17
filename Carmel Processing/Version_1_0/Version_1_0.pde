import processing.serial.*;
import processing.video.*;

Movie myMovie;
Serial myPort;
PImage bg;
PImage bFull;
PImage bSemi;
PImage bLow;
PImage bNo;
String val;
int intValue;
int lf = 10;

void setup(){
  //size(1024, 768);
  fullScreen();
  bg = loadImage("fundo-branco.png");
  bFull = loadImage("Battery-full.png");
  bSemi = loadImage("Battery-semi-full.png");
  bLow = loadImage("Battery-low.png");
  bNo = loadImage("Battery-no.png");
  String portName = Serial.list()[0];
  printArray(Serial.list());
  myPort = new Serial(this, portName, 57600);
  myMovie = new Movie(this, "Lâmpadas com garrafas Pet.mp4");
  myMovie.loop();
  thread("runVideo");
}

void draw() {
  image(myMovie, 0, 0, 1024, 768);
}

void movieEvent(Movie m) {
  m.read();
}

void runVideo(){
  int bflag = 0;
  int pauseFlag = 0;
  while(1 == 1) {
    if(myPort.available() > 0) val = myPort.readStringUntil(lf);
    
    if(val != null){ 
      val = trim(val);
      intValue = (Integer.parseInt(val));  
    }
    
    if(intValue == 3){
      loop();
      myMovie.play();
      pauseFlag = 0;
    } else {
      if (intValue == 2){
        bflag = 1;
      }else if (intValue == 1){
        bflag = 2;
      } else {
        bflag = 3;
      }
      if(pauseFlag != 1) myMovie.pause();
      noLoop();
      pauseFlag = 1;
      //printBattery(bflag);
    }
  }
}

void printBattery(int var){
  //image(bg, 0, 0, 1024, 768);
  //imageMode(CENTER);
  background(255);
  
  if(var == 1) image(bFull, 250, 200, 581, 281);
  else if(var == 2) image(bSemi, 250, 200, 581, 281);
  else if(var == 3) image(bLow, 250, 200, 581, 281);
}