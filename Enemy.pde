
class Enemy implements Entity{
  Coordinates coords = new Coordinates(0, 0);
  Coordinates playerLastSeen =new Coordinates(0, 0);
  Coordinates idlingGoal = new Coordinates(random(0, width), random(0, height));
  
  boolean seen;
  int viewRadius = 200;
  
  State state = State.IDLING;
  
  Enemy(){
    this.coords.x = random(0, width);
    this.coords.y = random(0,height);
  }
  
  void move(){
    if(state == State.SEARCHING){ 
      this.coords.x += (playerLastSeen.x-this.coords.x) / dist(playerLastSeen.x, playerLastSeen.y, this.coords.x ,this.coords.y)*1.5f;
      this.coords.y += (playerLastSeen.y-this.coords.y) / dist(playerLastSeen.x, playerLastSeen.y, this.coords.x ,this.coords.y)*1.5f;
      
      if(dist(this.coords.x, this.coords.y, playerLastSeen.x, playerLastSeen.y) < 5){
        idlingGoal = new Coordinates(random(0, width), random(0, height));
        state = State.IDLING;
      }
    }
    if(state == State.HUNTING){
      this.coords.x += (player.coords.x-this.coords.x) / dist(player.coords.x, player.coords.y, this.coords.x, this.coords.y)*2;
      this.coords.y += (player.coords.y-this.coords.y) / dist(player.coords.x, player.coords.y, this.coords.x, this.coords.y)*2;
      playerLastSeen.x = player.coords.x;
      playerLastSeen.y = player.coords.y;
      if(dist(this.coords.x, this.coords.y, player.coords.x, player.coords.y) > viewRadius) state = State.SEARCHING;
    }
    if(state == State.IDLING){
      this.coords.x += (idlingGoal.x-this.coords.x) / dist(idlingGoal.x, idlingGoal.y, this.coords.x, this.coords.y);
      this.coords.y += (idlingGoal.y-this.coords.y) / dist(idlingGoal.x, idlingGoal.y, this.coords.x, this.coords.y);
      
      if(dist(this.coords.x, this.coords.y, idlingGoal.x, idlingGoal.y) < viewRadius)
        idlingGoal = new Coordinates(random(0, width), random(0, height));
    }
    
    float thisAngle;
    if(this.coords.x < player.coords.x)
      thisAngle = PI+atan((this.coords.y-player.coords.y)/(this.coords.x-player.coords.x));
    else
      thisAngle = atan((this.coords.y-player.coords.y)/(this.coords.x-player.coords.x));
    
    if(state == State.FLEEING){
      this.coords.x += (player.coords.x-this.coords.x) / dist(player.coords.x, player.coords.y, this.coords.x, this.coords.y)/2;
      this.coords.y += (player.coords.y-this.coords.y) / dist(player.coords.x, player.coords.y, this.coords.x, this.coords.y)/2;
      if(!(thisAngle > player.flashlightAngle - QUARTER_PI && thisAngle < player.flashlightAngle + QUARTER_PI && dist(player.coords.x, player.coords.y, this.coords.x, this.coords.y) < player.flashlightRadius))
        state = State.SEARCHING;
      playerLastSeen.x = player.coords.x;
      playerLastSeen.y = player.coords.y; 
    }
    
    if(dist(player.coords.x, player.coords.y, this.coords.x, this.coords.y) < viewRadius) state = State.HUNTING;
    
    seen = false;
    if(dist(this.coords.x, this.coords.y, player.coords.x, player.coords.y) < player.lightRadius) seen = true;
      
    if(thisAngle > player.flashlightAngle - QUARTER_PI && thisAngle < player.flashlightAngle + QUARTER_PI && dist(player.coords.x, player.coords.y, this.coords.x, this.coords.y) < player.flashlightRadius){
      seen = true;
      state = State.FLEEING;
    }
    
    if(dist(player.coords.x, player.coords.y, this.coords.x, this.coords.y) < 10)
      player.kill();
  }
  void show(){
    if(seen)
      fill(255,0,0);
    else{
      if(keysPressed['h'])
        fill(0, 0, 255);
      else
        fill(0);
    }
      ellipse(this.coords.x, this.coords.y, 10, 10);
      fill(255);
    
  }
}
