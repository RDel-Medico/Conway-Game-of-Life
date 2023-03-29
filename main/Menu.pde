class Menu {
  Button[] buttons;
  Text[] texts;
  Cursor[] cursors;
  
  Menu (){
    this.buttons = new Button[0];
    this.texts = new Text[0]; 
    this.cursors = new Cursor[0]; 
  }
  
  void addButton(Button b) {
    this.buttons = (Button[]) append(buttons, b);
  }
  
  void addText(Text t) {
    this.texts = (Text[]) append(texts, t);
  }
  
  void addCursor(Cursor c) {
    this.cursors = (Cursor[]) append(cursors, c);
  }
  
  void click () {
    for (Button b : this.buttons) {
      b.clicked();
    }
  }
  
  void dragged() {
    for (Cursor c : this.cursors) {
      if (c.selectorClicked()) {
        if (mouseX > c.posX - c.largeur / 2 && mouseX < c.posX + c.largeur / 2) { // If cursor on the bar
      
          float largeur = c.largeur;
          float actualLargeur = (mouseX - (c.posX - c.largeur / 2));
          c.valuePourcent = ((actualLargeur * 100) / largeur ) / 100;
          
        } else if (mouseX > c.posX - c.largeur / 2) { // If 
          c.valuePourcent = 1;
        } else {
          c.valuePourcent = 0;
        } 
      }
    }
  }
  
  int release () {
    int index = 0;
    for (Button b : this.buttons) {
      if (b.released()){
        return index;
      }
      index++;
    }
    return -1;
  }
  
  void display() {
    for (Button b : this.buttons) {
      b.display();
    }
    
    for (Text t : this.texts) {
      t.display();
    }
    
    for (Cursor c : this.cursors) {
      c.display();
    }
  }
}
