class Application {
  Menu[] app;
  Menu currentMenu;
  
  Application(Menu m) {
    this.app = new Menu[0];
    this.currentMenu = m;
  }
  
  void changeMenu(Menu m) {
    this.currentMenu = m;
  }
  
  void addMenu(Menu m) {
    this.app = (Menu[]) append(app, m);
  }
  
  void display() {
    currentMenu.display(); 
  }
  
  void click() {
    this.currentMenu.click();
  }
  
  int release() {
    return this.currentMenu.release();
  }
}
