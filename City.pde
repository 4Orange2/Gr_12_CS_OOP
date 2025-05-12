
class City {
  String cityName;
  String[] CityStats;
  
  City() {
  }
  PImage city_map;
  void drawCity(String cityName) {
    
    // draws the city to cover the entire screen depending on the cityName given to the method
    
    background(0);
    if (cityName == "Montreal") {
      city_map = loadImage("Montreal_Image.jpg");
    }
    else if (cityName == "San Francisco") {
      city_map = loadImage("San_Francisco_At_Night.jpg");
    }
    else if (cityName == "Paramaribo") {
      city_map = loadImage("Paramaribo_Earth_At_Night.jpg");
    }
    else if (cityName == "Santiago") {
      city_map = loadImage("Santiago_At_Night.jpg");
    }
    else if (cityName == "Paris") {
      city_map = loadImage("Paris_At_Night.jpg");
    }
    else if (cityName == "Warsaw") {
      city_map = loadImage("Warsaw_At_Night_ESA.jpg");
    }
    else if (cityName == "Beijing") {
      city_map = loadImage("Beijing_Image.jpg");      
    }
    else if (cityName == "Dubai") {
      city_map = loadImage("Dubai_At_Night.jpg");
    }
    else if (cityName == "Sydney") {
      city_map = loadImage("Australia_and_sydney_night.jpg");
    }
    else if (cityName == "Cairo") {
      city_map = loadImage("Cairo_At_Night.jpg");
    }
    else if (cityName == "Johannessburg") {
      city_map = loadImage("Johannessburg_And_Pretoria.jpg");
    }
    city_map.resize(1000, 500);
    image(city_map, 0, 0);
  }
  
  void drawCityStats(String cityName) {
    
    // portrays the city statistics to the bottom-left of any city depiction portrayed on the screen
    
    if (cityName == "Montreal") {
      fill(255, 255, 255);
      rect(20,315, 320, 100);
      textSize(20);
      fill(120, 120, 120);
      text("Montreal is built on the", 25, 350);
      text("'Saint-Lawrence' River", 25, 400);
    }
    else if (cityName == "San Francisco") {
      fill(255, 255, 255);
      rect(20,315, 320, 100);
      textSize(20);
      fill(120, 120, 120);
      text("San Francisco contains the infamous", 25, 350);
      text("'Golden Gate Bridge' in its proximity", 25, 400);
    }
    else if (cityName == "Paramaribo") {
      fill(255, 255, 255);
      rect(20,315, 320, 100);
      textSize(20);
      fill(120, 120, 120);
      text("Paramaribo is the capital of ", 25, 350);
      text("Suriname", 25, 400);
    }
    else if (cityName == "Santiago") {
      fill(255, 255, 255);
      rect(20,315, 320, 100);
      textSize(20);
      fill(120, 120, 120);
      text("Santiago is the capital of ", 25, 350);
      text("Chile", 25, 400);
    }
    else if (cityName == "Paris") {
      fill(255, 255, 255);
      rect(20,315, 320, 100);
      textSize(20);
      fill(120, 120, 120);
      text("Paris contains the Eiffel ", 25, 350);
      text("Tower", 25, 400);
    }
    else if (cityName == "Warsaw") {
      fill(255, 255, 255);
      rect(20,315, 320, 100);
      textSize(20);
      fill(120, 120, 120);
      text("Warsaw is the capital of ", 25, 350);
      text("Poland", 25, 400);
    }
      else if (cityName == "Beijing") {
      fill(255, 255, 255);
      rect(20,315, 370, 100);
      textSize(20);
      fill(120, 120, 120);
      text("Beijing is the capital of China and", 25, 350);
      text("the fourth most populous city in the world", 25, 400);
    }
    else if (cityName == "Cairo") {
      fill(255, 255, 255);
      rect(20,315, 320, 100);
      textSize(20);
      fill(120, 120, 120);
      text("Cairo is the capital of ", 25, 350);
      text("Egypt", 25, 400);
    }
    else if (cityName == "Dubai") {
      fill(255, 255, 255);
      rect(20,315, 340, 100);
      textSize(20);
      fill(120, 120, 120);
      text("Dubai has polluted air due to ", 25, 350);
      text("large amounts of oil and gas extraction", 25, 400);
    }
    else if (cityName == "Johannessburg") {
      fill(255, 255, 255);
      rect(20,315, 320, 100);
      textSize(20);
      fill(120, 120, 120);
      text("Johannessburg is the most populous", 25, 350);
      text("city in South Africa", 25, 400);
    }
    else if (cityName == "Sydney") {
      fill(255, 255, 255);
      rect(20,315, 320, 100);
      textSize(20);
      fill(120, 120, 120);
      text("Sydney is NOT the capital of ", 25, 350);
      text("Australia", 25, 400);
    }
  }
}
