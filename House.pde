// House class

int hwidth = 35 ;
int hheight = 50 ; 

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
    fill(255, 0, 0) ;
    noStroke() ;
    rect(posx, posy, swidth, sheight, 5) ;
  }
}


