class Platform {
  float x, y;
  float platformSpeed;
  float w, h;
  float halfWidth, halfHeight;
  
  PVector topRight, bottomLeft;
  
  boolean isMovingRight, isMovingLeft;
  
  Platform(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.platformSpeed = 2;
    this.w = w;
    this.h = h;
    this.halfWidth = w/2;
    this.halfHeight = h/2;
    
    this.topRight = new PVector(x+halfWidth, y-halfHeight);
    this.bottomLeft = new PVector(x-halfWidth, y+halfHeight);  
  }
  
  void update() {
    x += platformSpeed * (int(isMovingRight) - int(isMovingLeft));
  }
  
   void setMovement(int code, boolean isPressed) {
    switch(code) {
    case RIGHT:
      isMovingLeft = isPressed;
      break;
    case LEFT:
      isMovingRight = isPressed;
      break;
    }
  }
  
  void display() {
    fill(0);
    stroke(255,0,255);
    strokeWeight(1);
    rectMode(CENTER);
    rect(x, y, w, h);
    stroke(255);
    strokeWeight(2);
    point(x,y);
  }
}