
//
//
//class Image {
//
//  float posx, posy ;
//  Image(float x, float y) {
//    posx = x ;
//    posy = y ;
//  }
//
//  void update(float x, float y) {
//    posx = x ; 
//    posy = y ;
//  }
//
//  void render() {
//
//    for (int i = 0; i < houses.length; i++) {
//    for (int j = 0; j < points.length; j++) {
//      House h = houses[i] ;
//      FancyPoint fp = points[j] ;
//      int imagePos = 0 ;
//      if (dist(h.posx, h.posy, fp.x, fp.y) < 20) {
//        image(photo, imagePos, imagePos) ;
//        println("F l o o d e d") ;
//        if (dist (pmouseX, pmouseY, imagePos, imagePos) < 70) {
//          image(largeImage, imagePos, imagePos) ;
//        }
//      }
//    }
//  }
//  }

