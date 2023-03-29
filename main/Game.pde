class Game {
  Cell [] allCell;
  Cell [] cellAlive;
  int nbCellLargeur;
  int nbCellHauteur;
  
  boolean running;
  
  Game (int nbCellLargeur, int nbCellHauteur, Color col) {
    this.nbCellLargeur = nbCellLargeur;
    this.nbCellHauteur = nbCellHauteur;
    allCell = new Cell[0];
    cellAlive = new Cell[0];
    this.running = false;
    float sizeX = width / this.nbCellLargeur;
        float sizeY = width / this.nbCellLargeur;
        
        
    for (int i = 0; i < nbCellHauteur; i++) {
      for (int j = 0; j < nbCellLargeur; j++) {
        allCell = (Cell[]) append(allCell, new Cell(i * sizeX, j*sizeY, sizeX, sizeY, col));
      }
    }
  }
  
  void click() {
    float size = width / this.nbCellLargeur;
    int caseX = (int)((mouseX - (mouseX % size)) / size);
    
    
    
    size = height / this.nbCellHauteur;
    int caseY = (int)((mouseY - (mouseY % size)) / size);
    
    allCell[this.nbCellLargeur * caseX + caseY].alive = true;
    cellAlive = (Cell[]) append(cellAlive, allCell[this.nbCellLargeur * caseX  + caseY]);
  }
  
  void display() {
    background(255);
    stroke(0);
    strokeWeight(2);
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
