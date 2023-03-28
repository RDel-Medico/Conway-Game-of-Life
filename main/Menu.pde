class Menu {
  Button[] buttons;
  Text[] texts;
  
  Menu (){
    this.buttons = new Button[0];
    this.texts = new Text[0]; 
  }
  
  void addButton(Button b) {
    this.buttons = (Button[]) append(buttons, b);
  }
  
  void addText(Text t) {
    this.texts = (Text[]) append(texts, t);
  }
  
  void click () {
    for (Button b : this.buttons) {
      b.clicked();
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
  }
}
