class Player implements Entity{
  Coordinates coords;
  int lightRadius = 100;
  int flashlightRadius = 300;
  float flashlightAngle;
  
  Player(){
    coords = new Coordinates(width/2, height/2);
    flashlightAngle = atan((mouseY-this.coords.y)/(mouseX-this.coords.x));
  }
  void move(){
    float sprintMod;
    
    if(keysPressed[' ']) sprintMod = 1.8;
    else sprintMod = 1;
    
    if(keysPressed['w'] && keysPressed['a']){
      coords.x -= sprintMod/sqrt(2);
      coords.y -= sprintMod/sqrt(2);
    } else if(keysPressed['a'] && keysPressed['s']){
      coords.x -= sprintMod/sqrt(2);
      coords.y += sprintMod/sqrt(2);
    } else if(keysPressed['s'] && keysPressed['d']){
      coords.x += sprintMod/sqrt(2);
      coords.y += sprintMod/sqrt(2);
    } else if(keysPressed['d'] && keysPressed['w']){
      coords.x += sprintMod/sqrt(2);
      coords.y -= sprintMod/sqrt(2);
    }
    else if(keysPressed['w']) coords.y -= sprintMod;
    else if(keysPressed['a']) coords.x -= sprintMod;
    else if(keysPressed['s']) coords.y += sprintMod;
    else if(keysPressed['d']) coords.x += sprintMod;
    
    if(coords.x < 0)      coords.x = 0;
    if(coords.x > width)  coords.x = width;
    if(coords.y < 0)      coords.y = 0;
    if(coords.y > height) coords.y = height;
    
    light();
  }
  void light(){
    if(mouseX<coords.x)
      flashlightAngle = PI+atan((mouseY-this.coords.y)/(mouseX-this.coords.x));
    else
      flashlightAngle = atan((mouseY-this.coords.y)/(mouseX-this.coords.x));
  }
  void kill(){
    try{
      Thread.sleep(800);
    }catch(InterruptedException e){
    }
    System.exit(0);
  }
  void show(){
    fill(255);
    ellipse(coords.x, coords.y, lightRadius*2, lightRadius*2);
    arc(coords.x, coords.y, flashlightRadius*2, flashlightRadius*2, flashlightAngle-QUARTER_PI, flashlightAngle+QUARTER_PI);
    fill(0);
    ellipse(coords.x, coords.y, 10, 10);
  }
}
