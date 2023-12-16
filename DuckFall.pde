import java.util.Comparator;

float dt = 1f/30;
Vector gravity = Vector(0, 9.8, 0);

ArrayList<Duck> ducks;
PImage duckImg;
Comparator<Duck> showPrecedence;

void setup() {
  fullScreen();
  //size(512, 512, P2D);
  randomSeed(0);
  duckImg = loadImage("data/duck.png");
  duckImg = resizeUnblurred(duckImg, 8);
  showPrecedence = new Comparator<Duck>() {
    public int compare(Duck duck1, Duck duck2) {
      return -Float.compare(duck1.pos.z, duck2.pos.z);
    }
  };
  
  ducks = new ArrayList<Duck>();
  int N = 256;
  mallocVector(N*2);
  for (int i=0; i<N; i++) {
    ducks.add(new Duck());
  }
  background(0);
  strokeWeight(5);
  //textureMode(NORMAL);
}

void draw() {
  //stroke(255);
  //beginShape();
  //texture(duckImg);
  //vertex(256-128, 256-128, 0, 0);
  //vertex(256-128, 256+128, 0, 1);
  //vertex(256+128, 256+128, 1, 1);
  //vertex(256+256, 256-128, 1, 0);
  //endShape();
  T("all");
  T("update");
  dt = 1f/frameRate;
  for (Duck duck : ducks) {
    duck.update();
  }
  TT("sort");
  ducks.sort(showPrecedence);
  TT("show");
  T("background");
  background(0);
  TT("duck");
  for (Duck duck : ducks) {
    duck.show();
  }
  TT("pointer");
  noFill();
  stroke(255);
  strokeWeight(2);
  ellipse(mouseX, mouseY, 100, 100);
  T();
  T();
  T();
}
