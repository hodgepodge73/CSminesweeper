class GUItogglebutton extends GUIbutton {

  GUItogglebutton(int id, float x1, float y1, float x2, float y2, String label, int stroke, int fill, int textcolor, int strokealpha, int fillalpha, int textalpha, boolean changefill) { //changefill applies to if you want the color to change when its pressed
    this.id = id;
    size = new PVector(x2-x1, y2-y1);
    location = new PVector(x1+size.x/2, y1+size.y/2);
    this.label = label;
    this.stroke = stroke;
    this.fill = fill;
    this.textcolor = textcolor;
    this.textalpha = textalpha;
    this.strokealpha = strokealpha;
    this.fillalpha = fillalpha;
    this.changefill = changefill;
  }

  void action() {
    switch(id) {
      case 0:
      flagmode = activated;
      break;
    }
  }

  void control() {
    if (mousePressed) {
      if (mouseX > location.x-size.x/2 && mouseX < location.x+size.x/2 && mouseY > location.y-size.y/2 && mouseY < location.y+size.y/2 && !clicked) {
        clicked = true;
        if (activated)
          activated = false;
        else
          activated = true;
        action();
      }
    } else
      clicked = false;
  }
}

class GUImenubutton extends GUIbutton {

  GUImenubutton(int id, float x1, float y1, float x2, float y2, String label, int stroke, int fill, int textcolor, int strokealpha, int fillalpha, int textalpha) {
    this.id = id;
    size = new PVector(x2-x1, y2-y1);
    location = new PVector(x1+size.x/2, y1+size.y/2);
    this.label = label;
    this.stroke = stroke;
    this.fill = fill;
    this.textcolor = textcolor;
    this.textalpha = textalpha;
    this.strokealpha = strokealpha;
    this.fillalpha = fillalpha;
  }

  void action() {
    switch(id) {
    }
  }

  void control() {
    if (mousePressed) {
      if (mouseX > location.x-size.x/2 && mouseX < location.x+size.x/2 && mouseY > location.y-size.y/2 && mouseY < location.y+size.y/2 && !clicked) {
        clicked = true;
        action();
      }
    } else {
      clicked = false;
    }
  }
}

class GUIslider extends GUI {
  float slidervalue = 0.5;
  PVector sliderstart, sliderend;
  float sliderpos;
  boolean canslide;

  GUIslider(int id, float x1, float x2, float y, int size, int stroke, int fill) {
    sliderstart = new PVector(x1, y);
    sliderend = new PVector(x2, y);
    sliderpos = (sliderend.x-sliderstart.x)*slidervalue+sliderstart.x;
    this.size = size;
    canslide = false;
    this.stroke = stroke;
    this.fill = fill;
    this.id = id;
  }

  void control() {
    if (mousePressed && mouseX > sliderstart.x && mouseX < sliderend.x && mouseY > sliderstart.y-size/2 && mouseY < sliderstart.y+size/2) {
      sliderpos = mouseX;
      canslide = true;
    } else {

      if (mouseX < sliderstart.x && canslide) {
        slidervalue = 0;
        sliderpos = sliderstart.x;
      } else if (mouseX > sliderend.x && canslide) {
        slidervalue = 1;
        sliderpos = sliderend.x;
      }

      if (canslide && !mousePressed)
        canslide = false;
    }

    if (canslide)
      slidervalue = (sliderpos-sliderstart.x)/(sliderend.x-sliderstart.x);

    action();
  }

  void action() {
    switch(id) {
    }
  }

  void show() {
    stroke(stroke);
    fill(fill);
    line(sliderstart.x, sliderstart.y, sliderend.x, sliderend.y);
    rect(sliderpos, sliderstart.y, size/4, size);
    text("Value: "+slidervalue, 100, 100);
  }
}

/*------------------
 PARENT CLASSES
 DO NOT CALL DIRECTLY
 ------------------*/

class GUIbutton extends GUI {
  PVector location, size;
  String label;
  boolean changefill;
  boolean activated;
  boolean clicked;

  GUIbutton() {
    activated = clicked = false;
  }

  void control() {
  }

  void show() {
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    stroke(stroke, strokealpha);

    if (changefill)
      if (!activated)
        fill(fill, fillalpha);
      else
        fill(0, 255, 0, fillalpha);
    else
      fill(fill, fillalpha);

    if (mouseX > location.x-size.x/2 && mouseX < location.x+size.x/2 && mouseY > location.y-size.y/2 && mouseY < location.y+size.y/2) {

      if (changefill)
        if (!activated)
          fill(fill, 200-(255-fillalpha));
        else
          fill(0, 255, 0, 200-(255-fillalpha));
      else
        fill(fill, 200-(255-fillalpha));

      if (mousePressed)
        fill(fill, 155-(255-fillalpha));
    }
    rect(location.x, location.y, size.x, size.y);
    fill(textcolor);
    text(label, location.x, location.y);
  }
}

class GUI {
  int size;
  int stroke, fill;
  int textcolor;
  int strokealpha, fillalpha, textalpha;
  int id;

  GUI() {
  }
  void action() {
  }
  void control() {
  }
  void show() {
  }
}
