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
  
  Button(int x, int y, int largeur, int hauteur, Color col) {
    this.posX = x;
    this.posY = y;
    this.largeur = largeur;
    this.hauteur = hauteur;
    this.col = col;
    this.clicked = false;
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
      stroke(255);
      strokeWeight(5);
    } else{
      noStroke();
    }
    
    if (this.mouseHover()){
      fill(this.col.red - 50, this.col.green - 50, this.col.blue - 50);
    } else {
      fill(this.col.red, this.col.green, this.col.blue);
    }
    rect(posX, posY, largeur, hauteur);
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
    text(this.text, posX, posY);
  }
}
