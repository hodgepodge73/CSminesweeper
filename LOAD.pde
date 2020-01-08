//Aidan

boolean loaded; //if files are loaded
GUI GUI[] = new GUI[4]; //GUI elements

PImage tile, bomb, flag; //images
PFont bit8; //font

//loads game
void load() { 
  restart();

  //buttons
  GUI[0] = new GUItogglebutton(0, (width/4)* 3-100, 0, (width/4)* 3+100, 50, "FLAG", 0, 0, 255, 0, 25, 255, true); //flag button on gamescreen
  GUI[1] = new GUImenubutton(0, width/4-120, 0, width/4+120, 50, "RESTART", 0, 0, 255, 0, 0, 255); //restart button on gamescreen
  GUI[2] = new GUImenubutton(1, width/4-100, height/4-10-24, width/4+100, height/4-10+24, "EXIT", 0, 0, 255, 0, 0, 255); //exit button on gameover screen
  GUI[3] = new GUImenubutton(0, width/4*3-100, height/4-10-24, width/4*3+100, height/4-10+24, "RETRY", 0, 0, 255, 0, 0, 255); //retry button on gameover screen

  //load images
  tile = loadImage("tile.png");
  flag = loadImage("flag.png");
  bit8 = loadFont("Endless-Boss-Battle-48.vlw");
  textFont(bit8);
  loaded = true; //end threading and start game
}

//resets variables to original state
void restart() {
  firstclick = true;
  gameoverboo = false;
  
  entered = false;
  uname = "";
  charCount = 0;
  time = timefinal = 0;


  for (int i = 0; i < grid.length; i++)
    for (int j = 0; j < grid.length; j++)
      grid[i][j] = new empty(i, j);

  for (int i = 0; i < grid.length; i++)
    for (int j = 0; j < grid.length; j++)
      grid[i][j].count();
}
