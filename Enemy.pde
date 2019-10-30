
class Enemy implements Entity{
  Coordinates coords = new Coordinates(0, 0);
  Coordinates playerLastSeen =new Coordinates(0, 0);
  Coordinates idlingGoal = new Coordinates(random(0, width), random(0, height));
  
  int viewRadius = 200;
  
  State state = State.SEARCHING;
  
  Enemy(){
    this.coords.x = 10;
    this.coords.y = 10;
  }
  
  void move(){
    if(state == State.SEARCHING){ 
      this.coords.x += (playerLastSeen.x-this.coords.x) / dist(playerLastSeen.x, playerLastSeen.y, this.coords.x ,this.coords.y)*1.5f;
      this.coords.y += (playerLastSeen.y-this.coords.y) / dist(playerLastSeen.x, playerLastSeen.y, this.coords.x ,this.coords.y)*1.5f;
      
      if(dist(this.coords.x, this.coords.y, playerLastSeen.x, playerLastSeen.y) < viewRadius){
        idlingGoal = new Coordinates(random(0, width), random(0, height));
        state = State.IDLING;
      }
    }
    if(state == State.HUNTING){
      this.coords.x += (player.x-this.coords.x) / dist(player.x, player.y, this.coords.x, this.coords.y)*2;
      this.coords.y += (player.y-this.coords.y) / dist(player.x, player.y, this.coords.x, this.coords.y)*2;
      playerLastSeen.x = player.x;
      playerLastSeen.y = player.y;
    }
    if(state == State.IDLING){
      this.coords.x += (idlingGoal.x-this.coords.x) / dist(idlingGoal.x, idlingGoal.y, this.coords.x, this.coords.y);
      this.coords.y += (idlingGoal.y-this.coords.y) / dist(idlingGoal.x, idlingGoal.y, this.coords.x, this.coords.y);
      
      if(dist(this.coords.x, this.coords.y, idlingGoal.x, idlingGoal.y) < viewRadius)
        idlingGoal = new Coordinates(random(0, width), random(0, height));
    }
    
    if(dist(player.x, player.y, this.coords.x, this.coords.y) < viewRadius) state = State.HUNTING;
  }
  void show(){
    fill(255,0,0);
    ellipse(this.coords.x, this.coords.y, 10, 10);
    fill(255);
  }
}
