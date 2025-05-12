class CityWeather {
  // there are three "cloudDrawType"s that are defined by the users key choices
  int cloudDrawType;
  
  CityWeather(int cloudDrawType) {
    this.cloudDrawType = cloudDrawType;
  }
  
  // cloud_haze is an image that has been uploaded from the Internet
  PImage cloud_haze;
  
  void drawClouds(int cloudX, int cloudY) {
    if (this.cloudDrawType == 0) {
      // no clouds
    }
    else if (this.cloudDrawType == 1) {
      cloud_haze = loadImage("Cloud_Wikimedia.png");
      cloud_haze.resize(1000, 500);
      image(cloud_haze, cloudX, cloudY);
    }
    else if (this.cloudDrawType == 2) {
      // in this cloudDrawType, the cloud is shifted to the right of the screen due to the resize() function
      cloud_haze = loadImage("Cloud_Wikimedia.png");
      
      // two draw types of cloud_haze are formed due to the resize() function
      cloud_haze.resize(3000, 500);
      image(cloud_haze, cloudX, cloudY);
    }
  }
}
