// House class


class Church {
 
  float posx, posy ;
  Church(float x, float y) {
    posx = x ;
    posy = y ;
  }

  void update(float x, float y) {
    posx = x ; 
    posy = y ;
  }

  void render() {
    
    shape(church, posx, posy, 1, 1) ; //draw houses from svg
  }
}
