//class extension
class FancyPoint extends Point {
  float dir ;
  float speed ;
  float maxDistance ;
  float sx = 0 ;
  float sy = 0 ;


  //class FancyPoint, which uses super to generate drive of dots
  FancyPoint(float xpos, float ypos, float d) {
    super(xpos, ypos) ;
    //dir = .25*TWO_PI ;
    speed = random(0.05, 0.01) ;
    maxDistance = 75 ;
    sx = xpos ;
    sy = ypos ;
    dir = d ;
    over = true ;
  }
  void check() {
    if (dist(mouseX, mouseY, x, y) < 10 && mousePressed) {
      over = true ;
    }
    if (over == true) {

      x = x + sin(dir) * speed;
      y = y + cos(dir) * speed;
      if (x <= 0) {
        speed = 0;
      }
      if (dist(sx, sy, x, y) >= maxDistance) {
        speed = 0;
      }
    }
  }
  void reset() {
    x = sx ;
    y = sy ;
    speed = random(0.05, 0.01) ;
  }
}


// simple class to hold vertex data
class Point {

  float x, y ;
  boolean over = false ;
  Point(float xpos, float ypos) {
    x = xpos ;
    y = ypos ;
  }

  // do some mouse checking
  void check() {
    if (dist(mouseX, mouseY, x, y) < 10 && mousePressed) {
      over = true ;
    }

    if (over && !mousePressed) over = false ;

    if (over) {
      x = mouseX ;
      y = mouseY ;
    }
  }
}

