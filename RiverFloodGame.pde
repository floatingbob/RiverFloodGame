//Robert Werner
//floatingbob@icloud.com
//--------------------------------------------------------

//----Arrays--
FancyPoint[] points ; // an array for all the points in the svg
House[] houses = new House[25] ; // an array list of houses
ArrayList sandbags ; // array of sandbags
//------------

PImage photo, largeImage ;
PShape s; // svg shape 
float bx, by, bsx, bsy, rx, ry ; // button variables
boolean flag = false ; // test to see if we are pressed or free to make another
boolean resetFlag = false ;
int r = 10 ; //radius of rectangles
int grey = 200 ;
int black = 0 ;
int white = 255 ;

void setup() {
  photo = loadImage("floodThumb.png") ;
  largeImage = loadImage("floodLarge.png") ; 
  background(0) ;
  size(1080, 768) ;
  smooth() ;
  rectMode(CENTER) ;
  textAlign(CENTER) ;
  //------Arrays----
  sandbags = new ArrayList() ; // generate sandbag array list

    //----------------
  bx = 100 ; //Button X start coordinate
  by = 100 ; //Button Y start coordinate 
  bsx = 75 ; // Button width (sandbags)
  bsy = 35 ; // button height (sandbags)
  rx = bx + 200 ; //reset button x start
  ry = by ; //reset button y start

  // The file "bot.svg" must be in the data folder
  // a single shape svg
  // we just want the verticies, so the first child 
  s = loadShape("riverSVG.svg").getChild(0);
  // init the array with as many elements as points
  points = new FancyPoint[s.getVertexCount()] ;
  // get all the verticies from the svg shape
  // and init the points objects with those coords
  for (int i=0; i<s.getVertexCount() ; i++) {
    PVector v = s.getVertex(i) ;
    if (i <= s.getVertexCount()/2) {
      points[i] = new FancyPoint(v.x, v.y, .55*TWO_PI) ;
    } 
    else {
      points[i] = new FancyPoint(v.x, v.y, .0*TWO_PI) ;
    }
    if ( i > 322 && i < 365) {
      points[i].dir = .55*TWO_PI ;
    }
  }

  // Init array of houses
  for (int j = 0; j < houses.length; j ++) {
    float rad = random(75, 150) ;
    int r = (int) random(points.length) ;
    FancyPoint p = points[r] ;
    houses[j] = new House(p.sx + sin(p.dir) * rad, p.sy + cos(p.dir) * rad) ;
  }
}

void draw() {
  background(240, 240, 240);
  //Sandbag generation button

  noStroke() ;
  setFloodplane() ;
  floodedHouse() ;
  // flood reset button

  //button
  fill(grey) ;
  rect(rx, ry, bsx, bsy, r) ;
  fill(black) ;
  text("Reset", rx, ry) ;

  // Sandbag select button
  fill(grey) ;
  rect(bx, by, bsx, bsy, r) ;
  fill(black) ;
  text("Sandbags", bx, by) ;


  if (flag==true) {
    Sandbag s = (Sandbag) sandbags.get(sandbags.size()-1) ;
    s.update(mouseX, mouseY) ;
  }

  // Draw out houses
  for (int l=0; l<houses.length ; l++) {
    House h = houses[l] ;
    h.render() ;
  }


  // Draw out sandbags
  for (int i = 0; i < sandbags.size(); i++) {
    Sandbag s = (Sandbag) sandbags.get(i) ;  // get the ith Sandbag element from the list 
    s.render() ;
  }




  // go through the points array and draw a curveVertex shape at the points location
  beginShape() ;
  for (int i=0; i<points.length ; i++) {
    FancyPoint p = points[i] ;
    p.check() ;
    fill(5, 255, 211);
    //    ellipse(p.x, p.y, 10, 10) ; //ellipse at points

    curveVertex(p.x, p.y) ;
    fill(75, 75, 75);
    text(i, p.x, p.y);
  }
  fill(0, 0, 255, 55) ;
  endShape() ;
  stopFlood() ;
  reset() ;
}

void mousePressed() {
  if (dist(mouseX, mouseY, bx, by) <= bsx && flag==false) {
    flag = true ;
    sandbags.add(new Sandbag(bx, by)) ;
    println(sandbags.size()) ;
  }
}

void reset() {
}

void mouseReleased() {

  flag = false ;
  for (int k = 0; k < points.length; k++) {
    FancyPoint fp = points[k] ;
    if (dist(mouseX, mouseY, rx, ry) <= bsx) {
      println("R E S E T") ;
      fp.reset() ;
    }
  }
}
void stopFlood() {
  for (int i = 0; i < sandbags.size(); i++) {
    for (int j = 0; j < points.length; j++) {
      Sandbag b = (Sandbag)sandbags.get(i) ;
      FancyPoint fp = points[j] ;
      if (dist(b.posx, b.posy, fp.x, fp.y) < 20) {
        fp.speed = 0;
      }
    }
  }
}
void floodedHouse() {
  for (int i = 0; i < houses.length; i++) {
    for (int j = 0; j < points.length; j++) {
      House h = houses[i] ;
      FancyPoint fp = points[j] ;
      int imagePos = 0 ;
      if (dist(h.posx, h.posy, fp.x, fp.y) < 20) {
        image(photo, imagePos, imagePos) ;
        println("F l o o d e d") ;
        if (dist (pmouseX, pmouseY, imagePos, imagePos) < 70) {
          image(largeImage, imagePos, imagePos) ;
        }
      }
    }
  }
}
void setFloodplane() {
  for (int i = 0; i < points.length; i++) {
        if ( i > 1 && i < 70) {
          points[i].dir = .55*TWO_PI ;
          points[i].maxDistance = 20 ;
        }
  }
}

