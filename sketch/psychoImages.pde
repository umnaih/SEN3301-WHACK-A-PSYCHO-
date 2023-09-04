import java.io.*;
import java.util.ArrayList;
import java.util.Random;
public class psycoImages{
  int xPos, yPos;
  int xPos2, yPos2;
  int speed=10;
  point [] pointArray= new point[9];
  PImage p1,p2,p3,p4,p5;
  ArrayList<PImage> images = new ArrayList<PImage>(3);
  ArrayList<PImage> images2 = new ArrayList<PImage>(2);
  PImage disPaly;
  Timer timeForimag;
  int index;
  int index2;
  
  public psycoImages(){
   timeForimag= new Timer(1000);
   timeForimag.start();
   point po1 = new point(700,100);
   point po2 = new point(700,460);
   point po3 = new point(700,800);
   point po4 = new point(970,100);
   point po5 = new point(970,460);
   point po6 = new point(970,800);
   point po7 = new point(1250,100);
   point po8 = new point(1250,460);
   point po9 = new point(1250,800);
        
    p1 = loadImage("michael.png");
    p2 = loadImage("psycho2.png");
    p3 = loadImage("samara.png");
    p4 = loadImage("zombie.png");  
    p5 = loadImage("psycho3.png");      
  
    images.add(p1);
    images.add(p2);
    images.add(p3);
    images2.add(p4);
    images2.add(p5);
    
    pointArray[0]=po1;
    pointArray[1]=po2;
    pointArray[2]=po3;
    pointArray[3]=po4;
    pointArray[4]=po5;
    pointArray[5]=po6;
    pointArray[6]=po7;
    pointArray[7]=po8;
    pointArray[8]=po9;
    Randomize();
  }

void Randomize(){
   xPos=(pointArray[(int)(random(0,5))].x);
   yPos= (pointArray[(int)(random(0,5))].y);

   index = (int)(Math.random() * images.size()-1);   
  }  
  
  void RandomizeOther(){
   xPos2=(pointArray[(int)(random(6,9))].x);
   yPos2= (pointArray[(int)(random(6,9))].y);
   index2 = (int)(Math.random() * images2.size()-1);  
  }
}
