class Button {
  //circular button class
  int x, y, w, h;
  float s;
  PImage img;
  boolean hovering = false;
  boolean clicked = false;

  Button(int x, int y, int w, int h, float s, PImage img) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.s = s;
    this.img = img;
  }

  void draw() {
    ellipse(x, y, w, h);
    imageMode(CENTER);
    image(img, x, y, w, h);

    //Determine if mouse is hovering over button and if so, enlarge by the variable s
    if (mouseX > x-(w/2) && mouseX < x + (w/2) && mouseY > y-(h/2) && mouseY < y + (h/2)) {
      pushMatrix();

      scale(s);
      image(img, x/s, y/s, w, h);
      popMatrix();
    } else {
    }
  }

  //Determine if mouse is being pressed
  boolean mouseClicked() {
    if (mousePressed) {
      if (mouseX > x-(w/2) && mouseX < x + (w/2) && mouseY > y-(h/2) && mouseY < y + (h/2)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
