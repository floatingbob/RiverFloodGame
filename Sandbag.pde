int swidth = 35 ;
int sheight = 20 ; 

class Sandbag {

  float posx, posy ;
  Sandbag(float x, float y) {
    posx = x ;
    posy = y ;
  }

  void update(float x, float y) {
    posx = x ; 
    posy = y ;
  }

  void render() {
    fill(107, 190, 79) ;
    noStroke() ;
    rect(posx, posy, swidth, sheight, 10) ;
  }
}


