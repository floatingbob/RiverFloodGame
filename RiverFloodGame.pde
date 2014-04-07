//Robert Werner
//floatingbob@icloud.com
//--------------------------------------------------------

//----Arrays--
FancyPoint[] points ; // an array for all the points in the svg
ArrayList houses, greenHouses ; // an array list of houses
ArrayList sandbags ; // array of sandbags
ArrayList floodImages ; // an array list for the image objects to load into
ArrayList floodThumbs ; // an array list for my image thumb objects
ArrayList churches ;
ArrayList buildings ; 

//------------
float posMultiplierX, posMultiplierY ; // multipliers for positioning in a flexible way
// the grid we want on the the screen
float gridSizeX = 10 ;
float gridSizeY = 8 ;
PShape riverIsometric, house, church, building, greenHouse ; 
PShape s; // svg shape 
float bx, by, bsx, bsy, rx, ry ; // button variables
boolean flag = false ; // test to see if we are pressed or free to make another
boolean resetFlag = false ;
int r = 5 ; //radius of rectangles
int grey = 200 ;
int black = 0 ;
int white = 255 ;
boolean imageFlag = false ; 

void setup() {

  riverIsometric = loadShape("riverSVG_Isometric.svg") ;
  house = loadShape("house.svg") ;
  church = loadShape("church.svg") ;
  building = loadShape("building.svg") ;
  greenHouse = loadShape("greenHouse.svg") ; 
  
    background(0) ;
    size(1080, 768) ;
    smooth() ;
    rectMode(CENTER) ;
    textAlign(CENTER) ;
    imageMode(CENTER) ;
    //------Arrays----
    sandbags = new ArrayList() ; // generate sandbag array list
    houses = new ArrayList() ; // house array list
    churches = new ArrayList() ; // new array for churches
    buildings = new ArrayList() ; //new array of buildings
    greenHouses = new ArrayList() ; 
    
    //----------------
    rx = 1000 ; //reset button x start
    ry = 30 ; //reset button y start
    bx = rx - 175 ; //Button X start coordinate
    by = ry ; //Button Y start coordinate 
    bsx = 75 ; // Button width (sandbags)
    bsy = 35 ; // button height (sandbags)
  
  
  
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
  
    // calculate the multiplers after size() relative to the grid
    posMultiplierX = width/gridSizeX ;
    posMultiplierY = height/gridSizeY ;
  
    floodImages = new ArrayList() ; // new array list
    String[] images = getImages();  // call the function to get all the images
  
      // go through the array of names and create a object into the array list
    for (int i =0 ; i< images.length; i++) {
      floodImages.add(new FloodImage(images[i], "floodImages/")) ;
    }
  
    floodThumbs = new ArrayList() ; // new array list for thumbs
    String[] thumbs = getThumbs() ;  // call the function to get images
  
      // go through the array of names and create a object into the array list
    for (int i =0 ; i< thumbs.length; i++) {
      floodImages.add(new FloodImage(images[i], "floodImages/thumbs")) ;
    }
  
    setFloodplane() ;
    background(240, 240, 240);
  }
  
  void draw() {
  
    //Sandbag generation button
    float marlinRando75_200 = random(75, 200) ;
  
    shape(riverIsometric, 0, 0, 1080, 768) ; //draw background map image
  
    noStroke() ;
    //floodedHouse() ;
    // flood reset button
  
    // top menu
  
  
    //Reset button
    fill(247, 147, 29) ;
    rect(rx, ry, bsx, bsy, r) ;
    fill(255, 255, 255) ;
    text("Reset", rx, ry + 3) ;
  
    // Sandbag select button
    fill(107, 190, 79) ;
    rect(bx, by, bsx, bsy, r) ;
    fill(255, 255, 255) ;
    text("Sandbags", bx, by + 3) ;
  
  
    if (flag==true) {
      Sandbag s = (Sandbag) sandbags.get(sandbags.size()-1) ;
      s.update(mouseX, mouseY) ;
    }
  
    // Draw out houses
    for (int l=0; l<houses.size() ; l++) {
      House h = (House)houses.get(l) ;
      h.render() ;
    }
    // Draw out churches
    for (int i=0; i<churches.size() ; i++) {
      Church c = (Church)churches.get(i) ;
      c.render() ;
    }
    // Draw out buildings
    for (int l=0; l<buildings.size() ; l++) {
      Building b = (Building)buildings.get(l) ;
      b.render() ;
    }
    // Draw out greenHouses
    for (int l=0; l<greenHouses.size() ; l++) {
      GreenHouse g = (GreenHouse)greenHouses.get(l) ;
      g.render() ;
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
  
      //    ellipse(p.x, p.y, 10, 10) ; //ellipse at points
  
      curveVertex(p.x, p.y) ;
      //fill(75, 75, 75);
      //text(i, p.x, p.y);
    }
    fill(99, 201, 219, 200) ;
    endShape() ;
  
    stopFlood() ;
  
    // go through the array list and display, using multiplier to position
    for (int i = 0; i < floodImages.size(); i++) 
    {
      FancyPoint fp = points[i] ;
      House h = (House) houses.get(i) ;
  
      if (dist(h.posx, h.posy, fp.x, fp.y) < 30) {
  
        //if (imageFlag == true) {
        FloodImage fl = (FloodImage)floodImages.get(i) ; // get a pointer to the array list instance
        fl.display(posMultiplierX, posMultiplierY) ; //display it
  
        //}
      }
    }
    //  floodedHouse() ;
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
  
  
  // method to plot houses within the specific start and end points of the flood creep
  void plotHouses(int start, int end, int num) {
  
    for (int i = 0; i < num; i ++) {
      int r = (int) random(start, end) ; 
      FancyPoint p = points[r] ;
      float rad = p.maxDistance ; 
      houses.add(new House(p.sx + sin(p.dir) * rad, p.sy + cos(p.dir) * rad)) ;
    }
  }
  // method to plot houses within the specific start and end points of the flood creep
  void plotHouses(int start, int end, int num, float dist) {
  
    for (int i = 0; i < num; i ++) {
      int r = (int) random(start, end) ; 
      FancyPoint p = points[r] ;
      float rad = dist ; 
      houses.add(new House(p.sx + sin(p.dir) * rad, p.sy + cos(p.dir) * rad)) ;
    }
  }
  void plotChurches(int start, int end, int num, float dist) {
  
    for (int i = 0; i < num; i ++) {
      int r = (int) random(start, end) ; 
      FancyPoint p = points[r] ;
      float rad = dist ; 
      churches.add(new Church(p.sx + sin(p.dir) * rad, p.sy + cos(p.dir) * rad)) ;
    }
  }
  void plotBuildings(int start, int end, int num, float dist) {
  
    for (int i = 0; i < num; i ++) {
      int r = (int) random(start, end) ; 
      FancyPoint p = points[r] ;
      float rad = dist ; 
      buildings.add(new Building(p.sx + sin(p.dir) * rad, p.sy + cos(p.dir) * rad)) ;
    }
  }
  // method to plot houses within the specific start and end points of the flood creep
  void plotGreenHouses(int start, int end, int num, float dist) {
  
    for (int i = 0; i < num; i ++) {
      int r = (int) random(start, end) ; 
      FancyPoint p = points[r] ;
      float rad = dist ; 
      greenHouses.add(new GreenHouse(p.sx + sin(p.dir) * rad, p.sy + cos(p.dir) * rad)) ;
    }
  }
  void setFloodplane() {
  
    //  Init array of houses randomly along my points array
    //  for (int j = 0; j < houses.length; j ++) {
    //    float rad = random(200, 300) ; //sets distance of houses from the edge of the river
    //    int r = (int) random(points.length) ;
    //    FancyPoint p = points[r] ;
    //    houses[j] = new House(p.sx + sin(p.dir) * rad, p.sy + cos(p.dir) * rad) ;
    //  }
  
    // Vancouver & Burnaby
    int start = 12 ;
    int end = 69 ;
    for (int i = 0; i < points.length; i++) {
  
      if ( i >= start && i <= end) {
        points[i].dir = .55*TWO_PI ;
        points[i].maxDistance = 0 ;
      }
    }
    plotHouses(start, end, 5, 75) ;
    plotHouses(start, end, 5, 100) ;
    plotHouses(start, end, 5, 200) ;
    plotHouses(start, end, 5, 150) ;
    plotChurches(start, end, 1, 100) ;
    plotBuildings(start, end, 1, 100) ; 
    plotGreenHouses(start, end, 1, 100) ; 
  
    start = 70 ;
    end = 77 ;
    for (int i = 0; i < points.length; i++) {
  
      if ( i >= start && i <= end) {
        points[i].dir = .55*TWO_PI ;
        points[i].maxDistance = 50 ;
      }
    }
    plotHouses(start, end, 5, 75) ;
    plotHouses(start, end, 5, 50) ;
    plotBuildings(start, end, 1, 100) ;
   plotGreenHouses(start, end, 1, 100) ; 
  
  
    // New West area
    start = 78 ; 
    end = 144 ;
    for (int i = 0; i < points.length; i++) {
  
  
      if ( i >= start && i <= end) {
        points[i].dir = .55*TWO_PI ;
        points[i].maxDistance = 120 ;
      }
    }
    plotHouses(start, end, 3, 100) ;
    plotHouses(start, end, 5, 75) ;
    plotHouses(start, end, 5, 100) ;
    plotHouses(start, end, 5, 200) ;
    plotHouses(start, end, 1, 150) ;
    plotBuildings(start, end, 1, 100) ;
   plotGreenHouses(start, end, 1, 100) ; 
  
  
    //
    start = 135 ; 
    end = 175 ; 
  
    for (int i = 0; i < points.length; i++) {
      if ( i >= start && i <= end) {
        points[i].dir = .2*TWO_PI ;
        points[i].maxDistance = 60 ;
      }
    }
    plotHouses(start, end, 3, 50) ;
    plotGreenHouses(start, end, 4, 100) ;
  
    start = 176 ; 
    end = 185 ;
  
    for (int i = 0; i < points.length; i++) {
      if ( i >= start && i <= end) {
        points[i].dir = .3*TWO_PI ;
        points[i].maxDistance = 90 ;
      }
    }
    plotHouses(start, end, 3, 50) ;
   plotGreenHouses(start, end, 1, 100) ; 
    plotChurches(start, end, 1, 100) ;
    plotBuildings(start, end, 1, 100) ; 
  
    start = 185 ;
    end = 192 ; 
  
    for (int i = 0; i < points.length; i++) {
      if ( i >= start && i <= end) {
        points[i].dir = .55*TWO_PI ;
        points[i].maxDistance = 5 ;
      }
    }
    //plotHouses(start, end, 15) ; 
    plotGreenHouses(start, end, 1, 100) ;
  
    start = 222 ;
    end = 249 ; 
    for (int i = 0; i < points.length; i++) {
      if ( i >= start && i <= end) {
        points[i].dir = .0*TWO_PI ;
        points[i].maxDistance = 100 ;
      }
    }
    plotHouses(start, end, 5, 100) ;
    plotHouses(start, end, 5, 150) ;
    plotHouses(start, end, 5, 250) ;
    plotHouses(start, end, 2, 300) ;
  
    start = 250 ; 
    end = 255 ; 
    for (int i = 0; i < points.length; i++) {
      if ( i >= start && i <= end) {
        points[i].dir = .0*TWO_PI ;
        points[i].maxDistance = 0 ;
      }
    } 
    start = 256 ; 
    end = 320 ; 
    for (int i = 0; i < points.length; i++) {
      if ( i >= start && i <= end) {
        points[i].dir = -.1*TWO_PI ;
        points[i].maxDistance = 100 ;
      }
    }
    plotHouses(start, end, 8, 25) ;
    plotHouses(start, end, 2, 75) ;
    plotHouses(start, end, 5, 80) ;
    plotHouses(start, end, 3, 90) ;
    plotHouses(start, end, 5, 75) ;
    plotHouses(start, end, 5, random(50, 100)) ;
    plotChurches(start, end, 1, 100) ;
    plotBuildings(start, end, 1, 100) ; 
  
  
    start = 381 ; 
    end = 403 ; 
    for (int i = 0; i < points.length; i++) {
      if ( i >= start && i <= end) {
        points[i].dir = .0*TWO_PI ;
        points[i].maxDistance = 100 ;
      }
    }
    plotHouses(start, end, 8, 50) ;
    plotHouses(start, end, 2, 75) ;
    plotBuildings(start, end, 1, 100) ; 
  
  
    start = 323 ; 
    end = 355 ; 
    for (int i = 0; i < points.length; i++) {
      if ( i >= start && i <= end) {
        points[i].dir = .5*TWO_PI ;
        points[i].maxDistance = 140 ;
      }
    }
    plotHouses(start, end, 4, 25) ;
    plotChurches(start, end, 1, 100) ;
    plotBuildings(start, end, 1, 100) ; 
  
  
  
  
    start = 356 ; 
    end = 363 ; 
    for (int i = 0; i < points.length; i++) {
      if ( i >= start && i <= end) {
        points[i].dir = .5*TWO_PI ;
        points[i].maxDistance = 30 ;
      }
    }
  
    start = 364 ; 
    end = 370 ; 
    for (int i = 0; i < points.length; i++) {
      if ( i >= start && i <= end) {
        points[i].dir = -.1*TWO_PI ;
        points[i].maxDistance = 30 ;
      }
    }
  
    start = 370 ; 
    end = 403 ; 
    for (int i = 0; i < points.length; i++) {
      if ( i >= start && i <= end) {
        points[i].dir = -.1*TWO_PI ;
        points[i].maxDistance = 100 ;
      }
    }
  
  
    start = 404 ; 
    end = 421 ; 
    for (int i = 0; i < points.length; i++) {
      if ( i >= start && i <= end) {
        points[i].dir = -.4*TWO_PI ;
        points[i].maxDistance = 100 ;
      }
    }
  
    start = 422 ; 
    end = 432 ; 
    for (int i = 0; i < points.length; i++) {
      if ( i >= start && i <= end) {
        points[i].dir = -.2*TWO_PI ;
        points[i].maxDistance = 100 ;
      }
    }
  }
  
  
  String[] getImages() {
    // we'll have a look in the data folder
    java.io.File folder = new java.io.File(dataPath("floodImages/"));

  // let's set a filter (which returns true if file's extension is .png)
  java.io.FilenameFilter pngFilter = new java.io.FilenameFilter() {
    public boolean accept(File dir, String name) {
      return name.toLowerCase().endsWith(".png");
    }
  };

  // list the files in the data folder, passing the filter as parameter
  String[] filenames = folder.list(pngFilter);

  // get and display the number of png files
  println(filenames.length + " png files in specified directory");

  // display the filenames
  for (int i = 0; i < filenames.length; i++) {
    println(filenames[i]);
  }

  return filenames ;
}
String[] getThumbs() {
  // we'll have a look in the data folder
  java.io.File folder = new java.io.File(dataPath("floodImages/thumbs/"));

  // let's set a filter (which returns true if file's extension is .png)
  java.io.FilenameFilter pngFilter = new java.io.FilenameFilter() {
    public boolean accept(File dir, String name) {
      return name.toLowerCase().endsWith(".png");
    }
  };

  // list the files in the data folder, passing the filter as parameter
  String[] filenames = folder.list(pngFilter);

  // get and display the number of png files
  println(filenames.length + " png files in specified directory");

  // display the filenames
  for (int i = 0; i < filenames.length; i++) {
    println(filenames[i]);
  }

  return filenames ;
}

