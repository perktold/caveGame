class Player implements Entity{
  float x,y;
  Player(){
    x = width/2;
    y = height/2;
  }
  void move(){
    if(keysPressed['w']) y--;
    if(keysPressed['a']) x--;
    if(keysPressed['s']) y++;
    if(keysPressed['d']) x++;
    
    if(x < 0)      x = 0;
    if(x > width)  x = width;
    if(y < 0)      y = 0;
    if(y > height) y = height;
    
    flashlight();
  }
  void flashlight(){
    
  }
  void show(){
    ellipse(x, y, 10, 10);
  }
}
