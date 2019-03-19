class Rain {
  
  float x = random(width);
  float y = random(-500, -50);
  float yspeed = random(4, 10);
  float len = random(10, 20);
  boolean detection = false;
  
  public void detectionSmile(boolean d){
    detection = d;
  }

  void fall() {
    y = y + yspeed;
    yspeed = yspeed + 0.1;
      
   if(y > height){
     y = random(-200, -100);
     yspeed = random(4, 10);
   }
 }
  
  void show(){
    lights();
    stroke(49, 186, 255);
    line(x , y, x, y + len);
  }
}


 
