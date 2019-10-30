Player player;
boolean[] keysPressed = new boolean[100000];
ArrayList<Entity> entities = new ArrayList<Entity>();

void setup(){
  fullScreen();
  noStroke();
  fill(255);
  player = new Player();
  entities.add(player);
  for(int i = 0; i < 10; i++)
    entities.add(new Enemy());
}
void draw(){
  background(0);
  for(Entity e : entities){
    e.move();
    e.show();
  }
}
void keyPressed(){
  keysPressed[key] = true;
}
void keyReleased(){
  keysPressed[key] = false;
}
