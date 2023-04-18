public class Player extends AnimatedSprite{
  int lives;
  boolean onPlatform, inPlace;
  PImage[] standLeft, standRight, jumpLeft, jumpRight;
  
  public Player(PImage image, float scale){
    super(image, scale);
    lives = 3;
    direction = right;
    onPlatform = false;
    inPlace = true;
    standLeft = new PImage[1];
    standLeft[0] = loadImage("leftidel.png");
    standRight = new PImage[1];
    standRight[0] = loadImage("rightidel.png");
    jumpLeft = new PImage[1];
    jumpLeft[0] = loadImage("l_jump.png");
    jumpRight = new PImage[1];
    jumpRight[0] = loadImage("r_jump.png");
   moveLeft = new PImage[4];
   moveLeft[0] = loadImage("l_walk1.png");
   moveLeft[1] = loadImage("l_walk2.png");
   moveLeft[2] = loadImage("l_walk3.png");
   moveLeft[3] = loadImage("l_walk4.png");
   moveRight = new PImage[4];
   moveRight[0] = loadImage("r_walk1.png");
   moveRight[1] = loadImage("r_walk2.png");
   moveRight[2] = loadImage("r_walk3.png");
   moveRight[3] = loadImage("r_walk4.png");
   currentImages = standRight;
  }
  
  @Override
  public void updateAnimation(){
    onPlatform = onPlatform(this, platforms);
    inPlace = vx == 0 && vy == 0;
    super.updateAnimation();
    
  }
  
  @Override
  public void selectDirection(){
    if(vx > 0)
      direction = right;
    else if(vx < 0)
      direction = left; 
  }
  
  @Override
  public void selectCurrentImages(){
    if (direction == right){
      if(inPlace){
        currentImages = standRight;
      }
      else if (!onPlatform){
        currentImages = jumpRight;
      }
      else{
        currentImages = moveRight;
      }
    }
      else if (direction == left){
      if(inPlace){
        currentImages = standLeft;
      }
      else if (!onPlatform){
        currentImages = jumpLeft;
      }
      else{
        currentImages = moveLeft;
      }
    }
  
  }


}
