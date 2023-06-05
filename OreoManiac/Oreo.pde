//Shane Barrera

//main: run from here
Player p1;
Enemy e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12, e13, e14, e15, e16, e17, e18, boss;
Constraints c;
Bullet b;
Interact platform1, platform2, platform3; 

//  Lists 
ArrayList <Bullet> bullets;
ArrayList <Bullet> enemyBullets;
ArrayList <Enemy> enemiesOne;
ArrayList <Enemy> enemiesTwo;
ArrayList <Interact> platforms;

//  Sequencing
boolean mainMenu, optionMenu, inGame, begin, scene1, scene2, scene3, complete, end;
boolean dead, bossDeath, gameComplete, hard, delay; 
boolean om1, om2, om3, playSongOne, playSongTwo, playOreoChant;
int timer, second;

//  Import video and sound libraries
import processing.video.*;
import processing.sound.*;
//  Declare all video and sound files
Movie oreoManiac1, oreoManiac2, oreoManiac3;
SoundFile talk1, talk2, talk3, talk4, oreoChant;
SoundFile boss1, boss2, boss3; 
SoundFile pistol1, pistol2, pistol3, miniGun, hit;
SoundFile jump, land, stageComplete, click, death;
SoundFile stageSong1, stageSong2, stageSong3, radioSong;

void setup()
{
  //  Game interface
  size(1080, 540);
  frameRate(120);
  conditions(); //  Initialize all game conditions
  initialize(); //  Initalize all video and audio 
  startGame();
  stageSong1.amp(0.5);
  songPlay(stageSong1, playSongOne);
}

void draw()
{
  //println("Mouse X: " + mouseX);
  //println("Mouse Y: " + mouseY);
  if (mainMenu && !inGame && !optionMenu)
  {
    c.displayMenu();
    //  Start the game 
    if (mousePressed && (mouseX >= 272 && mouseX <= 445) && (mouseY >= 365 && mouseY <= 444) && mainMenu) 
    {
      click.amp(1.0);
      click.play();
      mainMenu = false;
      inGame = true;
      optionMenu = false;
      c.displayControls();
    }
    //  Exit the game
    if (mousePressed && (mouseX >= 635 && mouseX <= 752) && (mouseY >= 367 && mouseY <= 444) && mainMenu)
    {
      click.amp(1.5);
      click.play();
      c.displayExit();
      delay(360);
      exit();
    }
    //  Settings menu
    if (mousePressed && (mouseX >= 845 && mouseX <= 930) && (mouseY >= 364 && mouseY <= 450) && mainMenu)
    {
      click.amp(1.5);
      click.play();
      c.displaySettings();
      mainMenu = false; 
      optionMenu = true;
    }
  }
  
  if (!mainMenu && !inGame && optionMenu)
  {
    // Easy mode in settings menu
    if (mousePressed && (mouseX >= 553 && mouseX <= 676) && (mouseY >= 123 && mouseY <= 168) && optionMenu)
    {
      c.displayEasy();
      p1.health = 25;
      hard = false;
    }
    //  Hard mode in settings menu
    if (mousePressed && (mouseX >= 787 && mouseX <= 905) && (mouseY >= 114 && mouseY <= 162) && optionMenu && !begin)
    {
      c.displayHard();
      hard = true;
      p1.health = 10; //  Lower player health to '5' as opposed to '10' 
    }
    //  Exit settings menu 
    if (mousePressed && (mouseX >= 198 && mouseX <= 301) && (mouseY >= 413 && mouseY <= 474) && optionMenu && !begin)
    {
      click.amp(0.8);
      click.play();
      optionMenu = false; 
      mainMenu = true; 
    }
  }
  
  //  Begin menu; prompt user to press 'OK' to start the game
  if (!mainMenu && inGame && !optionMenu && !scene1)
  {
    if (mousePressed && (mouseX >= 764 && mouseX <= 827) && (mouseY >= 329 && mouseY <= 399) && inGame)
    {
      click.amp(1.5);
      click.play();
      begin = true;
      scene1 = true;
    }
  }

  //  Game begins : Scene 1
  if (!mainMenu && inGame && !optionMenu && begin && scene1 && !scene2 && !scene3)
  {
    c.scene1();
    playStage(); 
  }
  //  Game continues : Scene 2
  if (!mainMenu && inGame && !optionMenu && begin && !scene1 && scene2 && !scene3)
  {
    c.scene2();
    playStage();
  }
  //  Game continues : Scene 3
  if (!mainMenu && inGame && !optionMenu && begin && !scene1 && !scene2 && scene3)
  {
    stageSong1.stop();
    stageSong3.amp(1);
    songPlay(stageSong3, playSongTwo);
    playSongTwo = true;
    if (frameCount % 240 == 0)
    {
      songPlay(oreoChant, playOreoChant);
      playOreoChant = true;
    }
    c.scene3();
    playStage();
  }
  //  Game continues : theater
  if (!mainMenu && inGame && !optionMenu && begin && !scene1 && !scene2 && !scene3)
  {
    end = true;
    stageSong3.stop();
    c.theater();
    playStage();
    platform3.theater(p1);
    c.blank();
    
    if (end && (om1 || om2 || om3))
    {
      if (om1)
      {
        imageMode(CENTER);
        oreoManiac1.volume(0.4);
        oreoManiac1.play();
        image(oreoManiac1, 530, 150, 659, 262);
        if (key == '4' && end)
        {
          om1 = false;
          om2 = false;
          om3 = false;
          oreoManiac1.stop();
        }
      }
      if (om2)
      {
        oreoManiac2.volume(0.5);
        oreoManiac2.play();
        image(oreoManiac2, 530, 150, 659, 262);
        if (key == '4' && end)
        {
          om1 = false;
          om2 = false;
          om3 = false;
          oreoManiac2.stop();
        }
      }
      if (om3)
      {
        oreoManiac3.volume(0.7);
        oreoManiac3.play();
        image(oreoManiac3, 530, 150, 659, 262);
        if (key == '4' && end)
        {
          om1 = false;
          om2 = false;
          om3 = false;
          oreoManiac3.stop();
        }
      }
      if (!om1 && !om2 && !om3)
      {
        c.blank();
      }
    }
  }
  //println("Complete? " + complete);
  //println("Enemy shoot: " + delay);
}


void keyPressed()
{
  if (key == 'a')
  {
    p1.moveLeft = true;
  }
  if (key == 'd')
  {
    p1.moveRight = true;
  }
  if (key == '1' && end)
  {
    om1 = true;
    om2 = false;
    om3 = false;
  }
  if (key == '2' && end)
  {
    om1 = false;
    om2 = true;
    om3 = false;
  }
  if (key == '3' && end)
  {
    om1 = false;
    om2 = false;
    om3 = true;
  }
  if (key == 'b' && end)
  {
    delay(120);
    startGame();
    conditions();
    stageSong1.play();
  }
}

void keyReleased()
{
  if (key == 'a')
  {
    p1.moveLeft = false;
  }
  if (key == 'd')
  {
    p1.moveRight = false;
  }
  if (key == 'w' && p1.jumping == false && p1.falling == false && begin)
  {
    jump.amp(0.8);
    jump.play();
    p1.jumping = true;
    p1.apexY =  p1.y - p1.jumpHeight; //  Redefine highest apex per jump
  }
  if (key == ' ' && begin)
  {
    pistol1.play();
    bullets.add(new Bullet(p1.x, p1.y)); 
  }
  if (key == 'e' && begin)
  {
    talk1.play();
  }
}

void conditions()
{
  mainMenu = true;
  inGame = false; 
  optionMenu = false;
  begin = false;
  scene1 = false;
  scene2 = false;
  scene3 = false;
  complete = false;
  end = false;
  bossDeath = false;
  gameComplete = false;
  hard = false;
  delay = false;
  dead = false;
  playSongOne = false;
  playSongTwo = false;
  playOreoChant = false;
  second = second();
}

void initialize()
{
  //  Initalize all video and audio
  talk1 = new SoundFile(this, "data/talk1.wav");
  stageSong1 = new SoundFile(this, "data/stageSong2.wav"); 
  stageSong3 = new SoundFile(this, "data/stageSong3.wav"); 
  pistol1 = new SoundFile(this, "data/pistol1.wav");
  pistol2 = new SoundFile(this, "data/pistol2.wav");
  pistol3 = new SoundFile(this, "data/pistol3.wav");
  jump = new SoundFile(this, "data/jump.wav"); 
  hit = new SoundFile(this, "data/hit.wav"); 
  stageComplete = new SoundFile(this, "data/complete.wav");
  click = new SoundFile(this, "data/click.wav");
  death = new SoundFile(this, "data/dead.wav");
  oreoChant = new SoundFile(this, "data/oreoChant.wav");
  oreoManiac1 = new Movie(this, "om1.mp4");
  oreoManiac2 = new Movie(this, "om2.wmv");
  oreoManiac3 = new Movie(this, "om3.mp4");
  
}

void playStage()
{
  p1.display();
  p1.move(); 
  p1.jump();
  p1.apex();
  p1.land();
  p1.interact(platforms);
  p1.printHealth();
  
  //  Scene 1 Enemies
  if (scene1 && !scene2 && !scene3)
  {
    //  Collision interaction
    for (Interact platform : platforms)
    {
      platform.collide(p1);
    }
    for (Enemy e : enemiesOne)
    {
      e.display();
    }
  }
  
  //  Scene 2 Enemies
  if (!scene1 && scene2 && !scene3)
  {
    for (Enemy e : enemiesTwo)
    {
      e.display();
    }
  }
  
  //  Scene 3 Enemies
  if (!scene1 && !scene2 && scene3)
  {
    boss.display();
  }
  
  //  Screen boundaries
  for (Interact platform : platforms)
  {
    platform.screen(p1, complete);
  }
    
  // Shooting for all scenes
  if (begin)
  {
    //  Player bullet implementation for all scenes
    for (Bullet b : bullets)
    {
      b.display();
      b.shoot();
      b.check();
      
      //  Scene 1 enemies
      if (scene1 && !scene2 && !scene3)
      {
        for (Enemy e : enemiesOne) //  Every enemy in comparison to every bullet
        {
          b.collide(e); //  Enemy collision box
          e.lowerHealth();
        }
        //  Remove collision enemies that have been eliminated
        for (int i = enemiesOne.size() - 1; i >= 0; i--)
        {
          Enemy e = enemiesOne.get(i);
          if (e.remove == true)
          {
            hit.amp(0.7);
            hit.play();
            enemiesOne.remove(e);
          }
        }
      }
      //  Scene 2 enemies
      else if (!scene1 && scene2 && !scene3)
      {
        for (Enemy e : enemiesTwo) //  Every enemy in comparison to every bullet
        {
          b.collide(e); //  Enemy collision box
        }
        //  Remove collision enemies that have been eliminated
        for (int i = enemiesTwo.size() - 1; i >= 0; i--)
        {
          Enemy e = enemiesTwo.get(i);
          if (e.remove == true)
          {
            hit.amp(0.5);
            hit.play();
            enemiesTwo.remove(e);
          }
        }
      }
      //  Scene 3 enemies
      else if (!scene1 && !scene2 && scene3)
      {
        b.collide(boss);
        boss.lowerBossHealth();
        //println("BOSS HEALTH: " + boss.bossHealth);
        if (boss.remove == true && boss.bossHealth == 0)
        {
          hit.amp(0.5);
          hit.play();
        }
      }
    }
    
    //  Enemy bullet implementation for all scenes
    if (scene1 && !complete)
    {
      if (frameCount % 185 == 0 && e2.remove == false)
      {
        pistol3.play();
        enemyBullets.add(new Bullet(e2.x - 46, e2.y - 10));
      }
      if (frameCount % 155 == 0 && e3.remove == false)
      {
        pistol3.play();
        enemyBullets.add(new Bullet(e3.x - 46, e3.y - 10));
      }
      if (frameCount % 200 == 0 && e1.remove == false)
      {
        pistol2.amp(0.7);
        pistol2.play();
        enemyBullets.add(new Bullet(e1.x - 46, e1.y - 10));
      }
      if (frameCount % 250 == 0 && e4.remove == false)
      {
        pistol3.play();
        enemyBullets.add(new Bullet(e4.x - 46, e4.y - 10));
      }
      if (frameCount % 350 == 0 && e5.remove == false)
      {
        pistol3.play();
        enemyBullets.add(new Bullet(e5.x - 46, e5.y - 10));
      }
    }
    else if (scene2 && !complete)
    {
      if (frameCount % 40 == 0 && e6.remove == false)
      {
        pistol3.play();
        enemyBullets.add(new Bullet(e6.x - 46, e6.y - 10));
      }
      if (frameCount % 120 == 0 && e7.remove == false)
      {
        pistol3.play();
        enemyBullets.add(new Bullet(e7.x - 46, e7.y - 10));
      }
      if (frameCount % 250 == 0 && e8.remove == false)
      {
        pistol3.play();
        enemyBullets.add(new Bullet(e8.x - 46, e8.y - 10));
      }
      if (frameCount % 500 == 0 && e9.remove == false)
      {
        pistol3.play();
        enemyBullets.add(new Bullet(e9.x - 46, e9.y - 10));
      }
      if (frameCount % 300 == 0 && e10.remove == false)
      {
        pistol3.play();
        enemyBullets.add(new Bullet(e10.x - 46, e10.y - 10));
      }
      if (frameCount % 400 == 0 && e11.remove == false)
      {
        pistol2.amp(0.7);
        pistol2.play();
        enemyBullets.add(new Bullet(e11.x - 46, e11.y - 10));
      }
      if (frameCount % 500 == 0 && e12.remove == false)
      {
        pistol3.play();
        enemyBullets.add(new Bullet(e12.x - 46, e12.y - 10));
      }
      if (frameCount % 540 == 0 && e13.remove == false)
      {
        pistol2.amp(0.7);
        pistol2.play();
        enemyBullets.add(new Bullet(e13.x - 46, e13.y - 10));
      }
      if (frameCount % 600 == 0 && e14.remove == false)
      {
        pistol3.play();
        enemyBullets.add(new Bullet(e14.x - 46, e14.y - 10));
      }
      if (frameCount % 700 == 0 && e15.remove == false)
      {
        pistol3.play();
        enemyBullets.add(new Bullet(e15.x - 46, e15.y - 10));
      }
      if (frameCount % 300 == 0 && e16.remove == false)
      {
        pistol3.play();
        enemyBullets.add(new Bullet(e16.x - 46, e16.y - 10));
      }
      if (frameCount % 450 == 0 && e17.remove == false)
      {
        pistol3.play();
        enemyBullets.add(new Bullet(e17.x - 46, e17.y - 10));
      }
      if (frameCount % 1000 == 0 && e18.remove == false)
      {
        pistol2.amp(0.7);
        pistol2.play();
        enemyBullets.add(new Bullet(e18.x - 46, e18.y - 10));
      }
    }
    else if (scene3)
    {
      if (frameCount % 15 == 0 && scene3)
      {
          pistol3.play();
          enemyBullets.add(new Bullet(boss.x - 85, boss.y+3));
      }
    }
    
    for (Bullet b : enemyBullets)
    {
      b.display();
      b.enemyShoot1();
      b.check();
      b.damage(p1);
      p1.lowerHealth();
      b.removeBullets(end);
      if (p1.health == 0)
      {
        stageSong1.stop();
        stageSong3.stop();
        death.play();
        delay(120);
        startGame();
        conditions();
        stageSong1.play();
      }
    }
    //println("Enemy bullet count: " + enemyBullets.size());
  }
   
   
  //  Remove any player bullets beyond boundaries to preserve memory
  for (int i = bullets.size() - 1; i >= 0; i--)
  {
    Bullet b = bullets.get(i);
    if (b.remove == true)
    {
      bullets.remove(b);
    }
  }
  
  //  Remove any enemy bullets beyond boundaries to preserve memory
  for (int i = enemyBullets.size() - 1; i >= 0; i--)
  {
    Bullet b = enemyBullets.get(i);
    if (b.remove == true)
    {
      enemyBullets.remove(b);
    }
  }
  //println("Enemy count one: " + enemiesOne.size());
  //println("Enemy count two: " + enemiesTwo.size());
  
  if (enemiesOne.size() == 0 && enemiesTwo.size() != 0 && scene1)
  {
    textSize(25);
    text("Stage complete.", 700, 100);
    text("Move forward.", 700, 130);
    complete = true;
  }
  else if (enemiesOne.size() == 0 && enemiesTwo.size() == 0 && scene2)
  {
    textSize(25);
    text("Stage complete.", 700, 100);
    text("Move forward.", 700, 130);
    complete = true;
  }
  else if (enemiesOne.size() == 0 && enemiesTwo.size() == 0)
  {
    //  Plot twist, user's can simply run past the boss!
    complete = true;
  }
  
  //  Sequence of stages based on completion (all enemies killed) 
  if (complete)
  {
    if (scene1 && !scene2 && !scene3 && p1.x >= 1080)
    {
      stageComplete.amp(0.5);
      stageComplete.playFor(3);
      complete = false;
      scene1 = false;
      scene2 = true;
      scene3 = false;
    }
    else if (!scene1 && scene2 && !scene3 && p1.x >= 1080)
    {
      stageComplete.amp(0.5);
      stageComplete.playFor(3);
      complete = false;
      scene1 = false;
      scene2 = false;
      scene3 = true;
    }
    else if (!scene1 && !scene2 && scene3 && p1.x >= 1080)
    {
      stageComplete.amp(0.5);
      stageComplete.playFor(3);
      complete = false;
      scene1 = false;
      scene2 = false;
      scene3 = false;
    }
    else if (!scene1 && !scene2 && !scene3 && p1.x >= 1080)
    {
      complete = false;
      scene1 = false;
      scene2 = false;
      scene3 = false;
    }
  }
}

void startGame()
{
  //Player(int _x, int _y, int _w, int _h, int _vx, int _vy, int _health, int _damage)
  p1 = new Player(100, height - 26, 100, 100, 3, 3, 25, 1); //'26' is half of our character pixel size (46x52)
  //Enemy(int _x, int _y, int _w, int _h, int _vx, int _vy, int _health, int _damage, String _currentEnemy)
  e1 = new Enemy(width - 300, height - 52, 100, 100, 3, 3, 5, 5, "data/altEnemyShootLeftSprite1.png");
  e2 = new Enemy(width - 300, height - 265, 100, 100, 3, 3, 5, 5, "data/altEnemyShootLeftSprite1.png");
  e3 = new Enemy(width - 200, height - 265, 100, 100, 3, 3, 5, 5, "data/altEnemyShootLeftSprite1.png");
  e4 = new Enemy(width - 100, height - 52, 100, 100, 3, 3, 5, 5, "data/altEnemyShootLeftSprite1.png");
  e5 = new Enemy(width - 400, height - 52, 100, 100, 3, 3, 5, 5, "data/altEnemyShootLeftSprite1.png");
  e6 = new Enemy(width - 800, height - 52, 100, 100, 3, 3, 5, 5, "data/enemyShootLeftSprite1.png");
  e7 = new Enemy(width - 600, height - 52, 100, 100, 3, 3, 5, 5, "data/altEnemyShootLeftSprite1.png");
  e8 = new Enemy(width - 700, height - 52, 100, 100, 3, 3, 5, 5, "data/enemyShootLeftSprite1.png");
  e9 = new Enemy(width - 500, height - 52, 100, 100, 3, 3, 5, 5, "data/altEnemyShootLeftSprite1.png");
  e10 = new Enemy(width - 850, height - 52, 100, 100, 3, 3, 5, 5, "data/enemyShootLeftSprite1.png");
  e11 = new Enemy(width - 750, height - 52, 100, 100, 3, 3, 5, 5, "data/altEnemyShootLeftSprite1.png");
  e12 = new Enemy(width - 550, height - 52, 100, 100, 3, 3, 5, 5, "data/altEnemyShootLeftSprite1.png");
  e13 = new Enemy(width - 100, height - 52, 100, 100, 3, 3, 5, 5, "data/enemyShootLeftSprite1.png");
  e14 = new Enemy(width - 200, height - 52, 100, 100, 3, 3, 5, 5, "data/enemyShootLeftSprite1.png");
  e15 = new Enemy(width - 250, height - 52, 100, 100, 3, 3, 5, 5, "data/altEnemyShootLeftSprite1.png");
  e16 = new Enemy(width - 300, height - 52, 100, 100, 3, 3, 5, 5, "data/altEnemyShootLeftSprite1.png");
  e17 = new Enemy(width - 350, height - 52, 100, 100, 3, 3, 5, 5, "data/enemyShootLeftSprite1.png");
  e18 = new Enemy(width - 50, height - 52, 100, 100, 3, 3, 5, 5, "data/altEnemyShootLeftSprite1.png");
  
  boss = new Enemy(width - 400, height - 100, 200, 200, 3, 3, 5, 5, "data/boss.png");
  //Constraints()
  c = new Constraints();
  //Bullet(int _x, int _y)
  b = new Bullet(0,0);
  //Interact(int _x, int _y, int _w, int _h)
  platform1 = new Interact(293, 346, 120, 1);
  platform2 = new Interact(830, 330, 145, 1);
  platform3 = new Interact(540, 300, 1080, 1);
  
  bullets = new ArrayList <Bullet>(); //  Constructor 
  enemyBullets = new ArrayList <Bullet>(); //  Constructor 
  enemiesOne = new ArrayList <Enemy>(); //  Constructor 
  enemiesTwo = new ArrayList <Enemy>(); //  Constructor 
  platforms = new ArrayList<Interact>(); //  Constructor
 
  enemiesOne.add(e1); // Scene 1
  enemiesOne.add(e2);
  enemiesOne.add(e3);
  enemiesOne.add(e4);
  enemiesOne.add(e5);
  platforms.add(platform1);
  platforms.add(platform2);
  
  enemiesTwo.add(e6); // Scene 2
  enemiesTwo.add(e7);
  enemiesTwo.add(e8);
  enemiesTwo.add(e9);
  enemiesTwo.add(e10);
  enemiesTwo.add(e11);
  enemiesTwo.add(e12);
  enemiesTwo.add(e13);
  enemiesTwo.add(e14);
  enemiesTwo.add(e15);
  enemiesTwo.add(e16);
  enemiesTwo.add(e17);
  enemiesTwo.add(e18);
}

void movieEvent(Movie video)
{
  video.read();
}

void songPlay(SoundFile song, boolean playOnce)
{
  if (playOnce == false)
  {
    println("Song played!");
    song.play();
  }
  playOnce = true;
}
