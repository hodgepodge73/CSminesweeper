/*
Aidan
 these classes are generally very simple with minor differences.
 these differences are in the control tab and the action tab.
 
 to create a new button, add 1 to the id, and create a matching switch statement in the action tab for the corresponding button.
 this action will be run once.
 */

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

  //actions to do based off of id, this allows multiple buttons to have the same function if needed
  void action() {
    switch(id) {
    case 0:
      flagmode = activated;
      break;
    }
  }

  void control() {
    if (mousePressed) {
      if (mouseX > location.x-size.x/2 && mouseX < location.x+size.x/2 && mouseY > location.y-size.y/2 && mouseY < location.y+size.y/2 && !clicked) { //if mouse is within constraints
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
    case 0:
      //restart button
      restart();
      break;
    case 1:
      //exit button on endscreen
      exit();
      break;
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

/*------------------
 PARENT CLASSES
 DO NOT CALL DIRECTLY
 ------------------*/

class GUIbutton extends GUI {
  PVector location, size;
  String label;
  boolean changefill; //if the fill changes when the buttons state is changed
  boolean activated;
  //the rest are just the name

  GUIbutton() {
    activated = clicked = false;
  }

  void control() {
  }

  void show() {
    //re-alligning button
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    stroke(stroke, strokealpha);

    //fill changing
    if (changefill)
      if (!activated)
        fill(fill, fillalpha);
      else
        fill(0, 255, 0, fillalpha);
    else
      fill(fill, fillalpha);

    //if the mouse if over the button, change fill
    if (mouseX > location.x-size.x/2 && mouseX < location.x+size.x/2 && mouseY > location.y-size.y/2 && mouseY < location.y+size.y/2) {

      if (changefill)
        if (!activated)
          fill(fill, 200-(255-fillalpha));
        else
          fill(0, 255, 0, 200-(255-fillalpha));
      else
        fill(fill, 200-(255-fillalpha));

      //if the button is pressed again, change fill more
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
  int id; //id of button action
  boolean clicked; //if the button is clicked

  GUI() {
  }
  void action() {
  }
  void control() {
  }
  void show() {
  }
}
