public class Flag extends AnimatedSprite{
  
  public Flag(PImage img, float scale){
    super(img, scale);
    standNeutral = new PImage[3];
    standNeutral[0] = loadImage("flag1.png");
    standNeutral[1] = loadImage("flag2.png");
    standNeutral[2] = loadImage("flag3.png");
    currentImages = standNeutral;
    
  }
}
