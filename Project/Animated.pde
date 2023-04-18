

public class AnimatedSprite extends Sprite{
  PImage[] currentImages;
  PImage[] standNeutral;
  PImage[] moveLeft;
  PImage[] moveRight;
  int direction;
  int index;
  int frame;

  public AnimatedSprite(PImage img, float scale){
    super(img, scale);    
    direction = idel;
    index = 0;
    frame = 0;
  }

  public void updateAnimation(){
    frame++;
    if(frame % 6 == 0){
      selectDirection();
      selectCurrentImages();
      advanceToNextImage();
    }
  }

  public void selectDirection(){
    if(vx > 0)
      direction = right;
    else if(vx < 0)
      direction = left;    
    else
      direction = idel;  
  }

 
  public void selectCurrentImages(){
    if(direction == right)
      currentImages = moveRight;
    else if(direction == left)
      currentImages = moveLeft;
    else
      currentImages = standNeutral;
  }

  public void advanceToNextImage(){
    index++;
    if(index >= currentImages.length)
      index = 0;
    img = currentImages[index];
  }
}
