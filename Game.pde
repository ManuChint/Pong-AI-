import processing.sound.*;

public class Game {
  private Player p1;
  private Player p2;
  private Ball b;
  private String gameState = "serve";
  private SoundFile hit;
  private SoundFile victory;
  private SoundFile score;

  public Game(PApplet p) {
    p1 = new Player(10, 10, 'w', 's');
    p2 = new Player(width - 30, height - 90, 'i', 'k');
    b = new Ball(p);
    hit = new SoundFile(p, "Hit.wav");
    victory = new SoundFile(p, "Victory.wav");
    score = new SoundFile(p, "Point.wav");
  }
       
    public int getK() { return p1.getScore(); }

  public void run(float dt) {
    //println(dt);
    background(40, 45, 52);

    //textSize(72);
    //textAlign(CENTER, CENTER);
    //stroke(255);
    //text("Hello Pong!", width / 2, height / 2);

    checkState();

    //p1.update(dt);
    //p2.update(dt);
    p1.OtherAi(b);
    p2.AiMove(b, g); //-- code added
    if (gameState.equals("play")) {
      b.update(dt);

      if (b.isOnLeft(p1)) {
        score.play();
        p2.scorePoint();
        b.reset();
        gameState = "serve";
      } else if (b.isOnRight(p2)) {
        score.play();
        p1.scorePoint();
        b.reset();
        gameState = "serve";
      }
      if (b.collides(p1)) {
        hit.play();
        b.flipDirection();
      } else if (b.collides(p2)) {
        hit.play();
        b.flipDirection();
      }
      
      checkForVictory();
    }

    p1.render();
    p2.render();

    
    if (!gameState.equals("victory")) {
      b.render();
    }
    if (gameState.equals("serve")) {
      renderScores();
    } else if (gameState.equals("victory")) {
      if (p1.getScore() > p2.getScore()) {
        printWinner(1);
      } else {
        printWinner(2);
      }
    }
  }

  void checkState() {
    if (keyPressed && key == ' ' && gameState.equals("serve")) {
      gameState = "play";
    }
  }

  void renderScores() {
    textSize(96);
    textAlign(CENTER);
    stroke(255);
    text(p1.getScore(), width / 4, 100);
    text(p2.getScore(), 3 * width / 4, 100);
  }

  void checkForVictory() {
    if (p1.getScore() == 4 || p2.getScore() == 4) {
      gameState = "victory";
      victory.play();
  }
}
  void printWinner(int winner) {
    textSize(72);
    textAlign(CENTER, CENTER);
    stroke(255);
    text("Player " + winner + " wins!", width / 2, height / 2);
  }
}
