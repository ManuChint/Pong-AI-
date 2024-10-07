Game g;

void setup() {
  size(960, 540);
  g = new Game(this);
}

void draw() {
  g.run(1/ frameRate);
}
