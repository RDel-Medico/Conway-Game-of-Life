/*
This class represente an instance of the game of life
 */
class Game {
  Cell [] allCell; // Represent all the cell of the game
  Cell [] cellAlive; // Represent all the celle alive of the game

  //dimension of the game
  int nbCellLargeur;
  int nbCellHauteur;
  int zoom;
  int offsetX;
  int offsetY;
  int lineSize;

  //Parameters related to the auto simulation
  int speed; // speed is equals to the number of frame it take to do a step (max 59 is the slowest, min 1 is the fastest)
  int previousFrame;
  boolean running; // is the game running

  Game (int nbCellLargeur, int nbCellHauteur, Color col) {
    //initialisation of dimension of the game
    this.nbCellLargeur = nbCellLargeur;
    this.nbCellHauteur = nbCellHauteur;
    this.zoom = 0;
    this.offsetX = 0;
    this.offsetY = 0;
    this.lineSize = 10;

    //initialisation of parameters related to the auto simulation
    this.speed = 59;
    this.previousFrame = 0;
    this.running = false;

    //No cell at first
    allCell = new Cell[0];
    cellAlive = new Cell[0];

    //initialisation of all cell (dead by default)
    for (int i = 0; i < nbCellHauteur; i++) {
      for (int j = 0; j < nbCellLargeur; j++) {
        allCell = (Cell[]) append(allCell, new Cell(j * 90 + offsetX, i*90 + offsetY, 90, 90, col, i*nbCellLargeur+j));
      }
    }
  }

  /*
  Function that manage the auto simulation (function need to be called each frame)
   */
  void run (int currentFrame) {
    if (currentFrame < previousFrame) { // if the current frame looped (since it is modulo 60)
      if (currentFrame + 60 == previousFrame + speed) { // We add 60
        previousFrame = currentFrame;
        this.nextStep();
      }
    } else if (currentFrame == previousFrame + speed) { // Otherwise we can directly compare
      previousFrame = currentFrame;
      this.nextStep();
    }
  }

  /*
  Increment the zoom
   */
  void incrementZomm () {
    if (this.zoom < 80) {
      if ((width < this.nbCellLargeur * (this.allCell[0].largeur)) && (height < this.nbCellHauteur * (this.allCell[0].longeur))) {
        this.zoom+=2;
      }
    }
  }

  /*
  Decrement the zoom
   */
  void decrementZomm () {
    if (this.zoom > 0) {
      this.zoom-=2;
    }
  }

  void updateZoom() {
    if (this.zoom > 60) {
      this.lineSize = 2;
    } else if (this.zoom > 30) {
      this.lineSize = 5;
    } else {
      this.lineSize = 10;
    }
    updateCellPosition();
  }

  void updateCellPosition() {
    for (int i = 0; i < nbCellHauteur; i++) {
      for (int j = 0; j < nbCellLargeur; j++) {
        allCell[i*nbCellLargeur+j].posX = j * (90-zoom) + offsetX;
        allCell[i*nbCellLargeur+j].posY = i * (90-zoom) + offsetY;
        allCell[i*nbCellLargeur+j].largeur = 90 - zoom;
        allCell[i*nbCellLargeur+j].longeur = 90 - zoom;
      }
    }
  }

  /*
  Change the color of all alive cell
   */
  void setColor (Color col) {
    for (Cell c : this.allCell) {
      c.col = col;
    }
  }

  /*
  Update all the cell alive and dead based on the two rule
   
   Rule 1 : a living cell surounded by exactly 2 or 3 cell alive stay alive otherwise it dies
   
   Rule 2 : a dead cell become alive if she is surrounded by exactly 3 living cell
   */
  void nextStep() {
    Cell[] newCellAlive = new Cell[0]; //The new tab containing all cell alive

    Cell []neighbors = new Cell[8]; // Contain the neighbors of a cell

    for (Cell c : cellAlive) { // We check all the living cell
      neighbors = this.getNeighbors(c);
      int nbNeighborsAlive = nbAlive(neighbors);

      if (nbNeighborsAlive == 2 || nbNeighborsAlive == 3) { // If the cell stay alive
        if (!contain(newCellAlive, c)) {
          newCellAlive = (Cell[])append(newCellAlive, c); // We add it to the new cellAlive tab otherwise we don't add it
        }
      }

      for (Cell cell : neighbors) { // We check each dead neighbors (to see if one become alive)
        if (cell != null && !cell.alive) { // If the neighbors is dead
          if (nbAlive(this.getNeighbors(cell)) == 3) { // And has exactly 3 alive neighbors
            if (!contain(newCellAlive, cell)) {
              newCellAlive = (Cell[])append(newCellAlive, cell); // We add the cell to the new cell Alive
            }
          }
        }
      }
    }

    for (Cell c : cellAlive) { // All previous cellAlive are set dead
      allCell[c.index].alive = false;
    }

    this.cellAlive = newCellAlive; // We change the cell Alive

    for (Cell c : cellAlive) { // All cell Alive become alive
      allCell[c.index].alive = true;
    }
  }

  //Set the speed
  void setSpeed(int value) {
    this.previousFrame = 0;
    this.speed = 59 / value;
  }

  /*
  Return true if the tab in parameters contain the cell c
   */
  boolean contain(Cell [] cells, Cell c) {
    for (Cell cell : cells) {
      if (c == cell) {
        return true;
      }
    }
    return false; // if no case matched
  }

  /*
  return the number of cell alive in the tab in parameter
   */
  int nbAlive(Cell[] cell) {
    int nb = 0;
    for (Cell c : cell) {
      if (c != null && c.alive) { // If the cell is not null and alive we add 1 cell
        nb++;
      }
    }
    return nb;
  }

  //Return a tab containing all the neighbors of the cell in parameter
  Cell[] getNeighbors (Cell c) {

    boolean onTopLine = c.index < nbCellLargeur; // True if the cell is on the line at the top of the grid
    boolean onLeftLine = c.index % nbCellLargeur == 0; // True if the cell is on the line at the left of the grid
    boolean onRightLine = c.index % nbCellLargeur == nbCellLargeur - 1; // True if the cell is on the line at the right of the grid
    boolean onBottomLine = c.index >= (nbCellHauteur-1) * nbCellLargeur; // True if the cell is on the line at the bottom of the grid

    if (!onTopLine && !onLeftLine && !onRightLine && !onBottomLine) { // the cell is n the middle
      return new Cell[]{allCell[c.index-nbCellLargeur-1], allCell[c.index-nbCellLargeur], allCell[c.index-nbCellLargeur+1], allCell[c.index+1], allCell[c.index+nbCellLargeur+1], allCell[c.index+nbCellLargeur], allCell[c.index+nbCellLargeur-1], allCell[c.index-1]}; //We return all cell around
    }

    if (onTopLine && !onLeftLine && !onRightLine) { // if the cell is not in a corner and on the top line
      return new Cell[]{null, null, null, allCell[c.index+1], allCell[c.index+nbCellLargeur+1], allCell[c.index+nbCellLargeur], allCell[c.index+nbCellLargeur-1], allCell[c.index-1]}; //We return everything except the 3 top neighbors
    }

    if (onBottomLine && !onLeftLine && !onRightLine) { // if the cell is not in a corner and on the bottom line
      return new Cell[]{allCell[c.index-nbCellLargeur-1], allCell[c.index-nbCellLargeur], allCell[c.index-nbCellLargeur+1], allCell[c.index+1], null, null, null, allCell[c.index-1]}; //We return everything except the 3 bottom neighbors
    }

    if (onLeftLine && !onTopLine && !onBottomLine) { // if the cell is not in a corner and on the left line
      return new Cell[]{null, allCell[c.index-nbCellLargeur], allCell[c.index-nbCellLargeur+1], allCell[c.index+1], allCell[c.index+nbCellLargeur+1], allCell[c.index+nbCellLargeur], null, null}; //We return everything except the 3 left neighbors
    }

    if (onRightLine && !onTopLine && !onBottomLine) { // if the cell is not in a corner and on the right line
      return new Cell[]{allCell[c.index-nbCellLargeur-1], allCell[c.index-nbCellLargeur], null, null, null, allCell[c.index+nbCellLargeur], allCell[c.index+nbCellLargeur-1], allCell[c.index-1]}; //We return everything except the 3 right neighbors
    }

    if (onRightLine && onTopLine) { // Top right corner
      return new Cell[]{null, null, null, null, null, allCell[c.index+nbCellLargeur], allCell[c.index+nbCellLargeur-1], allCell[c.index-1]}; //We return the 3 bottom left neighbors
    }

    if (onLeftLine && onTopLine) { // Top left corner
      return new Cell[]{null, null, null, allCell[c.index+1], allCell[c.index+nbCellLargeur+1], allCell[c.index+nbCellLargeur], null, null}; //We return the 3 bottom right neighbors
    }

    if (onRightLine && onBottomLine) { // bottom right corner
      return new Cell[]{allCell[c.index-nbCellLargeur-1], allCell[c.index-nbCellLargeur], null, null, null, null, null, allCell[c.index-1]}; //We return the 3 top left neighbors
    }

    //bottom left corner
    return new Cell[]{null, allCell[c.index-nbCellLargeur], allCell[c.index-nbCellLargeur+1], allCell[c.index+1], null, null, null, null}; //We return the 3 top right neighbors
  }

  void click() {
    //Calculation of the cell clicked on
    int caseX = (int)(((mouseX - offsetX) - ((mouseX - offsetX) % this.allCell[0].largeur)) / this.allCell[0].largeur);
    int caseY = (int)((((mouseY - offsetY) - ((mouseY - offsetY) % this.allCell[0].longeur))) / this.allCell[0].longeur);

    int index = this.nbCellLargeur * caseY + caseX;

    if (allCell[index].alive) { // If the cell clicked on is alive
      //She become dead
      allCell[index].alive = false;

      //We remove the cell from the tab of the cell alive
      Cell[] temp = new Cell[cellAlive.length - 1];
      int offset = 0;
      for (int i = 0; i < cellAlive.length; i++) {
        if (cellAlive[i] != allCell[index]) {
          temp[i+offset] = cellAlive[i];
        } else {
          offset = -1;
        }
      }
      this.cellAlive = temp;
    } else { // If the cell clicked on is dead

      //She become alive and we add it to the tab of alive cell
      allCell[index].alive = true;
      cellAlive = (Cell[]) append(cellAlive, allCell[index]);
    }
  }

  /*
  Display the game
   */
  void display() {
    stroke(0);
    strokeWeight(this.lineSize);
    fill(255);
    rect (offsetX, offsetY, this.nbCellLargeur * this.allCell[0].largeur, this.nbCellHauteur * this.allCell[0].longeur);
    //Display the lines
    for (int i = 1; i < this.nbCellLargeur; i++) {
      line(this.allCell[0].largeur * i + offsetX, 0, this.allCell[0].largeur * i + offsetX, height);
    }

    for (int i = 1; i < this.nbCellHauteur; i++) {
      line(0, this.allCell[0].longeur * i + offsetY, width, this.allCell[0].longeur * i + offsetY);
    }

    //display the cell alive
    for (Cell c : cellAlive) {
      c.display();
    }
  }
}
