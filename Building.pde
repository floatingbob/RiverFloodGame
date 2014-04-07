// Building class


class Building {
 
  float posx, posy ;
  Building(float x, float y) {
    posx = x ;
    posy = y ;
  }

  void update(float x, float y) {
    posx = x ; 
    posy = y ;
  }

  void render() {
    
    shape(building, posx, posy, 1, 1) ; //draw building from svg
  }
}
