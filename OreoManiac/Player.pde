class Player
{
  PImage[] mainSprite; //  Main character images
  int health, damage, speed;
  int currentFrame, loopFrames, totalFrames, offset;
  int x, y, w, h, top, bottom, left, right, dim, delay;
  int vx, vy;
  int jumpHeight, apexY; 
  float fireX, fireY, fireDir;
  boolean moveLeft, moveRight, jumping, falling, takeDamage;
  
  Player(int _x, int _y, int _w, int _h, int _vx, int _vy, int _health, int _damage)
  {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    vx = _vx;
    vy = _vy;
    dim = 52;
    health = _health;
    damage = _damage;
    currentFrame = 0;
    loopFrames = 6;
    offset = 0;
    moveLeft = false;
    moveRight = false;
    jumping = false;
    falling = false; 
    jumpHeight = 250;
    apexY =  y - jumpHeight;
    delay = 0;
    //  Collision box update
    top = y - h/2;
    bottom = y + h/2;
    left = x - w/2;
    right = x + w/2;
    load(); //  Load all images for main character
  }
  
  void display()
  {
    imageMode(CENTER);
    image(mainSprite[currentFrame + offset], x, y, 100, 100);
  }
  
  void move()
  {
    if (moveLeft && !moveRight)
    {
      offset = 2; 
      x-= vx;  
    }
    if (moveRight && !moveLeft)
    {
      offset = 8;
      x+= vx;
    }
    if (!moveLeft && !moveRight && !jumping && !falling)
    {
      offset = 0;
      currentFrame = 1;
    }
    else if (!moveLeft && !moveRight && jumping && !falling)
    {
      offset = 0;
      currentFrame = 1;
    }
    else if (!moveLeft && !moveRight && !jumping && falling)
    {
      offset = 0;
      currentFrame = 1;
    }
    else
    {
      if (delay == 0)
      {
        currentFrame = (currentFrame+1)%loopFrames;
      }
      delay = (delay+1)%10;
    }
    //  Collision box update
    top = y - h/2;
    bottom = y + h/2;
    left = x - w/2;
    right = x + w/2;
}

  
  void jump()
  {
    if (jumping == true)
    {
      y-= vy;
    }
    if (falling == true)
    {
      y+= vy;
    }
  }
  
  void apex()
  {
    if (y <= apexY)
    {
      jumping = false;
      falling = true; 
    }
  }
  
  void land()
  {
    if (y >= height - (h/2))
    {
      falling = false;
      y = height - (h/2); //  Grid snap
    }
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
  
  void printHealth()
  {
    textSize(25);
    text("Health: " + health, 80, 100);
  }
  
  //  Is a player on an interactive platform?
  void interact(ArrayList<Interact> platforms)
  {
    //  No jumping nor any interaction with ground level surface
    if (y < height - h/2 && jumping == false)
    {
      boolean on = false;
      for (Interact platform : platforms)
      {
        if (top <= platform.bottom && bottom >= platform.top && left <= platform.right && right >= platform.left)
        {
          on = true;
        }
      }
      if (on == false)
      {
        falling = true;
      }
    }
  }
  void load()
  {
  //  Main character images
  mainSprite = new PImage[18]; //  18 images; Left to right; standing, run left, run right, shoot left, shoot right
  //  Load main character images
    for (int i = 0; i < 18; i++)
    {
      mainSprite[i] = loadImage("data/mainSprite" + (i+1) + ".png");
      println("Image: " + (i+1) + " has been loaded.");
    }
  }
}
