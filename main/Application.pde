class Application {
  Menu[] app;
  Menu currentMenu;
  
  Application(Menu m) {
    this.app = new Menu[0];
    this.addMenu(m);
    this.currentMenu = m;
  }
  
  void changeMenu(int m) {
    this.currentMenu = this.app[m];
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
  
  void dragged() {
    this.currentMenu.dragged();
  }
  
  int release() {
    return this.currentMenu.release();
  }
}
