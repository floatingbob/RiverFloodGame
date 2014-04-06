
//
// Simple FloodImage class to display image at location
// position x, y is derived from filename
// format of file name is xy.png x = x grid position, y = y grid psotion
//

class FloodImage {

  PImage img, thumb ; 
  float x, y ;
  int savedTime = millis() ; // save current time
  int totalTime = 100000 ; // timer limit 
  // brownian variables
  float xTar, yTar ;
  float speed = 0.01 ;
  int range = 2;

  // Bobbing pictures variables
  int gStep = 0;
  boolean gForwardFlag = true;
  final int kStepTime = 400;  // how fast to step
  int gLastTime = 0;

  // constructor with argument for file name

  FloodImage(String name, String dir) {

    img = loadImage(dir + name) ; // load the image
    getPosition(name) ;  // call the method to strip grid position from file name

    thumb = loadImage(dir + name) ; // load the thumbs
    getPosition(name) ;  // call the method to strip grid position
  }


  // display the image at the grid position - with multiplier for screen space
  // if a house is being flooded
  void display(float multiplierX, float multiplierY) {

      println("imageFlagged") ;
      image(thumb, x*multiplierX, y*multiplierY, 100, 100) ; 
      // establish timing for bobbing images
      int thisTime = millis();

      if (dist (pmouseX, pmouseY, x*multiplierX, y*multiplierX) < 100) {
        image(img, width/2, height/2) ;
      }



    // helpful timer http://www.learningprocessing.com/examples/chapter-10/example-10-4/
    // Calculate how much time has passed
    int passedTime = millis() - savedTime;
    // Has five seconds passed?
    if (passedTime > totalTime) {
      println( " 5 seconds have passed! " );
      background(random(255)); // Color a new background
      savedTime = millis(); // Save the current time to restart the timer!
    }
  }

  void getPosition(String val) {
    x = int(val.substring(0, 1)) ;
    y = int(val.substring(1, 2)) ;
    println(x) ;
    println(y) ;
  }
}

//void floodedHouse() {
//  for (int i = 0; i < houses.length; i++) {
//    for (int j = 0; j < points.length; j++) {
//      House h = houses[i] ;
//      FancyPoint fp = points[j] ;
//      int imagePos = 0 ;
//      if (dist(h.posx, h.posy, fp.x, fp.y) < 20) {
//        image(photo, imagePos, imagePos) ;
//        if (dist (pmouseX, pmouseY, imagePos, imagePos) < 70) {
//          image(largeImage, imagePos, imagePos) ;
//        }
//      }
//    }
//  }
//}

