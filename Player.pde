class Player {
  /* Movement and Position variables*/
  float x, y;
  float xSpeed, ySpeed;
  float jumpForce;
  float gravity;

  /* Display and AABB variables */
  float w, h;
  float halfWidth, halfHeight;
  PVector topRight, bottomLeft;

  /* Movement booleans for smooth movement transition */
  boolean isMovingRight, isMovingLeft;
  boolean iWantToJump, isJumping;
  boolean onGround;

  Player(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.xSpeed = 2;
    this.ySpeed = 0;
    this.jumpForce = 5;
    this.gravity = 0.3;

    this.w = w;
    this.h = h;
    this.halfWidth = w/2;
    this.halfHeight = h/2;

    updateBounds();
  }

  void updatePosition() {
    // Always apply gravity if not on a platform
    if (!onGround) {
      ySpeed += gravity;
    } else {
      ySpeed = 0;
    }


    if (iWantToJump && !isJumping) {
      ySpeed = -jumpForce;
      isJumping = true;
      onGround = false;
    }

    if (isJumping) {
      if (onGround) {
        isJumping = false;
      }
    }

    // Update position based on speed
    x += xSpeed*(int(isMovingRight) - int(isMovingLeft));
    y += ySpeed;
    updateBounds();
  }

  void updateBounds() {
    this.topRight = new PVector(x+halfWidth, y-halfHeight);
    this.bottomLeft = new PVector(x-halfWidth, y+halfHeight);
  }

  void setMovement(int code, boolean isPressed) {
    switch(code) {
    case RIGHT:
      isMovingRight = isPressed;
      break;
    case LEFT:
      isMovingLeft = isPressed;
      break;
    case UP:
      iWantToJump = isPressed;
      break;
    }
  }

  void handleCollide(ArrayList<Platform> plts) {
    onGround = false;

    for (Platform plt : plts) {
      // I am colliding with the bottom of a platform
      if (bottomLeft.y >= plt.topRight.y && bottomLeft.y <= plt.bottomLeft.y) {
        if (topRight.x >= plt.bottomLeft.x && bottomLeft.x <= plt.topRight.x) {
          y = plt.topRight.y - halfHeight;
          onGround = true;
        }
      } 

      // I am colliding with the top of the platform
      else if (topRight.y <= plt.bottomLeft.y && topRight.y >= plt.topRight.y) {
        if (topRight.x >= plt.bottomLeft.x && bottomLeft.x <= plt.topRight.x) {
          y = plt.bottomLeft.y + halfHeight;
        }
      } 

      // I am colliding witht the right of the platform
      if (topRight.x >= plt.bottomLeft.x && topRight.x <= plt.bottomLeft.x + plt.halfWidth) {
        if (bottomLeft.y >= plt.topRight.y + plt.halfHeight && topRight.y <= plt.bottomLeft.y - plt.halfHeight) {
          x = plt.bottomLeft.x - halfWidth;
        }
      }

      // I am colliding with the left
      else if (bottomLeft.x <= plt.topRight.x && bottomLeft.x >= plt.topRight.x - plt.halfWidth) {
        if (bottomLeft.y >= plt.topRight.y + plt.halfHeight && topRight.y <= plt.bottomLeft.y - plt.halfHeight) {
          x = plt.topRight.x + halfWidth;
        }
      }
    }
  }

  void display() {
    fill(127);
    stroke(0);
    rectMode(CENTER);
    rect(x, y, w, h);
    stroke(255);
    strokeWeight(2);
    point(x, y);
  }
}