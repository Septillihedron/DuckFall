
static final ArrayList<Vector> freeVectors = new ArrayList<Vector>();
static Vector Vector() {
  return Vector(0, 0, 0);
}

static Vector Vector(PVector v) {
  return Vector(v.x, v.y, v.z);
}

static Vector Vector(float x, float y) {
  return Vector(x, y, 0);
}

static Vector Vector(float x, float y, float z) {
  int numberOfFreeVectors = freeVectors.size();
  if (numberOfFreeVectors > 0) {
    Vector vec = freeVectors.get(numberOfFreeVectors-1);
    freeVectors.remove(numberOfFreeVectors-1);
    
    vec.Iset(x, y, z);
    return vec;
  }
  println("allocated Vector");
  return new Vector(x, y, z);
}

static Vector markedFreeVector(float x, float y, float z) {
  Vector vec = Vector(x, y, z);
  markFree(vec);
  return vec;
}
static Vector markedFreeVector(float x, float y) {
  Vector vec = Vector(x, y);
  markFree(vec);
  return vec;
}

static void mallocVector(int n) {
  for (int i=0; i<n; i++) {
    freeVectors.add(new Vector(0, 0, 0));
  }
  println("allocated Vector", n);
}

static void free(Vector v) {
  freeVectors.add(v);
}
static Vector markFree(Vector v) {
  freeVectors.add(v);
  return v;
}

static final class Vector {

  float x, y, z;

  Vector(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  Vector IaddScaled(Vector v, float scale) {
    this.x += v.x*scale;
    this.y += v.y*scale;
    this.z += v.z*scale;
    return this;
  }
  Vector addScaled(Vector v, float scale) {
    float x = this.x + v.x*scale;
    float y = this.y + v.x*scale;
    float z = this.z + v.x*scale;
    return Vector(x, y, z);
  }

  Vector Imult(float m) {
    this.x *= m;
    this.y *= m;
    this.z *= m;
    return this;
  }
  Vector mult(float m) {
    float x = this.x * m;
    float y = this.y * m;
    float z = this.z * m;
    return Vector(x, y, z);
  }
  Vector Iadd(Vector v) {
    this.x += v.x;
    this.y += v.y;
    this.z += v.z;
    return this;
  }
  Vector Iadd(float x, float y) {
    this.x += x;
    this.y += y;
    return this;
  }

  Vector Iproject(float screenDist) {
    float zScale = screenDist/this.z;
    this.x = this.x*zScale;
    this.y = this.y*zScale;
    this.z = 0;
    return this;
  }
  Vector project(float screenDist) {
    float zScale = screenDist/this.z;
    float x = this.x*zScale;
    float y = this.y*zScale;
    return Vector(x, y);
  }
  
  static float project1D(float x, float z, float screenDist) {
    float zScale = screenDist/z;
    return x*zScale;
  }
  
  Vector Iset(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
    return this;
  }
  
  static Vector random3D() {
    // from PVector.random3D
    double angle = Math.random()*Math.PI*2;
    double vz = Math.random()*2 -1;
    double vzSq = vz*vz;
    double xyMag = Math.sqrt(1-vzSq);
    double vx = xyMag*Math.cos(angle);
    double vy = xyMag*Math.sin(angle);
    return Vector((float) vx, (float) vy, (float) vz);
  }
  
  public String toString() {
    return String.format("(%.2f, %.2f, %.2f)", x, y, z);
  }
}
