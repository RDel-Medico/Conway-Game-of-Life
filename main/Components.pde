class Color {
  int red;
  int green;
  int blue;
  
  Color (int r, int g, int b) {
    this.red = r;
    this.green = g;
    this.blue = b;
  }
  
  Color (int b) {
    this.red = b;
    this.green = b;
    this.blue = b;
  }
}

class Button {
  int posX;
  int posY;
  int largeur;
  int hauteur;
  Color col;
  boolean clicked;
  String text;
  
  Button(int x, int y, int largeur, int hauteur, Color col, String text) {
    this.posX = x - largeur / 2;
    this.posY = y - hauteur / 2;
    this.largeur = largeur;
    this.hauteur = hauteur;
    this.col = col;
    this.clicked = false;
    this.text = text;
  }
  
  boolean mouseHover () {
    return mouseX >= this.posX && mouseX <= this.posX + this.largeur && mouseY >= this.posY && mouseY <= this.posY + this.hauteur;
  }
  
  void clicked() {
    if (this.mouseHover()){
      this.clicked = true;
    }
  }
  
  boolean released() {
    this.clicked = false;
    return this.mouseHover();
  }
  
  void display() {
    if (this.clicked) {
      stroke(100);
      strokeWeight(5);
    } else{
      stroke(0);
      strokeWeight(5);
    }
    if (this.mouseHover()){
      fill(this.col.red - 50, this.col.green - 50, this.col.blue - 50);
    } else {
      fill(this.col.red, this.col.green, this.col.blue);
    }
    rect(posX, posY, largeur, hauteur);
    
    textSize(50);
    textAlign(CENTER);
    fill(0);
    text(this.text, this.posX + largeur / 2, this.posY + this.hauteur / 2 + 15);
  }
}

class Cursor {
  float valuePourcent;
  int posX;
  int posY;
  int largeur;
  int valueMin;
  int valueMax;
  int value;
  
  Cursor (int posX, int posY, int largeur, int min, int max) {
    this.posX = posX;
    this.posY = posY;
    this.valuePourcent = 0;
    this.largeur = largeur;
    this.valueMin = min;
    this.valueMax = max;
    this.value = valueMin + (int)(( max - min ) * valuePourcent);
  }
  
  void updateValue() {
    this.value = this.valueMin + (int)(( this.valueMax - this.valueMin ) * valuePourcent); 
  }
  
  void displayBar() {
    fill(150);
    stroke(100);
    strokeWeight(2);
    rect(posX - largeur / 2, posY - 5, largeur, 10);
  }
  
  void displaySelector() {
    fill(lightBlue.red, lightBlue.green, lightBlue.blue);
    stroke(0);
    strokeWeight(2);
    circle((posX - largeur / 2) + largeur * valuePourcent, posY, 30);
  }
  
  void displayValue() {
    fill(lightBlue.red, lightBlue.green, lightBlue.blue);
    strokeWeight(2);
    stroke(0);
    rect(posX - largeur / 2 + largeur + 20, posY - 20, 75, 40);
    fill(0);
    textSize(30);
    text(this.value, posX - largeur / 2 + largeur + 20 + 37, posY + 10);
  }
  
  boolean selectorClicked() {
    int x = (int)((posX - largeur / 2) + largeur * valuePourcent);
    int y = posY;
    return sqrt(pow(max(mouseX, x) - min(mouseX, x), 2) + pow(max(mouseY, y) - min(mouseY, y), 2)) < 30;
  }
  
  void display() {
    updateValue();
    displayBar();
    displaySelector();
    displayValue();
  }
}

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
  
  void display() {
    textSize(this.fontWeight);
    fill(this.col.red, this.col.green, this.col.blue);
    textAlign(CENTER);
    text(this.text, posX, posY);
  }
}
