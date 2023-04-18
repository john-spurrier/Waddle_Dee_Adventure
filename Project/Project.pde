import processing.sound.*;

boolean isMenu = true;
boolean start = false;
boolean controlMenu = false;
boolean levelSelect = false;
boolean difficultySelect = false;
int difficulty;
boolean gameOver = false;
boolean winState = false;
boolean isLoading = false;
boolean run1 = false;
boolean run2 = false;
boolean run3 = false;
boolean hurtBool = false;
boolean gameOverBool = false;
boolean victoryBool = false;
boolean menuBool = false;

SoundFile hurt;
SoundFile button;
SoundFile menu;
SoundFile first;
SoundFile second;
SoundFile third;
SoundFile falling;
SoundFile jump;
SoundFile land;
SoundFile victory;
SoundFile lost;


int loadingTime = 2000;
int respawn = 1500;
int startTime;
int canvasWidth = 800;
int canvasHeight = 600;
PImage backgroundImage, ground, cave, cave_waddle_doo, yellow_brick, cave_brick, p, waddle_doo, flags;
color buttonColor = color(255, 255, 0);

Player player;
ArrayList<Sprite> platforms;
ArrayList<Enemy> enemies; 
ArrayList<CaveEnemy> cave_enemies;
Sprite livesHead;
Flag flag;

int idel = 0;
int right = 1;
int left = 2;
float maxSpeed = 3;
float gravity = .5;
int level;

final static float SPRITE_SCALE = 3;
final static float SPRITE_SIZE = 50;

boolean map1 = false;
boolean map2 = false;
boolean map3 = false;

float rMargin = 400;
float lMargin = 60;
float vMargin = 40;
float xView = 0;
float yView = 0;
float left_bd, right_bd; 
float top_bd, bottom_bd;



void setup() {
  size(800, 600);
  backgroundImage = loadImage("backgroundImage.jpg");
  hurt = new SoundFile(this, "1C.wav");
   
   button = new SoundFile(this, "menu-select.wav");
   menu = new SoundFile(this, "menu.mp3");
   first = new SoundFile(this, "map1.mp3");;
   second = new SoundFile(this, "map2.mp3");;
   third = new SoundFile(this, "map3.mp3");;
   falling = new SoundFile(this, "fall.mp3");;
   jump = new SoundFile(this, "jump.wav");;
   land = new SoundFile(this, "land.wav");;
   victory = new SoundFile(this, "Victory.mp3");;
   lost = new SoundFile(this, "GameOver.mp3");;
  p = loadImage("rightidel.png");
  flags = loadImage("flag1.png");
  cave = loadImage("cave.png");
  waddle_doo = loadImage("waddle_doo_rwalk_1.png");
  player = new Player(p, 3);
  player.shiftBottom((50*12) - SPRITE_SIZE);
  player.x = 100;
  platforms = new ArrayList<Sprite>();
  enemies = new ArrayList<Enemy>();
  cave_enemies = new ArrayList<CaveEnemy>();
  yellow_brick = loadImage("yellow_brick.png");
  ground = loadImage("ground.png");
  cave_brick = loadImage("cave_block.png");
  cave_waddle_doo = loadImage("waddle_doo_cave_rwalk_1.png");
  livesHead = new Sprite("rightidel.png", 3);
  run1 = false;
  run2 = false;
  run3 = false;
  gameOverBool = false;
  hurtBool = false;
  victoryBool = false;
  menuBool = false;
    
}
void draw() {
  if(!menuBool){
    menuBool = true;
    menu.loop();
  }
    
  if (isMenu) {
    // Draw menu
    image(backgroundImage, 0, 0, canvasWidth, canvasHeight);
    fill(0);
    textAlign(CENTER);
    textSize(50);
    text("Waddle Dee's Adventure", canvasWidth/2, canvasHeight/2 - 100);
    drawButton("Start", canvasWidth/2 , canvasHeight/2);
    drawButton("Controls", canvasWidth/2, canvasHeight/2 + 100);
    drawButton("Quit", canvasWidth/2, canvasHeight/2 + 200);
  } else if (controlMenu){
    // Page that shows controls
    image(backgroundImage, 0, 0, canvasWidth, canvasHeight);
    textAlign(CENTER, CENTER);
    textSize(40);
    fill(0);
    text("Controls", canvasWidth/2, 100); // Title
  
    textSize(30);
    text("D: Right", canvasWidth/2, 200); // Right control
    text("A: Left", canvasWidth/2, 250); // Left control
    text("SPACE: Jump", canvasWidth/2, 300); // Jump control
  
    drawButton("Back", canvasWidth/2, canvasHeight/2 + 200); // Draw back button    
  }
  else if(difficultySelect){
    image(backgroundImage, 0, 0, canvasWidth, canvasHeight);
    fill(0);
    textAlign(CENTER);
    textSize(50);
    text("Difficulty", canvasWidth/2, canvasHeight/2 - 100);
    drawButton("Easy", canvasWidth/2 , canvasHeight/2);
    drawButton("Hard", canvasWidth/2, canvasHeight/2 + 100);
    drawButton("Back", canvasWidth/2, canvasHeight/2 + 200);
  }
  else if(levelSelect){
    image(backgroundImage, 0, 0, canvasWidth, canvasHeight);
    fill(0);
    textAlign(CENTER);
    textSize(50);
    text("Level Select", canvasWidth/2, canvasHeight/2 - 100);
    drawButton("Level 1", canvasWidth/2 , canvasHeight/2);
    drawButton("Level 2", canvasWidth/2, canvasHeight/2 + 100);
    drawButton("Level 3", canvasWidth/2, canvasHeight/2 + 200);
  
  
  }
  else if(!levelSelect && !difficultySelect && !isMenu && !controlMenu){
    //start game
    getLevel();
    if (map1 == true && map2 == false && map3 == false){
      if(!run1){
       createPlatforms("map1.csv");
       run1 = true;
     }
     background(190, 190, 250);
    }
    else if (map2 == true && map1 == false && map3 == false){
      if(!run2){
       platforms.removeAll(platforms);
       enemies.removeAll(enemies);
       createPlatforms("map2.csv");
       run2 = true;
       player.x = 100;
       player.y = 550;
       first.stop();
     }
     background(0);
    }
    else if (map3 == true && map1 == false && map2 == false){
      if(!run3){
       platforms.removeAll(platforms);
       enemies.removeAll(enemies);
       cave_enemies.removeAll(cave_enemies);
       createPlatforms("map3.csv");
       run3 = true;
       player.x = 100;
       player.y = 550;
       second.stop();
     }
     background(190, 190, 250);
    }
    if(gameOver){
      background(0);
      fill(255);
      textAlign(CENTER);
      textSize(32);
      run1 = false;
      map1 = true;
      map2 = false;
      map3 = false;
      run2 = false;
      run3 = false;
      first.stop();
      second.stop();
      third.stop();
      falling.stop();
      if(!gameOverBool){
        lost.play();
        gameOverBool = true;
      }
      text("GAME OVER", width/2, height/2);
      text("Press Space to return to menu", width/2, height/2 + 50);
    }
    else{
      if (isLoading) {
      if (millis() - startTime < loadingTime) {
        background(0);
        livesHead.display();
        livesHead.x = width/2 - 55;
        livesHead.y = height/2 - 18;
        text("Level " + level, width/2, height/2 - 60);
        text(" x " + player.lives, width/2 + 28, height/2);
        } else {
        isLoading = false;
      }
    }
      else if (winState){
      background(0);
      fill(255);
      textAlign(CENTER);
      textSize(32);
      text("CONGRATULATIONS!!!!!!!", width/2, height/2);
      text("Press Space to return to menu", width/2, height/2 + 50);
    
    
    }
    else{
    
    
    scroll();
    updateAll();
    
    textSize(40);
    livesHead.x = xView + 30;
    livesHead.y = yView + 30;
    livesHead.display();
    text(" x " + player.lives, xView + 110, yView + 50);
    }
}
}
}

void getLevel(){
  if (map1 == true && map2 == false && map3 == false){
      level = 1;
    }
    else if (map2 == true && map1 == false && map3 == false){
      level = 2;
    }
    else if (map3 == true && map1 == false && map2 == false){
      level = 3;
    }


}

void updateAll(){
    player.display();
    player.updateAnimation();
    resolveCollisions(player, platforms); 
    flag.display();
    flag.updateAnimation();
    checkFlag();
    for(Sprite s: platforms){
    s.display();
    }
    for(Enemy e: enemies){
      e.update();
      e.display();
      ((AnimatedSprite)e).updateAnimation();
      resolveCollisions(e, platforms);
    }
    for(CaveEnemy c: cave_enemies){
      c.update();
      c.display();
      ((AnimatedSprite)c).updateAnimation();
      resolveCollisions(c, platforms);
    }
    checkDeath();
    checkSound();
}

void checkSound(){
  if (hurt.isPlaying() || falling.isPlaying() || victory.isPlaying()){
    if(map1){
          first.pause();
        }
        else if(map2){
          second.pause();
        }
        else if(map3){
          third.pause();
        }
        
  }
  if (!hurt.isPlaying() && !falling.isPlaying() && hurtBool){
    if(map1){
          first.loop();
          hurtBool = false;
        }
        else if(map2){
          second.loop();
          hurtBool = false;
        }
        else if(map3){
          third.loop();
          hurtBool = false;
        }
      }
  if (!victory.isPlaying() && victoryBool){
    if(map1){
          first.loop();
          victoryBool = false;
        }
        else if(map2){
          second.loop();
          victoryBool = false;
        }
        else if(map3){
          third.loop();
          victoryBool = false;
        }
        
  }


}

void startTimer() {
  if (!isLoading) {
    isLoading = true;
    startTime = millis();
  }
}

void checkDeath(){
  ArrayList<Sprite> eList = checkEnemyCollision(player, enemies);
  ArrayList<Sprite> cList = checkCaveCollision(player, cave_enemies);
  boolean fall = player.getBottom() > 570;
  
  
  if(eList.size() > 0 || fall || cList.size() > 0){
    if(eList.size() > 0 || cList.size() > 0){
      if(first.isPlaying() || second.isPlaying() || third.isPlaying()){
        
      }
      hurt.play();
      hurtBool = true;
      
      }
    
    else if (fall){
      falling.play();
      hurtBool = true;
      
      }
    
    player.lives--;
    if (player.lives == 0){
      gameOver = true;
    }
    else{
      startTimer();
      player.x = 100;
      player.shiftBottom(550);
      if (isLoading) {
      if (millis() - startTime < respawn) {
        background(0);
        livesHead.display();
        livesHead.x = width/2 - 55;
        livesHead.y = height/2 - 18;
        text("Level " + level, width/2, height/2 - 60);
        text(" x " + player.lives, width/2 + 28, height/2);
        } else {
        isLoading = false;
      }
    }
    
    }
  }
}


void checkFlag(){
  boolean flagTouch = checkCollision(player, flag);
  
  if (flagTouch && map1 && !map2 && !map3){
    victoryBool = true;
    victory.play();
    map1 = false;
    map2 = true;
    startTimer();
  }
  else if (flagTouch && !map1 && map2 && !map3){
    victoryBool = true;
    victory.play();
    map3 = true;
    map2 = false;
    startTimer();
  }
  else if (flagTouch && !map1 && !map2 && map3){
    victoryBool = true;
    winState = true;
    victory.play();

  }
  



}

public void keyPressed(){
  if (key == 'd'){
        player.vx = maxSpeed;        
      }
      if (key == 'a'){
        player.vx = -maxSpeed;  
      }
      if (key == ' ' && onPlatform(player, platforms)){
        player.vy = -15;
        jump.play();
      }
      if (gameOver && key == ' '){
         gameOver = false;
         isMenu = true;
         controlMenu = false;
         gameOver = false;
         winState = false;
         isLoading = false;
         run1 = false;
         run2 = false;
         run3 = false;
         setup();
        
        
      }
      if (winState && key == ' '){
         winState = false;
         isMenu = true;
         controlMenu = false;
         gameOver = false;
         winState = false;
         isLoading = false;
         run1 = false;
         run2 = false;
         run3 = false;
         setup();
        
        
      }
}

void keyReleased(){
  if (key == 'd'){
    player.vx = 0;
  }
  if (key == 'a'){
    player.vx = 0;
  }
  if (key == ' '){
    player.vy = 0;
  }

}


public boolean onPlatform(Sprite p, ArrayList<Sprite> objects){
  p.y += 5;
  ArrayList<Sprite> coList = checkCollisionList(p, objects);
  p.y -= 5;
  if(coList.size() > 0){
    return true;
  }
  else{
    return false;
  }


}

void drawButton(String label, float x, float y) {
  strokeWeight(2);
  rectMode(CENTER);
  fill(buttonColor);
  rect(x, y, 200, 50, 10);
  textAlign(CENTER, CENTER);
  textSize(35);
  fill(0);
  text(label, x - 3, y - 5);
  fill(255);
  textSize(35);
  text(label, x - 3, y - 5);
}

void mouseClicked() {
  if (isMenu) {
    if (mouseX > canvasWidth/2 - 100 && mouseX < canvasWidth/2 + 100) {
      if (mouseY > canvasHeight/2 - 25 && mouseY < canvasHeight/2 + 25) {
        isMenu = false;
         difficultySelect = true;
         button.play();
         
        // Start game
      } else if (mouseY > canvasHeight/2 + 75 && mouseY < canvasHeight/2 + 125) {
        controlMenu = true;
        isMenu = false;//show controls
        button.play();
      } else if (mouseY > canvasHeight/2 + 175 && mouseY < canvasHeight/2 + 225) {
        exit();
      }
    }
  } else if(controlMenu == true ){
    if (mouseY > canvasHeight/2 + 175 && mouseY < canvasHeight/2 + 225){
      controlMenu = false;
      isMenu = true;
      button.play();
      
    }
  }
  else if (difficultySelect == true){
    if (mouseX > canvasWidth/2 - 100 && mouseX < canvasWidth/2 + 100) {
      if (mouseY > canvasHeight/2 - 25 && mouseY < canvasHeight/2 + 25) {
        difficulty = 1;
        difficultySelect = false;
        levelSelect = true;
        button.play();
        // Start game
      } else if (mouseY > canvasHeight/2 + 75 && mouseY < canvasHeight/2 + 125) {
        difficulty = 2;
        difficultySelect = false;
        levelSelect = true;
        button.play();
      } else if (mouseY > canvasHeight/2 + 175 && mouseY < canvasHeight/2 + 225) {
        controlMenu = false;
        isMenu = true;
        button.play();
      }
  
  
  }
}
  else if (levelSelect == true){
    if (mouseX > canvasWidth/2 - 100 && mouseX < canvasWidth/2 + 100) {
      if (mouseY > canvasHeight/2 - 25 && mouseY < canvasHeight/2 + 25) {
        map1 = true;
        map2 = false;
        map3 = false;
        levelSelect = false;
        startTimer();
        button.play();
        menu.stop();
        first.loop();

        // Start game
      } else if (mouseY > canvasHeight/2 + 75 && mouseY < canvasHeight/2 + 125) {
        map1 = false;
        map2 = true;
        map3 = false;
        levelSelect = false;
        startTimer();
        button.play();
        menu.stop();
        second.loop();


      } else if (mouseY > canvasHeight/2 + 175 && mouseY < canvasHeight/2 + 225) {
        map1 = false;
        map2 = false;
        map3 = true;
        levelSelect = false;
        startTimer();
        button.play();
        menu.stop();
        third.loop();

      }
  
  
  }
}
}

void createPlatforms(String filename){
  String[] lines = loadStrings(filename);
  for(int row = 0; row < lines.length; row++){
    String[] values = split(lines[row], ",");
    for(int col = 0; col < values.length; col++){
      if(values[col].equals("1")){
        Sprite s = new Sprite("ground.png", 1);
        s.x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.y = SPRITE_SIZE/2 + row * SPRITE_SIZE ;
        platforms.add(s);
      }
      else if(values[col].equals("2")){
        Sprite s = new Sprite("yellow_brick.png", SPRITE_SCALE);
        s.x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.y = (SPRITE_SIZE/2 + row * SPRITE_SIZE) + 3;
        platforms.add(s);
      }
      else if (values[col].equals("3")){
        float bLeft = col * SPRITE_SIZE;
        float bRight = bLeft + 4 * SPRITE_SIZE;
        Enemy e = new Enemy(waddle_doo, 3, bLeft, bRight);
        e.x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        e.y = SPRITE_SIZE/2 + row * SPRITE_SIZE + 5;
        enemies.add(e);
      }
      else if (values[col].equals("4")){
        flag = new Flag(flags, 3);
        flag.x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        flag.y = SPRITE_SIZE/2 + row * SPRITE_SIZE + 5;
      }
      else if(values[col].equals("5")){
        Sprite s = new Sprite(cave, 1);
        s.x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.y = SPRITE_SIZE/2 + row * SPRITE_SIZE ;
        platforms.add(s);
      }
      else if(values[col].equals("6")){
        Sprite s = new Sprite(cave_brick, SPRITE_SCALE);
        s.x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.y = (SPRITE_SIZE/2 + row * SPRITE_SIZE) + 3;
        platforms.add(s);
      }
      else if (values[col].equals("7")){
        float bLeft = col * SPRITE_SIZE;
        float bRight = bLeft + 4 * SPRITE_SIZE;
        CaveEnemy c = new CaveEnemy(cave_waddle_doo, 3, bLeft, bRight);
        c.x = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        c.y = SPRITE_SIZE/2 + row * SPRITE_SIZE + 5;
        cave_enemies.add(c);
      }
      
    }
  }
}

boolean checkCollision(Sprite s1, Sprite s2){
  boolean noX = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight();
  boolean noY = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();;
  
  if(noX || noY){
    return false;
  }
  else{
  return true;
}
}

public ArrayList<Sprite> checkCollisionList(Sprite s, ArrayList<Sprite> list){
  ArrayList<Sprite> collision = new ArrayList<Sprite>();
  for(Sprite player: list){
    if(checkCollision(s, player)){
      collision.add(player);
    }
  }
  return collision;
}
public ArrayList<Sprite> checkEnemyCollision(Sprite s, ArrayList<Enemy> list){
  ArrayList<Sprite> collision = new ArrayList<Sprite>();
  for(Sprite player: list){
    if(checkCollision(s, player)){
      collision.add(player);
    }
  }
  return collision;
}
public ArrayList<Sprite> checkCaveCollision(Sprite s, ArrayList<CaveEnemy> list){
  ArrayList<Sprite> collision = new ArrayList<Sprite>();
  for(Sprite player: list){
    if(checkCollision(s, player)){
      collision.add(player);
    }
  }
  return collision;
}


public void resolveCollisions(Sprite p, ArrayList<Sprite> objects){
    p.vy += gravity;
    p.y += p.vy;
     
    ArrayList<Sprite> coList = checkCollisionList(p, objects);
    
    if(coList.size() > 0){
      Sprite collided = coList.get(0);
      if(p.vy > 0){
        p.shiftBottom(collided.getTop());
      }
      else if (p.vy < 0){
        p.shiftTop(collided.getBottom());
      }
      p.vy = 0;
    
    }
    
    p.x += p.vx;
    coList = checkCollisionList(p, objects);
    
    if(coList.size() > 0){
      Sprite collided = coList.get(0);
      if(p.vx > 0){
        p.shiftRight(collided.getLeft());
      }
      else if (p.vx < 0){
        p.shiftLeft(collided.getRight());
      }
    
    }
    

}

void scroll(){
  float rBoundary = xView + width - rMargin;
  if(player.getRight() > rBoundary){
    xView += player.getRight() - rBoundary;
  }
  float lBoundary = xView + lMargin;
  if(player.getLeft() < lBoundary){
    xView -= lBoundary - player.getLeft();
  }
  float bBoundary = yView + height - vMargin;
  if(player.getBottom() > bBoundary){
    yView += player.getBottom() - bBoundary;
  }
  float tBoundary = yView + vMargin;
  if(player.getTop() < tBoundary){
    yView -= tBoundary - player.getTop();
  }
  translate(-xView, -yView);

}
