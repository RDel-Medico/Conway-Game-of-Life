class Game {
  Cell [] allCell;
  Cell [] cellAlive;
  int nbCellLargeur;
  int nbCellHauteur;
  
  int speed;
  int previousFrame;
  
  boolean running;
  
  Game (int nbCellLargeur, int nbCellHauteur, Color col) {
    this.nbCellLargeur = nbCellLargeur;
    this.nbCellHauteur = nbCellHauteur;
    allCell = new Cell[0];
    cellAlive = new Cell[0];
    this.running = false;
    this.previousFrame = 0;
    this.speed = 59;
    float sizeX = width / this.nbCellLargeur;
        float sizeY = width / this.nbCellLargeur;
        
        
    for (int i = 0; i < nbCellHauteur; i++) {
      for (int j = 0; j < nbCellLargeur; j++) {
        allCell = (Cell[]) append(allCell, new Cell(j * sizeX, i*sizeY, sizeX, sizeY, col, i*nbCellLargeur+j));
      }
    }
  }
  
  void run (int currentFrame) {
    if (currentFrame < previousFrame) {
      if (currentFrame + 60 - previousFrame == speed) {
        this.nextStep();
      }
    } else if (currentFrame - previousFrame == speed) {
      this.nextStep();
    }
  }
  
  void setColor (Color col) {
    for (Cell c : this.allCell) {
      c.col = col;
    }
  }
  
  void nextStep() {
    
    Cell[] newCellAlive = new Cell[0];
    
    Cell []neighbors = new Cell[8];
    for (Cell c : cellAlive) {
      neighbors = this.getNeighbors(c);
      
      if (nbAlive(neighbors) == 2 || nbAlive(neighbors) == 3) {
        if (!contain(newCellAlive, c)) {
          newCellAlive = (Cell[])append(newCellAlive, c);
        }
      }
      
      for (Cell cell : neighbors) {
        if (cell != null) {
          if (nbAlive(this.getNeighbors(cell)) == 3) {
            if (!contain(newCellAlive, cell)) {
              newCellAlive = (Cell[])append(newCellAlive, cell);
            }
          }
        }
      }
    }
    
    for (Cell c : cellAlive) {
      allCell[c.index].alive = false;
    }
    
    this.cellAlive = newCellAlive;
    
    for (Cell c : cellAlive) {
      allCell[c.index].alive = true;
    }
  }
  
  boolean contain(Cell [] cells, Cell c) {
    for (Cell cell : cells) {
      if (c == cell) {
        return true; 
      }
    }
    return false;
  }
  
  int nbAlive(Cell[] cell){
    int nb = 0;
    
    for (Cell c : cell){
      if (c != null){
        if (c.alive){
        nb++;
      }
      }
    }
    
    return nb;
  }
  
  Cell[] getNeighbors (Cell c) {
    
    boolean onTopLine = c.index < nbCellLargeur;
    boolean onLeftLine = c.index % nbCellLargeur == 0;
    boolean onRightLine = c.index % nbCellLargeur == nbCellLargeur - 1;
    boolean onBottomLine = c.index >= (nbCellHauteur-1) * nbCellLargeur;
    
    if (!onTopLine && !onLeftLine && !onRightLine && !onBottomLine) { // In the middle
      return new Cell[]{allCell[c.index-nbCellLargeur-1], allCell[c.index-nbCellLargeur], allCell[c.index-nbCellLargeur+1], allCell[c.index+1], allCell[c.index+nbCellLargeur+1], allCell[c.index+nbCellLargeur], allCell[c.index+nbCellLargeur-1], allCell[c.index-1]}; // return 8 cell around
    }
    
    if (onTopLine && !onLeftLine && !onRightLine) { // Not in a corner in the top line
      return new Cell[]{null, null, null, allCell[c.index+1], allCell[c.index+nbCellLargeur+1], allCell[c.index+nbCellLargeur], allCell[c.index+nbCellLargeur-1], allCell[c.index-1]}; // return 5 cell (craft boat)
    }
    
    if (onBottomLine && !onLeftLine && !onRightLine) { // Not in a corner in the bottom line
       return new Cell[]{allCell[c.index-nbCellLargeur-1], allCell[c.index-nbCellLargeur], allCell[c.index-nbCellLargeur+1], allCell[c.index+1], null, null, null, allCell[c.index-1]};// return 5 cell (craft helmet)
    }
    
    if (onLeftLine && !onTopLine && !onBottomLine) { // Not in a corner in the left line
      return new Cell[]{null, allCell[c.index-nbCellLargeur], allCell[c.index-nbCellLargeur+1], allCell[c.index+1], allCell[c.index+nbCellLargeur+1], allCell[c.index+nbCellLargeur], null, null}; // return 5 cell (without left line)
    }
    
    if (onRightLine && !onTopLine && !onBottomLine) { // Not in a corner in the right line
      return new Cell[]{allCell[c.index-nbCellLargeur-1], allCell[c.index-nbCellLargeur], null, null, null, allCell[c.index+nbCellLargeur], allCell[c.index+nbCellLargeur-1], allCell[c.index-1]}; // return 5 cell (C without right line)
    }
    
    if (onRightLine && onTopLine) { // Top right corner
      return new Cell[]{null, null, null, null, null, allCell[c.index+nbCellLargeur], allCell[c.index+nbCellLargeur-1], allCell[c.index-1]}; // return 3 cell bottom left
    }
    
    if (onLeftLine && onTopLine) { // Top left corner
      return new Cell[]{null, null, null, allCell[c.index+1], allCell[c.index+nbCellLargeur+1], allCell[c.index+nbCellLargeur], null, null}; // return 3 cell bottom right
    }
    
    if (onRightLine && onBottomLine) { // bottom right corner
      return new Cell[]{allCell[c.index-nbCellLargeur-1], allCell[c.index-nbCellLargeur], null, null, null, null, null, allCell[c.index-1]}; // return 3 cell top left
    }
    
    // return 3 cell top right
    return new Cell[]{null, allCell[c.index-nbCellLargeur], allCell[c.index-nbCellLargeur+1], allCell[c.index+1], null, null, null, null}; // Bottom left corner
    
    
  }
  
  void click() {
    float size = width / this.nbCellLargeur;
    int caseX = (int)((mouseX - (mouseX % size)) / size);
    
    
    
    size = height / this.nbCellHauteur;
    int caseY = (int)((mouseY - (mouseY % size)) / size);
    
    if (allCell[this.nbCellLargeur * caseY + caseX].alive) {
      allCell[this.nbCellLargeur * caseY + caseX].alive = false;
      Cell[] temp = new Cell[cellAlive.length - 1];
      int offset = 0;
      for (int i = 0; i < cellAlive.length; i++) {
        if (cellAlive[i] != allCell[this.nbCellLargeur * caseY + caseX]) {
          temp[i+offset] = cellAlive[i];
        } else {
          offset = -1;
        }
      }
      this.cellAlive = temp;
    } else {
      allCell[this.nbCellLargeur * caseY + caseX].alive = true;
      cellAlive = (Cell[]) append(cellAlive, allCell[this.nbCellLargeur * caseY + caseX]);
    }
    display();
  }
  
  void display() {
    background(255);
    stroke(0);
    strokeWeight(10);
    float size = width / this.nbCellLargeur;
    for (int i = 1; i < this.nbCellLargeur; i++) {
      line(size * i, 0, size * i, height);
    }
    
    size = height / this.nbCellHauteur;
    for (int i = 1; i < this.nbCellHauteur; i++) {
      line(0, size * i, width, size * i);
    }
    
    for (Cell c : cellAlive) {
      c.display();
    }
  }
}
