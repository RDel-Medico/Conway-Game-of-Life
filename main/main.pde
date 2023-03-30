//Color used for the app
final Color black = new Color (0);
final Color lightBlue = new Color(162, 240, 235);

Game game; // The instance of the game

/*
 app.app[0] = Home
 app.app[1] = Simulation
 app.app[2] = Option
 app.app[3] = Credit
 */
Application app;

//The current frame of the simulation
int currentFrame = 0;

boolean keyPresseds[] = new boolean[]{false, false, false, false};

void setup() {
  size(900, 900);

  //Creation of the app and all it's menu
  app = new Application(initMenuHome());
  app.addMenu(initMenuSimulation());
  app.addMenu(initMenuSettings());
  app.addMenu(initMenuCredit());

  //Creation of the game
  game = new Game(app.app[2].cursors[0].value, app.app[2].cursors[1].value, new Color(app.app[2].cursors[1].value, app.app[2].cursors[3].value, app.app[2].cursors[4].value));

  //Selection of the font
  PFont myFont = createFont(PFont.list()[158], 32);
  textFont(myFont);

  //Select the frameRate
  frameRate(60);
}


void draw() {
  if (app.currentMenu != app.app[1]) { // On any menu except the simulation one, we display the classic background
    backgroundPage();
  } else { // If we are on the simulation menu
    background(255);
    game.display(); //Display the game (grid + cell alive)

    if (game.running) { // If the auto simulation is running
      game.run(currentFrame);

      //update the currenteFrame
      currentFrame++;
      if (currentFrame == 60) {
        currentFrame = 0;
      }
    }
  }

  app.display(); // We display the app (the currentMenu)

  if (app.currentMenu == app.app[2]) { // If we are in the settings we display the color picked visualizer
    stroke(0);
    strokeWeight(2);
    fill(app.currentMenu.cursors[2].value, app.currentMenu.cursors[3].value, app.currentMenu.cursors[4].value);
    rect(30, 480, 160, 250);
  }

  if (app.currentMenu == app.app[1]) {
    manageMovement();
  }
}

void manageMovement() {
  
  if (keyPresseds[0]) {
    if (game.offsetY < 0) {
      game.offsetY+=10;
      game.updateCellPosition(); 
    }
  }
  if (keyPresseds[1]) {
    if (height-game.offsetY < game.nbCellHauteur * game.allCell[0].longeur) {
      game.offsetY-=10;
      game.updateCellPosition();
    }
  }
  if (keyPresseds[2]) {
    if (game.offsetX < 0) {
      game.offsetX+=10;
      game.updateCellPosition();
    }
  }
  if (keyPresseds[3]) {
    if (width-game.offsetX < game.nbCellLargeur * game.allCell[0].largeur) {
      game.offsetX-=10;
      game.updateCellPosition();
    }
  }
}
void mouseWheel(MouseEvent event) {
  if (app.currentMenu == app.app[1]) {
    if (event.getCount() == -1) { // scroll out
      game.decrementZomm();
    } else { //  scroll in
      game.incrementZomm();
    }
    game.updateZoom();
  }
}

void keyPressed() {
  if (app.currentMenu == app.app[1]) {
    if (keyCode == 'Z') {
      keyPresseds[0] = true;
    }
    if (keyCode == 'S') {
      keyPresseds[1] = true;
    }
    if (keyCode == 'Q') {
      keyPresseds[2] = true;
    }
    if (keyCode == 'D') {
      keyPresseds[3] = true;
    }
  }
}

void keyReleased() {
  if (app.currentMenu == app.app[1]) {
    if (keyCode == 'Z') {
      keyPresseds[0] = false;
    }
    if (keyCode == 'S') {
      keyPresseds[1] = false;
    }
    if (keyCode == 'Q') {
      keyPresseds[2] = false;
    }
    if (keyCode == 'D') {
      keyPresseds[3] = false;
    }
  }
}

void mousePressed() {
  //Manage a click on the app
  app.click();

  if (game.running == false && app.currentMenu == app.app[1]) { // If the click append while the game is not running and in the simulation menu

    if (app.release() == -1 && !(app.app[1].cursors[0].selectorClicked())) { // If the click is not on a button or a cursor while the game is not running
      game.click(); // We do a click on the game (change the state of the cell we clicked on)
      game.display();
    } else if (app.release() == 1) { // click on button Next step while the game is not running
      game.nextStep(); // we go to next step
    }
  }
}

void mouseDragged() {
  if (game.running == false && app.currentMenu == app.app[1]) { // If the game is not running and in the simulation menu
    app.dragged(); // Let the app manage cursors dragging
    game.setSpeed(app.app[1].cursors[0].value); // We change the speed of the game
    currentFrame = 0;
  } else if (app.currentMenu != app.app[1]) {
    app.dragged();
  }
}

void mouseReleased() {

  /*
  We manage all the button
   */

  if (app.currentMenu == app.app[0]) { // Manage buttons of Home

    if (app.release() == 0) { // Button Simulation
      app.changeMenu(1); //Menu active become Simulation
    }

    if (app.release() == 1) { // Button settings
      app.changeMenu(2); // Menu active become settings
    }

    if (app.release() == 2) { // Button credit
      app.changeMenu(3); // Menu active become credit
    }
  } else if (app.currentMenu == app.app[2]) { // Manage buttons of Settings

    if (app.release() == 0) { // Button back
      app.changeMenu(0); // Menu active become home
      game = new Game(app.app[2].cursors[0].value, app.app[2].cursors[1].value, new Color(app.app[2].cursors[2].value, app.app[2].cursors[3].value, app.app[2].cursors[4].value)); // We create a new game with the new value
    }
  } else if (app.currentMenu == app.app[3]) { // Manage buttons of Credit

    if (app.release() == 0) { // Button back
      app.changeMenu(0); // Menu active become home
    }
  } else if (app.currentMenu == app.app[1]) { // Manage buttons of simulation

    if (app.release() == 0) { // Button back
      app.changeMenu(0); // Menu active become home
    } else if (app.release() == 2 && game.running == false) { // Button Run
      //Set running true and change text of run button
      game.running = true;
      app.app[1].buttons[2].text = "Stop";
    } else if (app.release() == 2 && game.running == true) { // button Stop
      //Set running false and change text of stop button
      game.running = false;
      app.app[1].buttons[2].text = "Run";
    }
  }
}

/*
Generic background for the app
 */
void backgroundPage() {
  background(255); //white backgroud
  stroke(70);
  strokeWeight(2);

  //black line
  for (int i = 0; i < 20; i++) {
    line(i * (width/20), 0, i * (width/20), height);
    line(0, i * (width/20), width, i * (width/20));
  }
}

/*
Function to create the menu home
 */
Menu initMenuHome() {
  Button b;
  Text t;
  Menu home = new Menu();

  //Title
  t = new Text("Game of Life", width/2, 200, 100, black);
  home.addText(t);

  //Button simulation
  b = new Button (width/2, 350, 400, 100, lightBlue, "Simulation");
  home.addButton(b);

  //Button settings
  b = new Button (width/2, 500, 400, 100, lightBlue, "Settings");
  home.addButton(b);

  //Buton credit
  b = new Button (width/2, 650, 400, 100, lightBlue, "Credit");
  home.addButton(b);

  return home;
}

/*
Function to create the menu simulation
 */
Menu initMenuSimulation() {
  Button b;
  Text t;
  Cursor c;
  Menu simulation = new Menu();

  //Button back
  b = new Button (105, height-50, 150, 50, lightBlue, "Back");
  simulation.addButton(b);

  //Button next Step
  b = new Button (width/2, height-50, 250, 50, lightBlue, "Next step");
  simulation.addButton(b);

  //Button run
  b = new Button (width/2 + 350, height-50, 150, 50, lightBlue, "Run");
  simulation.addButton(b);

  //Cursors to select simulation speed
  c = new Cursor(width/2, 50, 400, 1, 30);
  simulation.addCursor(c);

  //Text for the cursors
  t = new Text("Step/s", width/2 - 285, 55, 30, black);
  simulation.addText(t);

  return simulation;
}

/*
Function to create the menu settings
 */
Menu initMenuSettings() {
  Button b;
  Text t;
  Cursor c;
  Menu option = new Menu();

  //Title of the menu
  t = new Text("Settings", width/2, 100, 100, black);
  option.addText(t);

  //------------------------------Map settings------------------------------------
  //Little title
  t = new Text("Map settings", width/2, 200, 50, black);
  option.addText(t);

  //Text + cursor for width
  t = new Text("Width of the map", width/2 - 300, 265, 30, black);
  option.addText(t);

  c = new Cursor(width/2 + 50, 260, 400, 10, 1000);
  option.addCursor(c);

  //Text + cursor for height
  t = new Text("Height of the map", width/2 - 300, 360, 30, black);
  option.addText(t);

  c = new Cursor(width/2 + 50, 355, 400, 10, 1000);
  option.addCursor(c);
  //-----------------------------------------------------------------------------

  //------------------------------Color settings---------------------------------
  //Little title
  t = new Text("Color of Cell", width/2, 430, 50, black);
  option.addText(t);

  //Text + cursor for red
  c = new Cursor(width/2 + 50, 500, 400, 0, 255);
  option.addCursor(c);

  t = new Text("Red", width/2 - 200, 505, 30, black);
  option.addText(t);

  //Text + cursor for green
  c = new Cursor(width/2 + 50, 595, 400, 0, 255);
  option.addCursor(c);

  t = new Text("Green", width/2 - 200, 600, 30, black);
  option.addText(t);

  //Text + cursor for blue
  c = new Cursor(width/2 + 50, 710, 400, 0, 255);
  option.addCursor(c);

  t = new Text("Blue", width/2 - 200, 715, 30, black);
  option.addText(t);
  //-----------------------------------------------------------------------------

  //Button back
  b = new Button (width/2, 800, 400, 100, lightBlue, "Back");
  option.addButton(b);

  return option;
}

/*
Function to create the menu Credit
 */
Menu initMenuCredit() {
  Button b;
  Text t;
  Menu credit = new Menu();

  //Button back
  b = new Button (width/2, 650, 400, 100, lightBlue, "Back");
  credit.addButton(b);

  //Text created by
  t = new Text("Created By", width/2, 200, 100, black);
  credit.addText(t);

  t = new Text("Rémi Del Medico", width/2, 400, 70, black);
  credit.addText(t);

  return credit;
}
