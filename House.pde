// House class



class House {
 
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

  image(house, posx, posy) ; //draw houses from image
  }
}

