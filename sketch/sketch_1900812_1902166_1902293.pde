psycoImages psycho;
int zoom=1;
int speed=-100;
int score=0;
float rotX = 0, rotY = 0;
int lastX, lastY;
float distX = 0, distY = 0;
int countdownTime = 0;
int maxTime;
boolean finish = false;
Timer time;
int mod = 0;
PFont f;
int timerDuration = 60; 
int currentTime;  
float timeLeftBarWidth; 
PImage[] hammer = new PImage[2];
boolean pause = false;

 void setup(){  
       time = new Timer(1000);
       currentTime = timerDuration;
       frameRate(7);
       size(displayWidth, displayHeight,P3D);
       psycho= new psycoImages();
       time.start();
       maxTime = 1;
       countdownTime = maxTime;
       f = loadFont("Quicksand-Light-48.vlw"); 
      hammer[0] = loadImage("hammer.png");
      hammer[1] = loadImage("hammerdown.png");
    }
    
void drawTimer() {
  if(!pause){
  currentTime = timerDuration - millis() / 1000; 
  timeLeftBarWidth = map(currentTime, 0, timerDuration, 350, 0); 
  fill(134, 72, 121);
  rect(width-displayWidth/9,height/2.4,100,timeLeftBarWidth); 
  fill(0);
  text(nf(currentTime / 60, 2) + ":" + nf(currentTime % 60, 2), width-displayWidth/9, height/2.4); 
  if(currentTime == 0){
    finish = true;
  }
    }
}
  
  void gameOverPage(){
    if(finish == true){
       background(134, 72, 121);
       cursor();
       textFont(f, 72);
       fill(255);
       textAlign (CENTER);
       text("Game Over\nScore = " + score, width/2, height/2);
    }
  }
  
    void YouWinPage(){
    if(psycho.index >-1){
       background(134, 72, 121);
       cursor();
       textFont(f, 72);
       fill(255);
       textAlign (CENTER);
       text("You win\nScore = " + score, width/2, height/2);
    }
  }
    
void ourBackground(){
  if(finish == false){
    background(53, 124, 60);//dark grren
    //edges of the screen
    fill(134, 72, 121);// drak brown
    stroke(0);
    rect(0,0,displayWidth/6,displayHeight);
    rect(width-displayWidth/6,0,displayWidth/6,displayHeight);
    
    
    // 9 holes
    for(int x = displayHeight/4; x < displayHeight; x+= displayHeight/4){
      for(int y = displayHeight/15; y < displayHeight; y+= displayHeight/3){
        PImage hole;
        hole = loadImage("hole.png");
        image(hole, x+width/6, y+height/15);
        
      }
    }
    
    //pause
    fill(245, 136, 64);
    strokeWeight(20);
    ellipse(width-displayWidth/13, height/6,250,250);
    PImage pause;
    pause = loadImage("pause.png");
    image(pause, width-displayWidth/7, height/20);
    
    //play
    strokeWeight(0);
    ellipse(width/13, height/6,245,245);
    PImage play;
    play = loadImage("play.png");
    image(play, width-displayWidth/0.98, height/34);
    
    //timebar template
    fill(55, 41, 72);
    rect(width-displayWidth/9,height/2.4,100,350);
  
   
    //pumpkin
    PImage pumpkin;
    pumpkin = loadImage("pumpkin.png");
    image(pumpkin, width/6, height/1.4);
    image(pumpkin, width-displayWidth/3.53, height/1.4);
    
    //siderweb
    PImage spiderWebLeft;
    spiderWebLeft = loadImage("spider-web.png");
    image(spiderWebLeft, width/6.03, displayHeight/1900);
    PImage spiderWebright;
    spiderWebright = loadImage("spider-web2.png");
    image(spiderWebright, width-displayWidth/2.730, displayHeight/1900);
    
    //happy hallowen
    PImage happyHalloween;
    happyHalloween = loadImage("halloween.png");
    image(happyHalloween, 0, height/1.4);
    
    // text
    fill(0);
    stroke(0);
    PFont font;
    font = createFont("Algerian", 50);
    textFont(font);
    text("YOUR SCORE", width/250, height/2);
    text("YOUR LIFE", width-displayWidth/7, height/1.2);
    text(score, displayWidth/15, height/2.5);
    
  }
    }

 void hammerCursor() {
    if (mousePressed) {
      image(hammer[1], mouseX-60, mouseY-60);
      for(int i = 0; i <= psycho.images.size()-1; i++){
         if((abs(mouseY - psycho.yPos) <= 200 && abs(mouseX - psycho.xPos) <= 200)){
           psycho.images.remove(psycho.index);
           score+=10; 
           break;
      }
      else{
      score-=1;
      } // in the project we should decrise if the user miss the hit
         }
         for(int i = 0; i <= psycho.images2.size(); i++){
         if((abs(mouseY - psycho.yPos2) <= 200 && abs(mouseX - psycho.xPos2) <= 200)){
           psycho.images2.remove(psycho.index2);// or here
           score+=10; 
           break;
      }
      else{
      score-=1;
      } 
         }
      
       /*if(abs(mouseY - height/20) <= 150 && abs(mouseX - width-displayWidth/0.98) <= 150){
        loop();}*/
       /* if(abs(mouseY - height/34) <= 400 && abs(mouseX -  width-displayWidth/7) <= 400){
        noLoop();
      }*/
      
  lastX = mouseX;
  lastY = mouseY;
    }
    else {
      image(hammer[0], mouseX-60, mouseY-60);
    }
  }
  
void draw(){
       ourBackground();
       drawTimer();
       
       pushMatrix();
       translate(0, 0, 2);
       hammerCursor();
       popMatrix();
       
       pushMatrix();
       translate(psycho.xPos,psycho.yPos,-50);
       rotateX(rotX + distY);
       rotateY(rotY + distX);
       scale(zoom);
       myCylinder();
       popMatrix();
       
       if(currentTime %5 ==0){
       pushMatrix();
       translate(psycho.xPos2,psycho.yPos2,-50);
       rotateX(rotX + distY);
       rotateY(rotY + distX);
       scale(zoom);
       otherCylinder();
       popMatrix();
       }
       
       if(finish == true){
       gameOverPage();
       } 
       if(psycho.images.size() <= 0 && psycho.images2.size() <= 0 ){
          YouWinPage();
        }
       
} 
 void myCylinder(){
  int speed=10; 
  int hC = 200, r = 70;
  int pieces = 36;
  float angle = 360 / pieces;
  int w=0;
  int h=0;
  //println(psycho.index);
  if(psycho.images.size() >=1){
   w = psycho.images.get(0).width;
   h=psycho.images.get(0).height;
  }else{
  gameOverPage();
  }

  beginShape(QUADS);
  if(psycho.images.size() >0){
   texture(psycho.images.get(psycho.index));
   if(mod % 10 == 0){
      psycho.Randomize();
    }
    mod++;
   psycho.yPos -= cos(psycho.yPos) * speed;
   if(psycho.yPos < psycho.yPos+50){
     psycho.yPos += cos(psycho.yPos) * speed;
   }   
  for(int i = 0; i < pieces; i++){
    vertex(r * cos(radians(i * angle)), -hC/2, r * sin(radians(i * angle)), i * w / pieces, 0);
    vertex(r * cos(radians((i + 1)*angle)), -hC/2, r * sin(radians((i + 1)*angle)), (i+1) * w / pieces, 0);
    vertex(r * cos(radians((i + 1)*angle)), hC/2, r * sin(radians((i + 1)*angle)), (i+1) * w / pieces, h);
    vertex(r * cos(radians(i * angle)), hC/2, r * sin(radians(i * angle)), i * w / pieces, h);
  }
  endShape();
 }
 else{
  gameOverPage();
  }
}

 void otherCylinder(){
  int speed=10; 
  int hC = 200, r = 70;
  int pieces = 36;
  float angle = 360 / pieces;
  int w=0;
  int h=0;

  if(psycho.images2.size() >=1){
   w = psycho.images2.get(0).width;
   h=psycho.images2.get(0).height;
  }
  beginShape(QUADS);
  if(psycho.images2.size() >0){
   texture(psycho.images2.get(psycho.index2));
   if(mod % 5 == 0){
      psycho.RandomizeOther();
    }
    mod++;
   psycho.yPos2 -= cos(psycho.yPos2) * speed;
   if(psycho.yPos2 < psycho.yPos2+50){
     psycho.yPos2 += cos(psycho.yPos2) * speed;
   }   
  for(int i = 0; i < pieces; i++){
    vertex(r * cos(radians(i * angle)), -hC/2, r * sin(radians(i * angle)), i * w / pieces, 0);
    vertex(r * cos(radians((i + 1)*angle)), -hC/2, r * sin(radians((i + 1)*angle)), (i+1) * w / pieces, 0);
    vertex(r * cos(radians((i + 1)*angle)), hC/2, r * sin(radians((i + 1)*angle)), (i+1) * w / pieces, h);
    vertex(r * cos(radians(i * angle)), hC/2, r * sin(radians(i * angle)), i * w / pieces, h);
  }
  endShape();
 }
 else{
  gameOverPage();
  }
}


void mouseDragged(){
  distX = radians(mouseX - lastX);
  distY = radians(lastY - mouseY);
}

void mouseReleased(){
  rotX += distY;
  rotY += distX;
  distX = distY = 0;
}

void keyPressed() {
  if (keyCode == UP) {
    zoom += 1;
  }else if(keyCode == DOWN) {
     zoom -= 1;
     if(zoom <=0){
     zoom=1;
     }
  }
  if ( key == 'p' || key =='P' ) {
    pause = !pause;

    if (pause) {
      noLoop();
    } else {
      loop();
    }
  }

}
