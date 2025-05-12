import g4p_controls.*;
PImage world_map;


Map World_Map;
City cities;
CityWeather Weather;
Thunder Thunderstorm;
int world_map_mode;

int CloudX;
int CloudY;

boolean should_Thunder = false;

int cloudDrawType;

void setup() {
  size(1000, 500);
  createGUI();
  // defines the following objects: world map, the cities, weather, and thunderstorm
  World_Map = new Map(0);
  cities = new City();
  Weather = new CityWeather(cloudDrawType);
  Thunderstorm = new Thunder();
  world_map_mode = 0; // mode that switches from 0 (world map), 1 (area map), and 2 (city map)
  // these are the coordinates that the Cloud is going to be drawn at
  CloudX = 0;
  CloudY = 0;
}

void draw() {
  Weather = new CityWeather(cloudDrawType);
  if (world_map_mode == 2) {
    // this handles any case where the map is zoomed in on the city
    if (Weather.cloudDrawType == 0) {
      // handles the case where there are no clouds
      cities.drawCity(cityName);
      Weather.drawClouds(CloudX, CloudY);
      cities.drawCityStats(cityName);
    }
    else {
      // handles the case where either cloudDrawType is 1 or 2
      cities.drawCity(cityName);
      tint(255, 120);
      Weather.drawClouds(CloudX, CloudY);
      cities.drawCityStats(cityName);
      noTint();
      if (should_Thunder == true) {
        Thunderstorm.drawThunder();
      };  
    }
    // this is the section of code that is used to animate the clouds
    CloudX += 1;
    CloudY += 1;
    if (CloudX > 300) {
      CloudX = 0;
      CloudY = 0;
    }
  }
  // this map primarily handles cases when world_map_mode == 1,  it also does other things like drawing the "zoom out" option in the top-left
  World_Map.displayMap();
  
  if (world_map_mode == 0) {
    // this presents the text that is contained on the most zoomed out screen only
    // these instructions are certainly enough to help the user take advantage of the beauty of my program
    textSize(25);
    fill(255);
    strokeWeight(0);
    stroke(255);
    rect(0, 200, 350, 325);
    rect(0, 450, 1000, 50);
    fill(0, 0, 0);
    textSize(13);
    text("This program allows the user", 10, 220);
    text("to see the day and night views", 10, 245);
    text("of a variety of cities.", 10, 270);
    text("Once a user has clicked on a", 10, 295);
    text("specific city, facts about that city will also be mentioned.", 10, 320);
    
    text("Press the letter 't' for the formation", 10, 345);
    text("of a thunderstorm under a satellite image.", 10, 370);
    text("This will work for any city.", 10, 395);
    text("Press the letter 's' to stop this thunderstorm", 10, 420);
    text("Press the letter 'c' to switch between the three cloud", 10, 442);
    text("Drawing modes", 10, 457);
    text("Click on any piece of land and you will be zoomed into the corresponding continent, with the exception of Greenland! South America is behind this white rectangle.", 10, 490);
  }
}

void mouseClicked() {
  // this handles all cases where the mouse was clicked
  PVector ClickLocation = new PVector(mouseX, mouseY);
  if (world_map_mode == 0) {
    World_Map.ZoomMajorArea(ClickLocation);
    if (area_reference.size() != 0) {
      World_Map = new Map(1);
      world_map_mode = 1;
    }
  }
  else if (world_map_mode == 1) {
    // the first if is to check if "zoom out" was selected
    if (((ClickLocation.x > 10) && (ClickLocation.x < 75)) && ((ClickLocation.y > 10) && (ClickLocation.y < 75))) {
      World_Map = new Map(0);
      world_map_mode = 0;
    }
    else {
      // this case is to check if a certain city has been clicked on
      World_Map.ZoomMajorCity(ClickLocation);
      // if there has been a city name identified, then a zooming-in needs to occur
      // the rest of this "else" branch is dedicated to just that
      if (cityName.length() != 0) {
        World_Map = new Map(2);
        world_map_mode = 2;
        //println("we entered here");
      }
    }
  }
  else if (world_map_mode == 2) {
    // the first if is to check if "zoom out" was selected
    if (((ClickLocation.x > 10) && (ClickLocation.x < 75)) && ((ClickLocation.y > 10) && (ClickLocation.y < 75))) {
      World_Map = new Map(1);
      world_map_mode = 1;
    }
    // no further zooming can be done
  }
}

void keyPressed() {
  // this procedure handles all cases where a key is pressed
  if (key == 't' && (world_map_mode == 2)) {
    // starts thunderstorm
    should_Thunder = true;
  }
  if (key == 's' && (world_map_mode == 2)) {
    // stops thunderstorm
    should_Thunder = false;
  }
  if (key == 'c') {
    // switches between cloudDrawType
    if (cloudDrawType != 2) {
      cloudDrawType += 1;
      println(cloudDrawType);
    }
    else if (cloudDrawType == 2) {
      cloudDrawType = 0;
    }
  }
}
