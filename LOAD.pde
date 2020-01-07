boolean loaded;
GUI GUI[] = new GUI[1];

PImage tile, bomb, flag; //images
PFont bit8;

void load() { 
  restart();
  GUI[0] = new GUItogglebutton(0, (width/4)* 3-100, 0, (width/4)* 3+100, 50, "FLAG", 0, 0, 255, 0, 25, 255, true);

  tile = loadImage("tile.png");
  flag = loadImage("flag.png");
  bit8 = loadFont("Endless-Boss-Battle-48.vlw");
  textFont(bit8);
  loaded = true;
}

void restart() {
  firstclick = true;
  gameoverboo = false;


  for (int i = 0; i < grid.length; i++)
    for (int j = 0; j < grid.length; j++)
      grid[i][j] = new empty(i, j);

  for (int i = 0; i < grid.length; i++)
    for (int j = 0; j < grid.length; j++)
      grid[i][j].count();
}
