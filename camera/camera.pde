import java.lang.*;
import processing.video.*;
import cvimage.*;
import org.opencv.core.*;
import org.opencv.objdetect.CascadeClassifier;
import org.opencv.objdetect.Objdetect;

Capture cam;
CVImage img;

CascadeClassifier smile;
String smileFile;

Sun sun;
Rain[] drops = new Rain[100];

void setup() {
  size(640, 480, P3D);
  //Cámara
  cam = new Capture(this, width , height);
  cam.start(); 
  
  //OpenCV
  //Carga biblioteca core de OpenCV
  System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
  println(Core.VERSION);
  img = new CVImage(cam.width, cam.height);
  
  //Detectores
  smileFile = "C:\\Users\\admin\\Documents\\Processing\\libraries\\opencv\\sources\\data\\haarcascades\\haarcascade_smile.xml";
  smile = new CascadeClassifier(dataPath(smileFile));
  
  sun = new Sun(50, 0, 0, 0.25, new PVector(120, 100, 0));
  
  for(int i = 0; i < drops.length; i++){
    drops[i] = new Rain();
  }
}

void draw() {  
  if (cam.available()) {
    background(0);
    cam.read();
    
    //Obtiene la imagen de la cámara
    img.copy(cam, 0, 0, cam.width, cam.height, 
    0, 0, img.width, img.height);
    img.copyTo();
    
    //Imagen de grises
    Mat gris = img.getGrey();
    
    //Imagen de entrada
    image(img,0,0);
    
    //Detección y pintado de contenedores
    Mat grey = img.getGrey();
      
    MatOfRect smiles = new MatOfRect();
    smile.detectMultiScale(grey, smiles, 1.8, 22, 
    Objdetect.CASCADE_SCALE_IMAGE, 
    new Size(30, 30), new Size(150, 150));
    Rect [] smilesArr = smiles.toArray();
  
    if(smilesArr.length > 0){
      sun.detectionSmile(true);
      
    } else {
      sun.detectionSmile(false);
      for(int i = 0; i < drops.length; i++){
        drops[i].fall();
        drops[i].show();
      }
    }
    
    noFill();
    stroke(255,0,0);
    strokeWeight(4);
    
    for (Rect r : smilesArr) {  
      rect(r.x, r.y, r.width, r.height);
    }

    sun.display();
    
    smiles.release();
    gris.release();
  }
}
