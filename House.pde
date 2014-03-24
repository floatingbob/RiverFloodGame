// House class

int hwidth = 35 ;
int hheight = 40 ; 



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
//    fill(255, 0, 0) ;
//    noStroke() ;
//    rect(posx, posy, hwidth, hheight, 5) ;
//    fill(0, 255, 0) ;
//    triangle(posx - hwidth/2, posy-hheight/2, 
//    posx - hwidth/2 + hwidth/2, posy - hheight/2 - 20,
//    posx - hwidth/2 + hwidth, posy - hheight/2); 
  image(house, posx, posy) ; //draw background map image
  }
}

