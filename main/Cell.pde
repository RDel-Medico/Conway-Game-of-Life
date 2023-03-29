class Cell {
  int posX;
  int posY;
  int largeur;
  int longeur;
  
  boolean alive;
  
  Color col;
  
  Cell (int x, int y, int largeur, int longeur) {
    this.posX = x;
    this.posY = y;
    this.largeur = largeur;
    this.longeur = longeur;
    this.alive = false;
  }
  
  void display() {
    noStroke();
    if (this.alive) {
      fill(col.red, col.green, col.blue);
    } else {
      fill(255);
    }
    rect(posX, posY, largeur*10, longeur*10);
  }
}
