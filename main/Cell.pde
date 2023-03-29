class Cell {
  float posX;
  float posY;
  float largeur;
  float longeur;
  
  int index;
  
  boolean alive;
  
  Color col;
  
  Cell (float x, float y, float largeur, float longeur, Color col, int index) {
    this.posX = x;
    this.posY = y;
    this.largeur = largeur;
    this.longeur = longeur;
    this.alive = false;
    this.col = col;
    this.index = index;
  }
  
  void display() {
    noStroke();
    if (this.alive) {
      fill(col.red, col.green, col.blue);
    } else {
      fill(255);
    }
    rect(posX+1, posY+1, largeur-2, longeur-2);
  }
}
