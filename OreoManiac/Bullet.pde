class Bullet
{
  PImage bullet;
  int x, y, vx, dim, count, time;
  float hue;
  boolean remove, shootRight, shootLeft;
  int top, bottom, left, right;
  
  Bullet(int _x, int _y)
  {
    bullet = loadImage("data/bullet.png");
    imageMode(CENTER);
    time = millis();
    x = _x;
    y = _y;
    vx = 5;
    dim = 46;
    count = 10;
    remove = false; 
     //  Collision box
    top = y - dim/2;
    bottom = y + dim/2;
    left = x - dim/2;
    right = x + dim/2;
  }
    
  void display()
  {
    image(bullet, x, y, 100, 100);
  }
  
  void shoot()
  {
    x+= vx; 
    //  Collision box update, since bullet moves
    top = y - dim/2;
    bottom = y + dim/2;
    left = x - dim/2;
    right = x + dim/2;
  }
  
  void enemyShoot1()
  {
    x-= vx;
    enemyCollision();
  }
  
  void enemyShoot2()
  {
    x-= 0.5*vx;
    enemyCollision();
  }
  
  void check()
  {
    if (x < 0 || x > width)
    {
      remove = true;
    }
  }
  
  //  Enemy collision box removal
  void collide(Enemy currentEnemy)
  {
    if (top <= currentEnemy.bottom && bottom >= currentEnemy.top && left <= currentEnemy.right && right >= currentEnemy.left)
    {
      //println("Hit!");
      currentEnemy.remove = true; //  Remove enemy if collision occurs
      remove = true; //  Remove bullet from list after the collision
    }
  }
  
  //  Remove boss bullets at end of the game
  void removeBullets(boolean end)
  {
    if (end)
    {
      remove = true; //  Remove bullet from list after the collision
      stageSong3.stop();
    }
  }
  
  //  Main player collision box damage
  void damage(Player p1)
  {
    if (top <= p1.bottom && bottom >= p1.top && left <= p1.right && right >= p1.left)
    {
      //println("OUCH!");
      p1.takeDamage = true;
      remove = true; //  Remove bullet from list after the collision
    }
  }
  
  //  Main player collision box damage
  void bossDamage(Player b)
  {
    if (top <= b.bottom && bottom >= b.top && left <= b.right && right >= b.left)
    {
      //println("OUCH!");
      boss.takeDamage = true;
      remove = true; //  Remove bullet from list after the collision
    }
  }
  
  void count()
  {
    println(count);
  }
  
  void enemyCollision()
  {
    //  Collision box
    top = y - dim/2;
    bottom = y + dim/2;
    left = x - dim/2;
    right = x + dim/2;
  }
}
