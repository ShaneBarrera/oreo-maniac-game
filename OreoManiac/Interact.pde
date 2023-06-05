class Interact
{
  int x, y, w, h;
  int top, bottom, left, right; //  Collision obstacles
  int xi, xf; //  Screen boundaries
  boolean complete; //  Stage complete
  
  Interact(int _x, int _y, int _w, int _h)
  {
    xi = 0;
    xf = width;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
  }
  
  void collide(Player p1)
  {
    if (left < p1.right && right > p1.left && top < p1.bottom && bottom > p1.top)
    {
      p1.falling = false; 
      p1.y = y - h/2 - p1.h/2;
      //println("COLLIDE!");
    }
  }
  
  void screen(Player p1, boolean complete)
  {
    if (p1.x >= 1080 && complete == false)
    {
      p1.x = 0;
    }
    else if (p1.x <= 0 && complete == false)
    {
      p1.x = 0;
    }
  }
  
  void theater(Player p1)
  {
    if (p1.y >= 300)
    {
      p1.y = 300;
    }
    if (p1.x >= 900)
    {
      p1.x = 900;
    }
    if (p1.x <= 150)
    {
      p1.x = 150;
    }
  }
  
  
}
