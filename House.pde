// House class

int hwidth = 35 ;
int hheight = 50 ; 


class House {

  float posx, posy ;
  House(float x, float y) {
    posx = random(width) ;
    posy = random(width) ;
  }

  void update(float x, float y) {
    posx = x ; 
    posy = y ;

    // Creating a custom PShape as a square, by
    // specifying a series of vertices.
    s = createShape();
    s.beginShape();
    s.fill(0, 255, 0);
    s.noStroke();
    s.vertex(0, 50);
    s.vertex(50, 50);
    s.vertex(50, 0);
    s.endShape(CLOSE);
      
  }

  void render() {
    fill(255, 0, 0) ;
    noStroke() ;
    rect(posx, posy, hwidth, hheight, 5) ;
  }
}

