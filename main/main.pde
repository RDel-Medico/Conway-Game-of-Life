final Color black = new Color (0);
final Color lightBlue = new Color(162, 240, 235);

Menu home;
Menu simulation;
Menu  option;

Game game;

/*
 app.app[0] = Home
 app.app[1] = Simulation
 app.app[2] = Option
 app.app[3] = Credit
*/
Application app;

Button b;

int currentFrame = 0;
  
void setup() {
  size(900, 900);
  
  app = new Application(initMenuHome());
  app.addMenu(initMenuSimulation());
  app.addMenu(initMenuOption());
  app.addMenu(initMenuCredit());
  
  game = new Game(app.app[2].cursors[0].value, app.app[2].cursors[1].value, new Color(app.app[2].cursors[1].value, app.app[2].cursors[3].value, app.app[2].cursors[4].value));
  
  PFont myFont = createFont(PFont.list()[158], 32);
  
  textFont(myFont);
  
  frameRate(60);

}


void draw() {
  if (app.currentMenu != app.app[1]) {
    backgroundPage();
  } else {
    background(255);
    game.display();
    if (game.running) {
      game.run(currentFrame);
      currentFrame++;
      if (currentFrame == 60) {
        currentFrame = 0;
      } 
    }
  }
  
  app.display();
  
  if (app.currentMenu == app.app[2]) {
    stroke(0);
    strokeWeight(2);
    fill(app.currentMenu.cursors[2].value, app.currentMenu.cursors[3].value, app.currentMenu.cursors[4].value);
    rect(30, 480, 160, 250);
  }
}

void mousePressed() {
  app.click();
  if (game.running == false && app.currentMenu == app.app[1]) {
    if (app.release() == -1 && !(app.app[1].cursors[0].selectorClicked())) { // If the click is not on a button
      game.click();
    } else if (app.release() == 1) { // Button Next step
      game.nextStep();
    }
  }
}

void mouseDragged() {
  app.dragged();
}

void mouseReleased() {
  
  if (app.currentMenu == app.app[0]) { // Manage buttons of Home
  
    if (app.release() == 0) { // Button Simulation
      app.changeMenu(1); //Menu active become Simulation
    }
    
    if (app.release() == 1) { // Button option
      app.changeMenu(2);
    }
    
    if (app.release() == 2) { // Button credit
      app.changeMenu(3);
    }
  } else if (app.currentMenu == app.app[2]) { // Manage buttons of Settings
    if (app.release() == 0) { // Button back
      app.changeMenu(0);
      game.setColor(new Color(app.app[2].cursors[2].value, app.app[2].cursors[3].value, app.app[2].cursors[4].value));
      game = new Game(app.app[2].cursors[0].value, app.app[2].cursors[1].value, new Color(app.app[2].cursors[2].value, app.app[2].cursors[3].value, app.app[2].cursors[4].value));
    }
  } else if (app.currentMenu == app.app[3]) { // Manage buttons of Credit
    if (app.release() == 0) { // Button back
      app.changeMenu(0);
    }
  } else if (app.currentMenu == app.app[1]) { // Manage buttons of simulation
    if (app.release() == 0) { // Button back
      app.changeMenu(0);
    } else if (app.release() == 2 && game.running == false) { // Button Run
      game.running = true;
      app.app[1].buttons[2].text = "Stop";
    } else if (app.release() == 2 && game.running == true) { // button Stop
      game.running = false;
      app.app[1].buttons[2].text = "Run";
    }
  }
}

void backgroundPage() {
  background(255);
  stroke(70);
  strokeWeight(2);
  
  for (int i = 0; i < 20; i++) {
    line(i * (width/20), 0, i * (width/20), height);
    line(0, i * (width/20), width, i * (width/20));
  }
}


Menu initMenuHome() {
  Button b;
  Text t;
  Menu home = new Menu();
  
  t = new Text("Game of Life", width/2, 200, 100, black);
  home.addText(t);
  
  b = new Button (width/2, 350, 400, 100, lightBlue, "Simulation");
  home.addButton(b);
  
  b = new Button (width/2, 500, 400, 100, lightBlue, "Settings");
  home.addButton(b);
  
  b = new Button (width/2, 650, 400, 100, lightBlue, "Credit");
  home.addButton(b);
  
  return home;
}


Menu initMenuSimulation() {
  Button b;
  Text t;
  Cursor c;
  Menu simulation = new Menu();
  
  b = new Button (105, height-50, 150, 50, lightBlue, "Back");
  simulation.addButton(b);
  
  b = new Button (width/2, height-50, 250, 50, lightBlue, "Next step");
  simulation.addButton(b);
  
  b = new Button (width/2 + 350, height-50, 150, 50, lightBlue, "Run");
  simulation.addButton(b);
  
  t = new Text("Step/s", width/2 - 285, 55, 30, black);
  simulation.addText(t);
  
  c = new Cursor(width/2, 50, 400, 1, 30);
  simulation.addCursor(c);
  
  return simulation;
}

Menu initMenuOption() {
  Button b;
  Text t;
  Menu option = new Menu();
  Cursor c;
  
  t = new Text("Settings", width/2, 100, 100, black);
  option.addText(t);
  
  
//------------------------------Map settings------------------------------------
  t = new Text("Map settings", width/2, 200, 50, black);
  option.addText(t);
  
  t = new Text("Width of the map", width/2 - 300, 265, 30, black);
  option.addText(t);
  
  c = new Cursor(width/2 + 50, 260, 400, 10, 1000);
  option.addCursor(c);
  
  t = new Text("Height of the map", width/2 - 300, 360, 30, black);
  option.addText(t);
  
  c = new Cursor(width/2 + 50, 355, 400, 10, 1000);
  option.addCursor(c);
//-----------------------------------------------------------------------------
  
  
//------------------------------Color settings------------------------------------
  t = new Text("Color of Cell", width/2, 430, 50, black);
  option.addText(t);
  
  t = new Text("Red", width/2 - 200, 505, 30, black);
  option.addText(t);
  
  t = new Text("Green", width/2 - 200, 600, 30, black);
  option.addText(t);
  
  t = new Text("Blue", width/2 - 200, 715, 30, black);
  option.addText(t);
  
  c = new Cursor(width/2 + 50, 500, 400, 0, 255);
  option.addCursor(c);
  
  c = new Cursor(width/2 + 50, 595, 400, 0, 255);
  option.addCursor(c);
  
  c = new Cursor(width/2 + 50, 710, 400, 0, 255);
  option.addCursor(c);
//-----------------------------------------------------------------------------
  
    
  b = new Button (width/2, 800, 400, 100, lightBlue, "Back");
  option.addButton(b);
  
  return option;
}

Menu initMenuCredit() {
  Button b;
  Text t;
  Menu credit = new Menu();
  
  b = new Button (width/2, 650, 400, 100, lightBlue, "Back");
  credit.addButton(b);
  
  t = new Text("Created By", width/2, 200, 100, black);
  credit.addText(t);
  
  t = new Text("Rémi Del Medico", width/2, 400, 70, black);
  credit.addText(t);
  
  return credit;
}
