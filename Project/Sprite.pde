class Sprite{

  PImage img;
  float x, y;
  float vx, vy;
  float w, h;
  float maxSpeed = 3;
  float gravity = .5;

  public Sprite(String filename, float scale, float xPos, float yPos){
    img = loadImage(filename);
    w = img.width * scale;
    h = img.height * scale;
    x = xPos;
    y = yPos;
    vx = 0;
    vy = 0;
  }
  public Sprite(String filename, float scale){
    this(filename, scale, 0, 0);
  }
  public Sprite(PImage image, float scale){
  img = image;
    w = img.width * scale;
    h = img.height * scale;
    x = 0;
    y = 0;
    vx = 0;
    vy = 0;
  
  }
  
  public void display(){
    image(img, x, y, w, h);
  }
 
 public void update(){
   x += vx;
   y += vy;
   vy += gravity;
 }
 
  public void shiftLeft(float left){
    x = left + w/2;
  }
  float getLeft(){
    return x - w/2;
  }
  public void shiftRight(float right){
    x = right - w/2;
  }
  float getRight(){
    return x + w/2;
  }
  
  public void shiftTop(float top){
    y = top + h/2 + 50;
  }
  float getTop(){
    return y - h/2 + 4;
  }
  public void shiftBottom(float bottom){
    y = bottom - h/2;
  }
  float getBottom(){
    return y + h/2;
  }


}
