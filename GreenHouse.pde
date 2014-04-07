// GreenHouse class


class GreenHouse {
  boolean flooded = false ;  
  float posx, posy ;
  GreenHouse(float x, float y) {
    posx = x ;
    posy = y ;
  }

  void update(float x, float y) {
    posx = x ; 
    posy = y ;
  }

  void render() {
    
    shape(greenHouse, posx, posy, 1, 1) ; //draw houses from svg
  }
}

