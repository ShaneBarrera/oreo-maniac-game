class Constraints
{
  PImage background, settings, settingsMenu, controlsMenu;
  PImage easy, hard, oreo, oreoMilkshake;
  PImage scene1, scene2, scene3, theater;
  Constraints()
  {
    imageMode(CENTER);
    background = loadImage("data/menu.jpg");
    settings = loadImage("data/settings.png");
    oreo = loadImage("data/oreo.png");
    oreoMilkshake = loadImage("data/oreoMilkshake.png");
    settingsMenu = loadImage("data/settingsMenu.png");
    easy = loadImage("data/easy.png");
    hard = loadImage("data/hard.png");
    controlsMenu = loadImage("data/controlsMenu.png");
    scene1 = loadImage("data/scene1.png");
    scene2 = loadImage("data/scene2.png");
    scene3 = loadImage("data/scene3.png");
    theater = loadImage("data/theater.png");
  }
  
  void displayMenu()
  {
    background(background);
    image(settings, width/2 + 350, height/2 + 140, 100, 100);
  }
  
  void displayExit()
  {
    background(0);
    fill(255);
    textSize(75);
    textMode(CENTER);
    text("Thanks for playing!", 250, height/2 - 100);
    image(oreo, width/4 + 500, height/2 + 120, 200, 200);
    image(oreoMilkshake, width/4 + 75, height/2 + 120, 150, 250);
  }
  
  void displaySettings()
  {
    background(settingsMenu);
  }
  
  void displayEasy()
  {
    fill(255);
    noStroke();
    image(easy, width/2 + 75, height/2, 100, 100);
    rect(width/2 + 235, height/2 - 75, 150, 150);
  }
  
  void displayHard()
  {
    fill(255);
    noStroke();
    image(hard, width/2 + 320, height/2 - 15, 130, 110);
    rect(width/2, height/2 - 75, 150, 150);
  }
  
  void displayControls()
  {
    background(controlsMenu);
  }
  
  void scene1()
  {
    background(scene1);
  }
  
  void scene2()
  {
    background(scene2);
  }
  
  void scene3()
  {
    background(scene3);
  }
  
  void theater()
  {
    background(theater);
  }
  
  void blank()
  {
    textMode(CENTER);
    fill(0);
    text("Press 1, 2, or 3", 450, 125);
    text("to play a movie!", 450, 141);
    text("Press 4 to stop", 450, 170);
    text("previous video.", 450, 190);
    fill(255);
    text("Press 'b' to go back to menu", 350, height - 300);
  }
}
