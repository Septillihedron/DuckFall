

PImage resizeUnblurred(PImage source, int multiplier) {
  PImage img = createImage(source.width*multiplier, source.height*multiplier, ARGB);
  source.loadPixels();
  img.loadPixels();
  for (int sy=0; sy<source.height; sy++) {
    for (int sx=0; sx<source.width; sx++) {
      color c = source.pixels[sy*source.width + sx];

      for (int dy=0; dy<multiplier; dy++) {
        for (int dx=0; dx<multiplier; dx++) {
          int index = (sy*multiplier + dy)*img.width + (sx*multiplier + dx);
          img.pixels[index] = c;
        }
      }
    }
  }
  img.updatePixels();
  return img;
}
