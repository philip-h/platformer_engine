Player p;
ArrayList<Platform> platforms;
void setup() {
  size(700, 500);
  p = new Player(90, 250, 30, 30);
  platforms = new ArrayList<Platform>();

  genRandomPlatforms();
}

void genRandomPlatforms() {


  Platform current = new Platform(90, 3*height/4, 100, 10);
  platforms.add(current);

  for (int i = 0; i < 9; i++) {
    float x = current.x + random(105, 150);
    float y = current.y + random(-50, 30);
    float size = random(35, 100);

    Platform next = new Platform(x, y, size, 10);
    platforms.add(next);
    current = next;
  }
}

void updatePlatforms() {
  // Get the last platform
  Platform lastGenerated = platforms.get(platforms.size() -1);

  // Delete all platforms out of screen and add a new one
  // Go decending order so I can add to the end & delete without skipping anything
  for (int i = platforms.size()-1; i >= 0; i--) {
    if (platforms.get(i).x < -100) {

      platforms.remove(platforms.get(i));
      float x = lastGenerated.x + random(105, 150);
      float y = lastGenerated.y + random(-50, 30);
      float size = random(35, 100);

      Platform newPlt = new Platform(x, y, size, 10);
      platforms.add(newPlt);
    }
  }
}

void draw() {
  background(255);
  updatePlatforms();

  for (Platform plt : platforms) {
    plt.update();
    plt.display();
  }

  p.updatePosition();

  p.handleCollide(platforms);

  p.display();

  textSize(32);
  textAlign(LEFT, TOP);
  text("Score: " + str(int((p.x-90)*0.1)), 10, 10);

  if (p.y - p.halfHeight > height) {
    noLoop();
    print("You lose");
    return;
  }
}

void keyPressed() {
  p.setMovement(keyCode, true);
  for (Platform plt : platforms) {
    plt.setMovement(keyCode, true);
  }
}

void keyReleased() {
  p.setMovement(keyCode, false);
  for (Platform plt : platforms) {
    plt.setMovement(keyCode, false);
  }
}