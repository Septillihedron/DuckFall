
float screenZ = 800;
final class Duck {

  float r = 25;
  float maxInitialVel = 120;

  Vector pos, vel;
  float rotation, rotationVel;

  Duck() {
    pos = Vector();
    vel = Vector();
    init();
    float zScale = screenZ / pos.z;
    pos.Iset(pos.x, random(-height/2, height/2)/zScale, pos.z);
  }

  void init() {
    float z = random(screenZ, 2*screenZ);
    float zScale = screenZ / z;
    float x = random(-width, width)/zScale;
    float y = (random(-height/2, height/2)-height-r)/zScale;
    pos.Iset(x, y, z);
    free(vel);
    vel = Vector.random3D().Imult(maxInitialVel);
    vel.x = 0;
    rotation = random(TAU);
    rotationVel = random(-TAU, TAU);
    while (random(1) < 0.5) rotationVel *= 2;
  }

  void update() {
    pos.IaddScaled(vel, dt);
    vel.IaddScaled(gravity, dt);
    rotation += rotationVel*dt;
    
    Vector projected = pos.project(screenZ);
    projected.Iadd(width/2, height/2);
    float projectedR = Vector.project1D(r, pos.z, screenZ);
    
    if (outOfBounds(projected, projectedR)) {
      init();
    }
    
    
    free(projected);
  }

  void show() {
    Vector projected = pos.project(screenZ);
    projected.Iadd(width/2, height/2);
    float projectedR = Vector.project1D(r, pos.z, screenZ);
    
    if (outOfDrawBounds(projected, projectedR)) {
      free(projected);
      return;
    }
    
    T("translation");
    pushMatrix();
    translate(projected.x, projected.y);
    rotate(rotation);
    scale(projectedR/r);
    TT("ellipse");
    ellipse(0, 0, r*2, r*2);
    TT("image");
    image(duckImg, -r, -r, r*2, r*2);
    TT("translation");
    popMatrix();
    T();
    
    free(projected);
  }

  boolean outOfDrawBounds(Vector projected, float projectedR) {
    if (projected.x < -projectedR) return true;
    if (projected.x > width+projectedR) return true;
    if (projected.y < -projectedR) return true;
    if (projected.y > height+projectedR) return true;

    return false;
  }
  
  boolean outOfBounds(Vector projected, float projectedR) {
    if (projected.y > height+projectedR) return true;

    return false;
  }
}
