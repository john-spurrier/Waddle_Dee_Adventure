
public class CaveEnemy extends AnimatedSprite{
  float lbound, rbound;
  public CaveEnemy(PImage img, float scale, float bLeft, float bRight){
    super(img, scale);
    moveLeft = new PImage[2];
    moveLeft[0] = loadImage("waddle_doo_cave_lwalk_1.png");
    moveLeft[1] = loadImage("waddle_doo_cave_lwalk_2.png");
    moveRight = new PImage[2];
    moveRight[0] = loadImage("waddle_doo_cave_rwalk_1.png");
    moveRight[1] = loadImage("waddle_doo_cave_rwalk_2.png"); 
    currentImages = moveLeft;
    direction = left;
    lbound = bLeft + random(30, 100);
    rbound = bRight + random(30, 100);
    if (difficulty == 1){
    vx = -1;
    }
    else if(difficulty == 2){
    vx = -2;
    }
    
  }
  void update(){
    super.update();
    
    
    
    if(getLeft() <= lbound){
      shiftLeft(lbound);
      vx *= -1;
    }
    else if(getRight() >= rbound){
      shiftRight(rbound);
      vx *= -1;
    }


  }
}
