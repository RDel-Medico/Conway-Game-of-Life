
/*
This class represent a color (Red,  Green, Blue)
 */
class Color {
  int red;
  int green;
  int blue;

  //Constructor for normal color
  Color (int r, int g, int b) {
    this.red = r;
    this.green = g;
    this.blue = b;
  }

  //Constructor for grey variante
  Color (int b) {
    this.red = b;
    this.green = b;
    this.blue = b;
  }
}


/*
This class represent a button
 */
class Button {

  String text; // Text on the button
  int posX;
  int posY;
  int largeur;
  int hauteur;

  Color col; // Color of the button

  boolean clicked; // Is the button currently clicked


  Button(int x, int y, int largeur, int hauteur, Color col, String text) {
    this.posX = x - largeur / 2;
    this.posY = y - hauteur / 2;
    this.largeur = largeur;
    this.hauteur = hauteur;
    this.col = col;
    this.clicked = false;
    this.text = text;
  }

  // Return true if the mouse is hovering the button
  boolean mouseHover () {
    return mouseX >= this.posX && mouseX <= this.posX + this.largeur && mouseY >= this.posY && mouseY <= this.posY + this.hauteur;
  }

  // Set clicked at true if the button is hovered
  void clicked() {
    if (this.mouseHover()) {
      this.clicked = true;
    }
  }

  //Set clicked at false if the button is hovered
  boolean released() {
    this.clicked = false;
    return this.mouseHover();
  }

  //Display the button Normal color if not overed, darker color if hovered, and change the border based on if the button is clicked
  void display() {

    //Border depend on if the button is clicked
    if (this.clicked) {
      stroke(100);
      strokeWeight(5);
    } else {
      stroke(0);
      strokeWeight(5);
    }

    //Filling of the button depend on if the button is hovered
    if (this.mouseHover()) {
      fill(this.col.red - 50, this.col.green - 50, this.col.blue - 50);
    } else {
      fill(this.col.red, this.col.green, this.col.blue);
    }

    //Button
    rect(posX, posY, largeur, hauteur);

    //Text on the button
    textSize(50);
    textAlign(CENTER);
    fill(0);
    text(this.text, this.posX + this.largeur / 2, this.posY + this.hauteur / 2 + 15);
  }
}

/*
This represent a movable cursor to select a data
 */
class Cursor {
  //Display parameters
  int posX;
  int posY;
  int largeur;

  float valuePourcent; // The pourcent of the value we want (cursors full left = 0 and cursor full right = 1)
  int valueMin; // The minimal value we can go on the cursor
  int valueMax; // The maximal value we can go on the cursor
  int value; // The current value Selected

  Cursor (int posX, int posY, int largeur, int min, int max) {
    this.posX = posX;
    this.posY = posY;
    this.valuePourcent = 0;
    this.largeur = largeur;
    this.valueMin = min;
    this.valueMax = max;
    this.value = valueMin;
  }

  //Update the currentValue based on the min, max and the currentValue in pourcent
  void updateValue() {
    this.value = this.valueMin + (int)(( this.valueMax - this.valueMin ) * valuePourcent);
  }

  //Display the bar of the cursors
  void displayBar() {
    fill(150);
    stroke(100);
    strokeWeight(2);
    rect(posX - largeur / 2, posY - 5, largeur, 10);
  }

  //Display the selector of the cursor (the moving circle)
  void displaySelector() {
    fill(lightBlue.red, lightBlue.green, lightBlue.blue);
    stroke(0);
    strokeWeight(2);
    circle((posX - largeur / 2) + largeur * valuePourcent, posY, 30);
  }

  //Display the current value as a text in a rectangle
  void displayValue() {
    fill(lightBlue.red, lightBlue.green, lightBlue.blue);
    strokeWeight(2);
    stroke(0);
    rect(posX - largeur / 2 + largeur + 20, posY - 20, 75, 40);
    fill(0);
    textSize(30);
    text(this.value, posX - largeur / 2 + largeur + 57, posY + 10);
  }

  // return true if the mouse is hovering the selector and false otherwise
  boolean selectorClicked() {
    int x = (int)((posX - largeur / 2) + largeur * valuePourcent);
    //Distance to from mouse to center of selector inferior to radius of the selector
    return sqrt(pow(max(mouseX, x) - min(mouseX, x), 2) + pow(max(mouseY, this.posY) - min(mouseY, this.posY), 2)) < 30;
  }

  //Display the whole cursor
  void display() {
    displayBar();
    displaySelector();
    displayValue();
  }
}

/*
This class reprensent a text
 */
class Text {
  int fontWeight;
  String text;
  int posX;
  int posY;
  Color col;

  Text (String text, int x, int y, int size, Color col) {
    this.posX = x;
    this.posY = y;
    this.col = col;
    this.text = text;
    this.fontWeight = size;
  }
  /*
  Display the text
   */
  void display() {
    textSize(this.fontWeight);
    fill(this.col.red, this.col.green, this.col.blue);
    textAlign(CENTER);
    text(this.text, posX, posY);
  }
}
