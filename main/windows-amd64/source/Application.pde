/*
This class manage an app (All the menu)
 */
class Application {
  Menu[] app; // All the men of the app
  Menu currentMenu; // The current menu we are on

  Application(Menu m) {
    this.app = new Menu[0];
    this.addMenu(m);
    this.currentMenu = m;
  }

  /*
  Change the current menu to the menu m
   */
  void changeMenu(int m) {
    this.currentMenu = this.app[m];
  }

  /*
  Add a menu to the list of menu of the app
   */
  void addMenu(Menu m) {
    this.app = (Menu[]) append(app, m);
  }

  /*
  Display the current menu
   */
  void display() {
    currentMenu.display();
  }

  /*
  Manage a click on the current menu
   */
  void click() {
    this.currentMenu.click();
  }

  /*
  Manage a mouse drag on the current menu
   */
  void dragged() {
    this.currentMenu.dragged();
  }
  /*
  Manage a click release on the currentMenu
   Return the index of the button clicked on the current menu or -1 if no button clicked
   */
  int release() {
    return this.currentMenu.release();
  }
}
