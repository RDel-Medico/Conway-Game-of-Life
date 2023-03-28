Menu home;
Button b;
Color col;
Text t;

Application app;

Menu secondPage;


void setup() {
  size(900, 900);
  home = new Menu();
  col = new Color(150, 30, 70);
  t = new Text ("CECI EST UN TEST", 500, 500, 30, col);
  b = new Button(50, 50, 500, 50, col);
  home.addButton(b);
  col = new Color(150);
  b = new Button(50, 200, 500, 50, col);
  home.addButton(b);
  home.addText(t);
  
  app = new Application(home);
  
  secondPage = new Menu();
  col = new Color(150, 30, 70);
  t = new Text ("ZZZZZZZZZZZZZZZZZ", 500, 500, 30, col);
  secondPage.addText(t);
  
  app.addMenu(secondPage);
}


void draw() {
  background(0);
  app.display();
}

void mousePressed() {
  app.click();
}

void mouseReleased() {
  if (app.release() == 0) {
    app.changeMenu(secondPage);
  }
  
}
