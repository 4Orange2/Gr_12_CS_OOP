class Plant {
  PVector pos;
  float diameter, radius;
  
  Plant(float x, float y) {
    this.pos = new PVector(x, y);
    this.diameter = 50;
    this.radius = this.diameter/2;
  }
  
  void drawMe() {
    if( this.diameter > 0 ) {
      fill(0, 100, 50); noStroke();
      circle(this.pos.x, this.pos.y, this.diameter);
    }
  }
}

class Fox {
  //FIELDS
  String name;
  PVector pos, vel;
  float hunger, thirst;
  float speed, size, sightRadius;
  boolean alive, eating, spottedRabbit;
  color furColour;
  
  
  //CONSTRUCTOR
  Fox(String n, float sp, float sr, float nerv) {
    this.name = n;
    this.furColour = foxFur;
    this.speed = sp;
    this.sightRadius = sr;
    this.pos = new PVector( random(0.2*width, 0.8*width), random(0.2*height, 0.8*height) ); 
    this.alive = true;
    this.spottedRabbit = false;
    this.eating = false;
    this.size = 35;  
    this.pickRandDirection();
  }
  //METHODS
  void drawMe() {
   
    fill(this.furColour);
    noStroke();
    square( this.pos.x, this.pos.y, this.size );
    
    noFill();
    stroke(0); strokeWeight(1);
    circle( this.pos.x, this.pos.y, 2*this.sightRadius );
    
    fill(0);
    text( round(this.hunger), this.pos.x, this.pos.y );
  }
  
  
  void move() {
    this.spottedPlant = false;
    
    for( Plant currPlant : plants) {
      float distToPlant = this.pos.dist( currPlant.pos );
            
      if( distToPlant <= this.sightRadius && this.hunger > 0 && currPlant.diameter > 0 ) {
          this.spottedPlant = true;
          this.headTowards( currPlant );  
          this.furColour = happyFur;
      }
      
      if( distToPlant < 15 )
        this.eat( currPlant );
    }
    
    if( ! this.spottedPlant ) {
      this.furColour = normalFur;
      this.eating = false;
      
      if( random(100) < this.nervousness ) {
        pickRandDirection();
      }
    }
    
    if( ! eating ) {  //We only move and get hungrier if we're not eating
       this.pos.add( this.vel );
       this.hunger += 0.02;
    }
    
    if( ! rabbitInBounds() ) {
      this.vel.mult(-1);  //Reverse direction if we hit the border
    }
    
  }
  
  
  void pickRandDirection() {
    float randAngle = random(0, TWO_PI);
    PVector direction = new PVector( cos(randAngle), sin(randAngle) );  //Unit vector pointing in the randomly chosen angle
    this.vel = direction.mult( this.speed );  //Velocity = the unit vector multiplied by how fast you move
  }
  
  
  void headTowards( Plant pl ) {
    PVector displacement = PVector.sub( pl.pos, this.pos );
    float angle = displacement.heading();
    PVector direction = new PVector( cos(angle), sin(angle) );
    this.vel = direction.mult( this.speed );
  }
  
  
  void eat( Plant victim ) {
    victim.diameter -= 0.30;
    this.hunger -= 0.15;
  }
  
  
  boolean rabbitInBounds() {
    return this.pos.x > 0 
        && this.pos.x < width
        && this.pos.y > 0
        && this.pos.y < height;   
  }
}

class Rabbit {
  //FIELDS
  String name;
  PVector pos, vel;
  float hunger, thirst;
  float speed, size, sightRadius, nervousness;
  boolean alive, eating, spottedPlant;
  color furColour;
  
  
  //CONSTRUCTOR
  Rabbit(String n, float sp, float sr, float nerv) {
    this.name = n;
    this.furColour = normalFur;
    this.speed = sp;
    this.sightRadius = sr;
    this.nervousness = nerv;
    this.pos = new PVector( random(0.2*width, 0.8*width), random(0.2*height, 0.8*height) ); 
    this.alive = true;
    this.spottedPlant = false;
    this.eating = false;
    this.size = 35;  
    this.pickRandDirection();
  }
  
  
  //METHODS
  void drawMe() {
   
    fill(this.furColour);
    noStroke();
    square( this.pos.x, this.pos.y, this.size );
    
    noFill();
    stroke(0); strokeWeight(1);
    circle( this.pos.x, this.pos.y, 2*this.sightRadius );
    
    fill(0);
    text( round(this.hunger), this.pos.x, this.pos.y );
  }
  
  
  void move() {
    this.spottedPlant = false;
    
    for( Plant currPlant : plants) {
      float distToPlant = this.pos.dist( currPlant.pos );
            
      if( distToPlant <= this.sightRadius && this.hunger > 0 && currPlant.diameter > 0 ) {
          this.spottedPlant = true;
          this.headTowards( currPlant );  
          this.furColour = happyFur;
      }
      
      if( distToPlant < 15 )
        this.eat( currPlant );
    }
    
    if( ! this.spottedPlant ) {
      this.furColour = normalFur;
      this.eating = false;
      
      if( random(100) < this.nervousness ) {
        pickRandDirection();
      }
    }
    
    if( ! eating ) {  //We only move and get hungrier if we're not eating
       this.pos.add( this.vel );
       this.hunger += 0.02;
    }
    
    if( ! rabbitInBounds() ) {
      this.vel.mult(-1);  //Reverse direction if we hit the border
    }
    
  }
  
  
  void pickRandDirection() {
    float randAngle = random(0, TWO_PI);
    PVector direction = new PVector( cos(randAngle), sin(randAngle) );  //Unit vector pointing in the randomly chosen angle
    this.vel = direction.mult( this.speed );  //Velocity = the unit vector multiplied by how fast you move
  }
  
  
  void headTowards( Plant pl ) {
    PVector displacement = PVector.sub( pl.pos, this.pos );
    float angle = displacement.heading();
    PVector direction = new PVector( cos(angle), sin(angle) );
    this.vel = direction.mult( this.speed );
  }
  
  
  void eat( Plant victim ) {
    victim.diameter -= 0.30;
    this.hunger -= 0.15;
  }
  
  
  boolean rabbitInBounds() {
    return this.pos.x > 0 
        && this.pos.x < width
        && this.pos.y > 0
        && this.pos.y < height;   
  }
}

// Main code

int numRabbits = 4;
int numPlants = 12;

Rabbit[] rabbits = new Rabbit[ numRabbits ];
Plant[] plants = new Plant[ numPlants ];

color normalFur = color(198, 140, 70);  //brown
color foxFur = color(200, 10, 50); // red
color happyFur = color(0, 255, 255);  //cyan


void setup() {
  size(1000,800);
  rectMode(CENTER);
  textAlign(CENTER);
  textSize(18);
  
  makeRabbits();
  makePlants();
}


void makeRabbits() {
  for(int i = 0; i < rabbits.length; i++) {
    String rName = "Rabbit #" + i;
    rabbits[i] = new Rabbit( rName, 3.0, random( 30, 150), 3 );
  }
}


void makePlants() {
  for(int i = 0; i < plants.length; i++) 
    plants[i] = new Plant(random(0.9*width), random(0.9*height));  
}


void draw() {
  background(100,255,0);
  
  for( Plant p : plants ) {  //Another way to write a for-loop that goes through an array of class objects
    p.drawMe();
  }
  
  for( Rabbit r : rabbits ) {
    r.drawMe();
    r.move();
  }
}

