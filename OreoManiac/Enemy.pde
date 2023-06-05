class Enemy
{
  PImage e;
  int health, damage, speed, bossHealth;
  int x, y, w, h, top, bottom, left, right, dim;
  int vx, vy;
  float fireX, fireY, fireDir;
  boolean remove, takeDamage;
  String currentEnemy;
  
  Enemy(int _x, int _y, int _w, int _h, int _vx, int _vy, int _health, int _damage, String _currentEnemy)
  {
    imageMode(CENTER);
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    vx = _vx;
    vy = _vy;
    dim = 52;
    health = _health;
    damage = _damage;
    remove  = false;
    takeDamage = false;
    currentEnemy = _currentEnemy;
    load();
    //  Collision box
    top = y - dim/2;
    bottom = y + dim/2;
    left = x - dim/2;
    right = x + dim/2;
    bossHealth = 100;
  }
  
  void load()
  {
    e = loadImage(currentEnemy);
  }
  
  void display()
  {
    image(e, x, y, w, h);
  } 
  
  void lowerHealth()
  {
    if (takeDamage == true)
    {
      //println("Player health: " + health);
      health = health - 1;
      takeDamage = false;
    }
  }
  
  void lowerBossHealth()
  {
    if (takeDamage == true)
    {
      //println("Player health: " + health);
      bossHealth = bossHealth - 1;
      takeDamage = false;
    }
  }
  
  void printBossHealth()
  {
    textSize(25);
    text("Health: " + bossHealth, 80, 100);
  }
}
