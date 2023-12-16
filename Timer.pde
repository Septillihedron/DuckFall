
class Timer {

  Timer parent;
  int indent;
  ArrayList<Timer> children = new ArrayList<>();
  String name;
  long start;
  long end = -1;
  long time = 0;
  long timeTotal = 0;

  Timer(Timer parent, String name) {
    this.indent = (parent == null)? 0 : parent.indent+1;
    this.parent = parent;
    this.name = name;
    this.start = System.nanoTime();
  }

  void addChild(Timer t) {
    children.add(t);
  }
  Timer getChild(String name) {
    for (Timer child : children) {
      if (child.name.equals(name)) return child;
    }
    return null;
  }
  void start() {
    start = System.nanoTime();
    end = -1;
  }
  void stop() {
    if (end == -1) {
      end = System.nanoTime();
      time = end - start;
      timeTotal += time;
    }
  }

  void print() {
    double avgTime = timeTotal/1000000d/frameCount;
    double timeMs = time/1000000d;
    System.out.printf("%s%s: %.2f ms (%.2f ms avg)\n", "  ".repeat(indent), name, timeMs, avgTime);
    for (Timer t : children) {
      t.print();
    }
  }
}
class RootTimer extends Timer {
  
  RootTimer() {
    super(null, "root");
    this.parent = this;
    this.indent = -1;
  }

  void print() {
    println();
    for (Timer t : children) {
      t.print();
    }
  }
  
}

Timer rootTimer = new RootTimer();
Timer currentTimer = rootTimer;

void T(String name) {
  Timer timer = currentTimer.getChild(name);
  if (timer == null) {
    timer = new Timer(currentTimer, name);
    currentTimer.addChild(timer);
  } else {
    timer.start();
  }
  currentTimer = timer;
}

void T() {
  currentTimer.stop();
  currentTimer = currentTimer.parent;
  if (currentTimer == rootTimer) {
    currentTimer.print();
  }
}

void TClose() {
  while (currentTimer != rootTimer) {
    T();
  }
}

void TT(String name) {
  T();
  T(name);
}
