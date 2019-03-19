class Sun{
   
  int radius;
  float distance;
  float angle;
  float speed;
  PVector vector;
  PShape star;
  boolean detection;
  
  Sun(int radius, float distance, float angle, float speed, PVector vector){
    this.radius = radius;
    this.distance = distance;
    this.angle = angle;
    this.speed = speed;
    this.vector = vector;
    
    noStroke();
    star = createShape(SPHERE, radius);
    star.setFill(color(249, 255, 49));
    
    detection = false;
   }
   
   public void detectionSmile(boolean d){
     detection = d;
   }

  void display(){
    if(detection){
      lights();
      directionalLight(255, 255, 255, width/2, height/2, (height/2.0) / tan(PI*30.0 / 180.0));
      ambientLight(71, 71, 71);
      translate(vector.x, vector.y, vector.z);
      pushMatrix();
      rotateY(radians(angle));
      lightSpecular(255, 255, 255);
      shape(star);
      popMatrix();
    }
  }
}
