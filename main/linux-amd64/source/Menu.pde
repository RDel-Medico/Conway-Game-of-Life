
/*
This class represent a menu of an application
 */
class Menu {
  Button[] buttons; // Represent all the buttons of the menu
  Text[] texts; // Represent all the texts of the menu
  Cursor[] cursors; // Represent all the cursors of the menu

  Menu () {
    this.buttons = new Button[0];
    this.texts = new Text[0];
    this.cursors = new Cursor[0];
  }

  /*
  Add a button to the menu
   */
  void addButton(Button b) {
    this.buttons = (Button[]) append(buttons, b);
  }

  /*
  Add a text to the menu
   */
  void addText(Text t) {
    this.texts = (Text[]) append(texts, t);
  }

  /*
  Add a cursor to the menu
   */
  void addCursor(Cursor c) {
    this.cursors = (Cursor[]) append(cursors, c);
  }
  /*
  Manage a click (by checking every button)
   */
  void click () {
    for (Button b : this.buttons) {
      b.clicked();
    }
  }

  /*
  Manage a mouseDrag by checking every cursor
   */
  void dragged() {
    for (Cursor c : this.cursors) { // foreach cursors

      if (c.selectorClicked()) { // if the currentCursor is clicked

        if (mouseX > c.posX - c.largeur / 2 && mouseX < c.posX + c.largeur / 2) { // If mouse is on the range of the bar

          float actualLargeur = (mouseX - (c.posX - c.largeur / 2));

          // Update value
          c.valuePourcent = ((actualLargeur * 100) / c.largeur ) / 100;
          c.updateValue();
        } else if (mouseX > c.posX - c.largeur / 2) { // if the mouse is on the right of the bar

          c.valuePourcent = 1;
        } else { // if the mouse is on the left of the bar

          c.valuePourcent = 0;
        }
      }
    }
  }

  /*
  Manage a mouse releasement (return the index of the button on wich the cursor was released or -1 if the mouse is not on a button)
   */
  int release () {
    int index = 0;
    for (Button b : this.buttons) {
      if (b.released()) {
        return index;
      }
      index++;
    }
    return -1;
  }

  /*
  Display all the buttons of this menu
   */
  void displayButtons() {
    for (Button b : this.buttons) {
      b.display();
    }
  }

  /*
  Display all the texts of this menu
   */
  void displayTexts() {
    for (Text t : this.texts) {
      t.display();
    }
  }

  /*
  Display all the cursors of this menu
   */
  void displayCursors() {
    for (Cursor c : this.cursors) {
      c.display();
    }
  }

  /*
  Display the whole menu
   */
  void display() {
    displayButtons();
    displayTexts();
    displayCursors();
  }
}
