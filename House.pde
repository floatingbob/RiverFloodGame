// House class


class House {
  boolean flooded = false ;  
  float posx, posy ;
  House(float x, float y) {
    posx = x ;
    posy = y ;
  }

  void update(float x, float y) {
    posx = x ; 
    posy = y ;
  }

  void render() {

    shape(house, posx, posy, 1, 1) ; //draw houses from svg
  }
}

