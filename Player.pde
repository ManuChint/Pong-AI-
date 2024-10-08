public class Player {
  private PVector location;
  private PVector velocity;
  private float pWidth = 20;
  private float pHeight = 80;
  private char upButton;
  private char downButton;
  private int score = 0;
  private final int PADDLE_SPEED = 300;
  
  public Player(float x, float y, char up, char down) {
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    upButton = up;
    downButton = down;
  }
  
  public float getX() { return location.x; }
  public float getY() { return location.y; }
  public float getWidth() { return pWidth; }
  public float getHeight() { return pHeight; }
  public int getScore() { return score; }
  
  public void scorePoint() { score++; }
  
  public void render() {
    fill(255);
    stroke(255);
    rect(location.x, location.y, pWidth, pHeight);
  }
  
  public void update(float dt) {
    if (keyPressed) {
      if (key == upButton) {
       velocity.y = -PADDLE_SPEED * dt;
     } else if (key == downButton) {
       velocity.y = PADDLE_SPEED * dt;
      }
    }
    location.add(velocity);
    location.y = constrain(location.y, 0, height - 80);
    velocity.mult(0);
  }
  
  public void OtherAi(Ball b) { //code added---------
    if (b.getY() > location.y) {
           location.y = getY();
           velocity.y = PADDLE_SPEED * .009;
      } else if (b.getY() < location.y) {
          location.y = b.getY();
          velocity.y = -PADDLE_SPEED * .009;
      } else if (b.getY() == location.y) {
          velocity.y = velocity.y;
    }
    location.add(velocity);
    location.y = constrain(location.y, 0, height - 80);
    velocity.mult(0);
  }
  public void AiMove(Ball b, Game g) { //code added --------
     if (g.getK() <= 2) {
      if (b.getY() > location.y) {
           location.y = getY();
           velocity.y = PADDLE_SPEED * .0055;
      } else if (b.getY() < location.y) {
          location.y = b.getY();
          velocity.y = -PADDLE_SPEED * .0055;
      } else if (b.getY() == location.y) {
          velocity.y = velocity.y;
    } } 
    else if (g.getK() > 2) { 
      
       if (b.getY() > location.y) {
           location.y = getY();
           velocity.y = PADDLE_SPEED * .0135;
    } else if (b.getY() < location.y) {
          location.y = b.getY();
          velocity.y = -PADDLE_SPEED * .0135;
    } else if (b.getY() == location.y) {
          velocity.y = velocity.y;
    }
    }
    location.add(velocity);
    location.y = constrain(location.y, 0, height - 80);
    velocity.mult(0); // to here ---
   }
 
}
