grid grid[][] = new grid[10][10];
boolean firstclick = true;
boolean gameoverboo = false;
boolean flagmode = false;
int time = 0; 
int timefinal;

String uname="";  //user's name starts blank
boolean entered=false; //if the username has been entered
int charCount=0; //make user enter 3 characters for name stores length
String temp[]; //temporary variable to store the sorted data list
String [] names; //variable to store the names of the data
int [] times; //variable to store the scores of the data for the sort
//boolean gamestart = false;


void setup() {
  String [] data = loadStrings("scores.txt"); //puts the txt data into the data array
  temp = new String[data.length]; // sets the temp array to the length of the data array


  size(642, 692);  
  strokeWeight(2);
  stroke(0);
  noFill();
  textAlign(CENTER, CENTER);
  textSize(48);
  thread("load");

  //initialize the size of the name and score arrays
  names = new String[data.length/2];
  times = new int[data.length/2];
  //load data into names array
  for (int a=0; a < data.length/2; a++) {
    names[a]=data[a];
  }
  //load data into scores array
  int b=0;
  for (int a=data.length/2; a < data.length; a++) {
    times[b]=int(data[a]);
    b++;
  }
}

void draw() {
  background(155);  
  if (loaded) {

    if (wincheck())
      wingame();

    rectMode(CORNER);
    stroke(0);
    for (int i = 0; i < grid.length; i++)
      for (int j = 0; j < grid.length; j++)
        grid[i][j].show();

    fill(255);
    text("UI SPACE", width/4, 20);
    fill(255);
    textSize(12);
    if ((time/60)%60<10) {
      text("Time: " + time/3600 + ":0" + (time/60)%60, 330, 40);
    } else {
      text("Time: " + time/3600 + ":" + (time/60)%60, 330, 40);
    }
    textSize(48);
    GUI[0].control();
    GUI[0].show();
    if (gameoverboo == true) {
      gameover();
    }
    timefinal++;
  }
}



void mouseClicked() { 
  if (mouseY>=50) {
    int i = int(map(mouseX, 0, width, 0, grid.length));
    int j = int(map(mouseY, 50, height, 0, grid.length));
    if (flagmode) {
      grid[i][j].flagged = true;
    } else {
      if (!grid[i][j].bomb) {
        if (firstclick) {
          firstcli(i, j);
        }
        if (grid[i][j].bombcount == 0 && flagmode == false) {
          clear(i, j);
        }
      } else if (!flagmode) {
        gameoverboo = true;
        time  = timefinal;
      }
    }
    System.out.print(i +" "+ j);
    grid[i][j].clicked=true;
  }
}


void firstcli(int x, int y) {
  grid[x][y].isempty = true;
  for (int i = 0; i<4; i++) {
    int nx = x;
    int ny = y;
    FloatList turn = new FloatList();
    for (int m = 0; m < 4; m++) {
      turn.append(PI*m/2);
    }    
    while (turn.size() > 0) {
      int valu = int(random(0, turn.size()));
      float val = turn.get(valu);
      nx += int(cos(val));
      ny += int(sin(val));
      grid[constrain(nx, 0, 9)][constrain(ny, 0, 9)].isempty = true; 
      turn.remove(valu);
    }
  }    
  for (int i = 0; i < bombcount; i++) {
    bombgenerate();
  }  
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid.length; j++) {
      grid[i][j].count();
    }
  } 
  firstclick = false;
}
void win() {
  //check for win
  saveSortedData();
}
void gameover() {
  background(0);
  fill(255);
  textSize(48);
  text("Game Over", width/2, (height/4)-100);
  text("Exit", width/4, (height/4)-10);
  text("HIGHSCORES", 340, 220);
  fill(255);
  text("Retry", (width/4)*3, (height/4)-10);
  if (!entered) {
    text("Enter your Name:\n" + uname, 340, 600);
    text("___", 350, 650);

    //once user has input a 3 character name, stop asking for name
    if (uname != "" && charCount >=3)
      entered=true;
  }
  for (int a=0; a < names.length; a++) {
    if ((times[a]/60)%60<10) {
      text(names[a]+" - "+ times[a]/3600 + ":0" + (times[a]/60)%60, 350, 60*a+280);
    } else {
      text(names[a]+" - "+ times[a]/3600 + ":" + (times[a]/60)%60, 350, 60*a+280);
    }
    //text(names[a]+" - "+times[a], 350, 12*a+330);
  }
  //displays own score
  if (entered) {
    fill(250, 155, 100);
    if ((time/60)%60<10) {
      text(uname+" - "+time/3600 + ":0" + (time/60)%60, 340, 650);
    } else {
      text(uname+" - "+time/3600 + ":" + (time/60)%60, 340, 650);
    }
  }
  fill(200, 255, 200);

  if (mouseX > (width/4)-48 && mouseX < (width/4)+48 && mouseY > ((height/4)-10)-24 && mouseY < ((height/4)-10)+24) {
    fill(155); 
    if (mousePressed) {
      exit();
    }
  }

  if (mouseX > ((width/4)*3)-48 && mouseX < ((width/4)*3)+48 && mouseY > ((height/2)-10)-24 && mouseY < ((height/2)-10)+24) {
    fill(155); 
    if (mousePressed) {
      restart();
      //Mouse input works. Still need to implement a game restart (reset all variables)
    }
  }
}

void clear(int x, int y) {
  if (grid[x][y].bombcount ==0 && !grid[x][y].bomb) {
    grid[x][y].checked = true;
    for (int i = 0; i<3; i++) {
      for (int j = 0; j < 3; j ++) {  
        grid[constrain(x+i-1, 0, 9)][constrain(y+j-1, 0, 9)].clicked= true;
        if (!grid[constrain(x+i-1, 0, 9)][constrain(y+j-1, 0, 9)].bomb && !grid[constrain(x+i-1, 0, 9)][constrain(y+j-1, 0, 9)].checked && grid[constrain(x+i-1, 0, 9)][constrain(y+j-1, 0, 9)].bombcount ==0) {          
          clear(constrain(x+i-1, 0, 9), constrain(y+j-1, 0, 9));
        }
      }
    }
  }
}


//user interface for entering username
/*void u(){
 // background(200);
 text("Enter your Name:\n" + uname, 150, 370);
 text("___", 150, 390);
 
 //once user has input a 3 character name, stop asking for name
 if (uname != "" && charCount >=3)
 entered=true;
 gamestart = true; 
 }*/
//method to deal with sorting the data
void sort() {
  int i, j, flag = 1;    // set flag to 1 to start first pass
  int tempv;             // holding variable for score
  String tempName;      // holding variable for name
  int size = names.length; //how many passes to make
  //runs to swap around the scores
  for (i = 1; i <= size && flag==1; i++) {
    flag = 0;
    for (j=0; j < (size -1); j++) {
      if (times[j+1] > times[j]) {     // ascending order simply changes to <{ 
        tempv = times[j];             // swap score elements
        times[j] = times[j+1];
        times[j+1] = tempv;
        tempName = names[j];          //do the same with the names       
        names[j] = names[j+1];
        names[j+1] = tempName;
        flag = 1;                     // indicates that a swap occurred.
      }
    }
  }
  //adds sorted stuff to new array
  for (int a = 0; a< temp.length/2; a++) {
    temp[a] = names[a];
  }
  for (int a = temp.length/2; a< temp.length; a++) {
    temp[a] = str(times[a-temp.length/2]);
  }
}
//Method to deal with saving it
void saveSortedData () {
  //put data from the users name and score
  if (times[4] < time) {
    temp[4] = uname;
    temp[9] = str(time);
  }
  //loads it back into the text files
  saveStrings("scores.txt", temp);
}
//Deals with the username being typed
void keyTyped () {
  //used to collect username at the start of the program
  //only accept until user has input name
  if (entered==false && key != ENTER) {
    uname=uname + key; //add key typed to the end of the string
    charCount++; //add to the counter to exit after 3 characters
  }
}

//checks if player has won game
boolean wincheck() {
  for (int i = 0; i < 10; i++)
    for (int j = 0; j < 10; j++)
      if (!grid[i][j].clicked || !grid[i][j].bomb)
        return false;
  return true;
}

void wingame () {
}
