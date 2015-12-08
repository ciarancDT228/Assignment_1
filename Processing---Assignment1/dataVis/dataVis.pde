void setup()
{
  size(1100,600);
  color bg = color(3, 51, 90);
  background(bg);
  //Call the loadData methods on each class
  piechart.loadData();
  scatter.loadData();
  menu.loadData();
}

//Declaring each object for later use
Scatter scatter = new Scatter();
Piechart piechart = new Piechart();
Menu menu = new Menu();
//The two booleans used for the menu in the top left
boolean[] graphs = new boolean[2];

//-----------------------------------------------------------------------------------------
void draw()
{
  background(203, 198, 177);
  stroke(0);
  //method to display the two buttons in the top left
  menuTop();
  //Check which of these buttons is selected and render the corresponding graph
  if(graphs[0]==true)
  {
    //The menu.x and menu.y variables are the corresponding index values for the fields to be displayed on the scatterplot.
    scatter.drawGraph(menu.x,menu.y);
    //The menu class is for the scatterplot only
    menu.drawMenu();
  }
  else if(graphs[1]==true)
  {
    piechart.drawPie();
  }
}

//-----------------------------------------------------------------------------------------
void mousePressed()
{
  menu.mousePressed();
  
  //If mouse is positioned over the two button in the top left
  if(mouseY<40 && mouseX<200)
  {
    //Set the boolean array to false (doing two lines like this was just easier than a for loop)
    graphs[0]=false;
    graphs[1]=false;
    //If it's over the first button
    if(mouseX<100)
    {
      graphs[0]=true;
    }
    //If it's over the second button
    else
    {
      graphs[1]=true;
    }
  }
}

//-----------------------------------------------------------------------------------------
//Draw the buttons in the top left corner. Lots of hardcoding I know... it's not ideal but I ran out of time.
void menuTop()
{
  //If the first button is clicked, make it bright, otherwise dark.
  if(graphs[0]==true)
  {
    fill(207,150,71);
  }
  else
  {
    fill(170,123,58);
  }
  rect(0,0,100,40);
  fill(0);
  textAlign(CENTER,CENTER);
  text("Scatter Plot", 50, 20);
  //If the secind button is clicked, make it bright, otherwise dark.
  if(graphs[1]==true)
  {
    fill(207,150,71);
  }
  else
  {
    fill(170,123,58);
  }
  rect(100,0,100,40);
  fill(0);
  textAlign(CENTER,CENTER);
  text("Piechart", 150, 20);
}

//fill(207,150,71);