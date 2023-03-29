class Game {
  Cell [] allCell;
  Cell [] cellAlive;
  int nbCellLargeur;
  int nbCellHauteur;
  
  Game (int nbCellLargeur, int nbCellHauteur) {
    this.nbCellLargeur = nbCellLargeur;
    this.nbCellHauteur = nbCellHauteur;
    allCell = new Cell[0];
    for (int i = 0; i < nbCellLargeur; i++) {
      for (int j = 0; j < nbCellHauteur; j++) {
        println("i : " + i + "j : " + j);
        allCell = (Cell[]) append(allCell, new Cell(i * 30, i*30, 30, 30));
      }
    }
  }
  
  void display() {
    background(255);
    for (int i = 0; i < this.nbCellLargeur; i++) {
      line(i * 30, 0, i * 30, height);
    }
    
    for (int i = 0; i < this.nbCellLargeur; i++) {
      line(0, i*30, width, i*30);
    }
    
    /*for (Cell c : cellAlive) {
      c.display();
    }*/
  }
}
