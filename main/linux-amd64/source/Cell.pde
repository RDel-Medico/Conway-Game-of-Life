
/*
This class represent a Cell of the game
 */
class Cell {
  //Display variable
  float posX;
  float posY;
  float largeur;
  float longeur;

  int index; // index of the cell on the current grid

  boolean alive; // is the cell alive

  Color col; // The color of the cell when she is alive

  Cell (float x, float y, float largeur, float longeur, Color col, int index) {
    this.posX = x;
    this.posY = y;
    this.largeur = largeur;
    this.longeur = longeur;
    this.alive = false;
    this.col = col;
    this.index = index;
  }

  /*
  Display the cell (colored if alive)
   */
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
