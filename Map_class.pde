String map_to_zoom_in = "";
ArrayList<PVector> area_reference = new ArrayList<PVector>();
String cityName = "";
int[] search_index = new int[2];
float background_col = 0;

class Map {
  // there are three map_modes (integers of 0, 1, or 2)
  int map_mode;
  
  // this section with a bunch of PVectors contains the area coordinates that are going to be used for zoom identification in the major areas
  PVector NorthAmerica1 = new PVector(0, 0);
  PVector NorthAmerica2 = new PVector(300, 250);
  
  PVector Europe1 = new PVector(330, 20);
  PVector Europe2 = new PVector(550, 160);
  
  PVector SouthAmerica1 = new PVector(149, 249);
  PVector SouthAmerica2 = new PVector(318, 492);
  
  PVector Oceania1 = new PVector(712, 223);
  PVector Oceania2 = new PVector(988, 464);
  
  PVector NorthAfrica1 = new PVector(363, 162);
  PVector NorthAfrica2 = new PVector(528, 266);
  PVector FirstAfricaDiagonal1 = new PVector(521, 193);
  PVector FirstAfricaDiagonal2 = new PVector(536, 241);
  PVector SecondAfricaDiagonal1 = new PVector(536, 241);
  PVector SecondAfricaDiagonal2 = new PVector(586, 260);
  PVector SouthAfrica1 = new PVector(357,251);
  PVector SouthAfrica2 = new PVector(607,425);
  
  PVector NorthernAsia1 = new PVector(555, 56);
  PVector NorthernAsia2 = new PVector(848, 174);
  PVector SouthernHalfAsia1 = new PVector(600,174);
  PVector SouthernHalfAsia2 = new PVector(855,253);
  
  PVector MiddleEastPersianGulf1 = new PVector(545, 197);
  PVector MiddleEastPersianGulf2 = new PVector(601, 245);
  
  PVector MiddleEastMediterranean3 = new PVector(515, 170);
  PVector MiddleEastMediterranean4 = new PVector(564, 216);
  
  // A nested-array of all of the previous coordinates that have been coded into variables
  PVector[][] MajorArea_coords = {{NorthAmerica1, NorthAmerica2},
    {Europe1, Europe2}, {NorthAfrica1, NorthAfrica2}, {FirstAfricaDiagonal1, FirstAfricaDiagonal2},
    {SecondAfricaDiagonal1,SecondAfricaDiagonal2}, {SouthAfrica1, SouthAfrica2}, {Oceania1, Oceania2},
    {NorthernAsia1, NorthernAsia2}, {SouthernHalfAsia1, SouthernHalfAsia2}, {MiddleEastPersianGulf1, MiddleEastPersianGulf2},
    {MiddleEastMediterranean3, MiddleEastMediterranean4}, {SouthAmerica1, SouthAmerica2}};
  // text that has been arranged in the same order as the MajorArea_coords nested Array
  // there are duplicate entries in this string since there are duplicate entries in the MajorArea_coords nestedArray as well for certain major Areas
  // this is due to the presence of irregular shapes in some areas such as Africa, which requires more than just one pair of coordinates to prevent overlap with areas such as the Middle East
  String[] MajorAreas = {"North America", "Europe", "Africa", "Africa", "Africa", "Africa", "Oceania", "Asia", "Asia", "Middle East", "Middle East", "South America"};
  
  // for irregularly shaped areas, calculating the center is not as easy as calculating the midpoint of the x and the midpoint of the y
  // that is why one bigger area needs to be defined with two coordinates
  // overlap is not a concern here since these values are only going to be used in the Zoom() calculation
  PVector[] Africa_coords = {NorthAfrica1, SouthAfrica2};
  PVector[] Middle_East_coords = {MiddleEastMediterranean3, MiddleEastPersianGulf2};
  PVector[] Asia_coords = {NorthernAsia1, NorthernAsia2};
  
  // PVectors that are paired up to make up the checking mechanism for whether or not a certain city has been clicked or not
  PVector Montreal1 = new PVector(585, 235);
  PVector Montreal2 = new PVector(585+40, 235+40);
  PVector San_Francisco1 = new PVector(315, 285);
  PVector San_Francisco2 = new PVector(315+40, 315+40);
  PVector Paramaribo1 = new PVector(435, 0);
  PVector Paramaribo2 = new PVector(435+40, 0+40);
  PVector Santiago1 = new PVector(430, 300);
  PVector Santiago2 = new PVector(430+40, 300+40);
  PVector Paris1 = new PVector(465, 295);
  PVector Paris2 = new PVector(465+40, 295+40);
  PVector Warsaw1 = new PVector(565, 285);
  PVector Warsaw2 = new PVector(565+40, 285+40);
  PVector Beijing1 = new PVector(655, 275); 
  PVector Beijing2 = new PVector(655+40, 275+40); 
  PVector Dubai1 = new PVector(585, 235);
  PVector Dubai2 = new PVector(585+40, 235+40);
  PVector Sydney1 = new PVector(580, 350);
  PVector Sydney2 = new PVector(580+40, 350+40);
  PVector Cairo1 = new PVector(525, 0);
  PVector Cairo2 = new PVector(525 + 40, 0+40);
  PVector Johannessburg1 = new PVector(530, 375);
  PVector Johannessburg2 = new PVector(530+40, 375+40);
  
  // All of the city PVectors are combined into one nested-array; similar to the Major Areas
  PVector[][] MajorCity_coords = {{Montreal1, Montreal2}, {San_Francisco1, San_Francisco2}, {Paramaribo1, Paramaribo2}, {Santiago1, Santiago2}, {Paris1, Paris2}, {Warsaw1, Warsaw2}, {Beijing1, Beijing2}, {Dubai1, Dubai2}, {Sydney1, Sydney2}, {Cairo1, Cairo2}, {Johannessburg1, Johannessburg2}};
  String[] MajorCitiesList = {"Montreal", "San Francisco", "Paramaribo", "Santiago", "Paris", "Warsaw", "Beijing", "Dubai", "Sydney", "Cairo", "Johannessburg"};  
  
  Map(int mode_world_map) {
    // this is necessary for the displayMap() method
    this.map_mode = mode_world_map;
  }
  
  void drawGridlines() {
    // this helper function was used for aid in the design process by drawing gridlines on the screen to allow for easier development of code
    for (int grid_num = 0; grid_num < 10; grid_num++) {
      stroke(255);
      line(grid_num*100, 0, grid_num*100, 500);
    }
    for (int horizontal_line = 1; horizontal_line < 6; horizontal_line++) {
      stroke(255);
      line(0, horizontal_line*100, 1000, horizontal_line*100);
    }
  }
  
  void drawZoomOut() {
    // this draws the "Zoom Out" rectangle for any user
    fill(255, 255, 255);
    rect(10, 10, 75, 75);
    fill(0,0,0);
    textSize(25);
    text("Zoom", 15, 35);
    text("Out", 15, 75);
  }
  
  void displayMap() {
    if (this.map_mode == 0) {
      area_reference = new ArrayList<PVector>();
      // a regular map is displayed in the least zoomed out state
      background(background_col);
      //this.drawGridlines();
      world_map = loadImage("World_Map.png");
      world_map.resize(1000, 500);
      image(world_map, 0, 0);
    }
    
    else if (this.map_mode == 1) {
      cityName = "";
      // a zoomed into a certain Major Area map is displayed in the second most zoomed in state
      background(background_col);
      //this.drawGridlines();
      world_map = loadImage("World_Map.png");
      pushMatrix();
      // push and pop matrix are used for mathematical translations in processing
      //println("",area_reference[0].x);
      //println("", area_reference[0].y);
      world_map.resize(2000, 1000);
      // this calculation allows for the image centre to be the centre of the Major Area defined
      PVector[] move_map = area_reference.toArray(new PVector[2]);
      translate((1000/2 - ((move_map[0].x + move_map[1].x))), (500/2 - ((move_map[0].y + move_map[1].y))));
      image(world_map, 0, 0);
      popMatrix();
      // draws the "zoom out" tab
      this.drawZoomOut();
      
      // draws the cityLabels for every Major Area
      if (map_to_zoom_in == "North America") {
        fill(120, 100, 50);
        circle(600, 250, 40);
        textSize(35);
        text("Montreal", 500, 215);
        fill(120, 100, 50);
        circle(330, 300, 40);
        textSize(35);
        text("San Francisco", 360, 300);
      }
      else if (map_to_zoom_in == "Europe") {
        fill(120, 100, 50);
        circle(480, 310, 40);
        textSize(35);
        text("Paris", 440, 360);
        fill(120, 100, 50);
        circle(580, 300, 40);
        textSize(35);
        text("Warsaw", 610, 300);
      }
      else if (map_to_zoom_in == "Africa") {
        fill(120, 100, 50);
        circle(540, 10, 40);
        textSize(35);
        text("Cairo", 500, 60);
        fill(120, 100, 50);
        circle(545, 390, 40);
        textSize(35);
        text("Johannesburg", 460, 375);
      }
      else if (map_to_zoom_in == "Oceania") {
        fill(120, 100, 50);
        circle(595, 365, 40);
        textSize(35);
        text("Sydney", 620, 365);
      }
      else if (map_to_zoom_in == "Asia") {
        fill(120, 100, 50);
        circle(670, 290, 40);
        textSize(35);
        text("Beijing", 630, 250);
      }
      else if (map_to_zoom_in == "Middle East") {
        fill(120, 100, 50);
        circle(600, 250, 40);
        textSize(35);
        text("Dubai", 500, 215);
      }
      
      else if (map_to_zoom_in == "South America") {
        fill(120, 100, 50);
        circle(445, 315, 40);
        textSize(35);
        text("Santiago", 475, 315);
        fill(120, 100, 50);
        circle(450, 15, 40);
        textSize(35);
        text("Paramaribo", 480, 30);
      }  
    }
    
    else if (this.map_mode == 2) {
      // all that needs to be done when the map is the most zoomed in is for the "zoom out" tab to be drawn
      this.drawZoomOut();
    }
  }
  
  void ZoomMajorArea(PVector clickLocation) {
    // use a for-loop to iterate through all of the major area coordinates
    //println("this is ", clickLocation.x);
    //println("this is ", clickLocation.y);
    //println("Length: ", MajorArea_coords.length);
    for (int area_index = 0; area_index < MajorArea_coords.length; area_index++) {
      PVector coord_1 = MajorArea_coords[area_index][0];
      PVector coord_2 = MajorArea_coords[area_index][1]; 
      // if-statement is used to check two see whether a (coordinate/desired point) is within two target coordinates, which both comprise of an x and a y part
      if ((clickLocation.x > coord_1.x) && (clickLocation.x < coord_2.x) && ((clickLocation.y > coord_1.y) && (clickLocation.y < coord_2.y))) {
        map_to_zoom_in = MajorAreas[area_index];
        // as mentioned on line 55, the zoom centre needs to specifically be the middle coordinate between two points 
        if (map_to_zoom_in == "Africa") {
          area_reference.add(Africa_coords[0]);
          area_reference.add(Africa_coords[1]);
        }
        else if (map_to_zoom_in == "Middle East") {
          area_reference.add(Middle_East_coords[0]);
          area_reference.add(Middle_East_coords[1]);
        }
        else if (map_to_zoom_in == "Asia") {
          area_reference.add(Asia_coords[0]);
          area_reference.add(Asia_coords[1]);
        } 
        else {
          area_reference.add(MajorArea_coords[area_index][0]);
          area_reference.add(MajorArea_coords[area_index][1]);
        }
      }
    }
  }
  
  void ZoomMajorCity(PVector clickLocation) {
    // the goal of this method is to find the cityName out of an area that has been already picked and recorded around map_to_zoom_in 
    // at first a random number is picked that basically will just yield a skip in the entire process that is contained in the else
    if (search_index[0] == 20) {}
    else {
      // for whatever map that the program is zoomed in on, there are two indexes, or one index of MajorCitiesList() that needs to be searched
      // the index values are as such for every MajorArea:
      if (map_to_zoom_in == "North America") {
        search_index[0] = 0;
        search_index[1] = 1;
      }
      else if (map_to_zoom_in == "Europe") {
        search_index[0] = 4;
        search_index[1] = 5;
      }
      else if (map_to_zoom_in == "Africa") {
        search_index[0] = 9;
        search_index[1] = 10;
      }
      else if (map_to_zoom_in == "Oceania") {
        search_index[0] = 8;
        search_index[1] = -1;
      }
      else if (map_to_zoom_in == "Asia") {
        search_index[0] = 6;
        search_index[1] = -1;
      }
      else if (map_to_zoom_in == "Middle East") {
        search_index[0] = 7;
        search_index[1] = -1;
      }
      else if (map_to_zoom_in == "South America") {
        search_index[0] = 2;
        search_index[1] = 3;
      }
      
      // the two coordinates for determining validity of the click on a city are determined in this blocked (lines 272-275)
      PVector coord_1 = MajorCity_coords[search_index[0]][0];
      //println("coord_1: ", coord_1);
      PVector coord_2 = MajorCity_coords[search_index[0]][1];
      
      // the validity of the click is then checked here:
      if ((clickLocation.x > coord_1.x) && (clickLocation.x < coord_2.x) && ((clickLocation.y > coord_1.y) && (clickLocation.y < coord_2.y))) {
        cityName = MajorCitiesList[search_index[0]];
      }
      
      // this process is repeated for certain Major Areas that have a second positive number contained in their search_index array
      if (search_index[1] != -1) {
        PVector coord_3 = MajorCity_coords[search_index[1]][0];
        PVector coord_4 = MajorCity_coords[search_index[1]][1];  
        if ((clickLocation.x > coord_3.x) && (clickLocation.x < coord_4.x) && ((clickLocation.y > coord_3.y) && (clickLocation.y < coord_4.y))) {
          cityName = MajorCitiesList[search_index[0]+1];
        }
      }
    }
  }
}
  
  
  
  
  
  
  
  
  
