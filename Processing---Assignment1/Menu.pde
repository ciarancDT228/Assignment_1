class Menu
{
  float buttonHeight;//The height and width of the menu buttons
  float buttonWidth;
  float halfW;//Half of the height and width of the menu buttons (for centering the text)
  float halfH;
  float gWidth;//The width and height of the area the graph is drawn in
  float gHeight;
  float actWidth;//The width of the entire screen

  int x;//x and y store the index values of the buttons pressed on the right. The main method (DataVis) sends these to the Scatter class.
  int y;
  //This arraylist stores the list of attributes (weight, dimensions, etc) as Strings. There are 12 different attributes.
  ArrayList<String> attrib = new ArrayList<String>();
  
  //Array of booleans to store which buttons are toggled. The number 12 is hardcoded because the data must be loaded before using attrib.size()
  boolean[] xList = new boolean[12];
  boolean[] yList = new boolean[12];
  
  Menu()
  {
    gWidth = 800;
    gHeight = 600;
    actWidth = 1100;
    buttonWidth = (actWidth-gWidth)/2;
    buttonHeight = gHeight/13;//13 is the length of the attrib array (buttons) plus one for the labels on top
    halfW = buttonWidth/2;
    halfH = buttonHeight/2;
    x=0;
    y=0;
    xList[0] = true;
    yList[0] = true;
  }
  
  //-----------------------------------------------------------------------------------------
  void mousePressed()
  {
    //If mouse is over buttons on the right side
    if(mouseX>gWidth && mouseY>buttonHeight)
    {
      //If mouse is over first column
      if(mouseX<gWidth+buttonWidth)
      {
        //Set all entire xList array to false first
        for(int i=0;i<xList.length;i++)
        {
          xList[i]=false;
        }
        //Then calculate the corresponding index of the button that was pressed.
        //This is done by mapping the mouseY from the column to the index range [0-12]
        int index = (int)map(mouseY, buttonHeight, gHeight, 0, 12);
        //When the index is calculated use it to set the boolean to true.
        xList[index] = true;
        x = index;
      }
      //if mouse is over second column
      else if(mouseX>gWidth+buttonWidth)
      {
        for(int i=0;i<xList.length;i++)
        {
          yList[i]=false;
        }
        int index = (int)map(mouseY, buttonHeight, gHeight, 0, 12);
        yList[index] = true;
        y=index;
      }
    }//end if mouse is over buttons
  }
  
  //-----------------------------------------------------------------------------------------
  void drawMenu()
  {
    stroke(0);
    fill(0);
    //The x position of the first button is the edge of the area the graph is drawn in
    float buttonX=gWidth;
    //Draw the labels first
    textAlign(CENTER, CENTER);
    text("x axis", buttonX+halfW, buttonHeight/2);
    text("y axis", gWidth+buttonWidth+halfW, buttonHeight/2);
    
    
    /*Two loops to handle drawing the 24 buttons. The inner loops draws 12 buttons vertically.
    The outer loop executes the inner loop twice but increments the x position of each button.*/
    for(int j=0;j<2;j++)
    {
      //The y position for drawing the first button. Initialised at the beginning of drawing the vertical column of buttons.
      float buttonY=buttonHeight;
      for(int i=0;i<attrib.size();i++)
      {
        //If this is the first column being drawn, check the xList boolean array.
        if(j==0)
        {
          //If the boolean xList is true, this button has been clicked and should be a brighter colour
          if(xList[i]== true)
          {
            fill(207,150,71);
          }
          else
          {
            fill(170,123,58);
          }
        }
        //If this is the second column being drawn, check the yList as above.
        else if(j==1)
        {
          if(yList[i]== true)
          {
            fill(207,150,71);
          }
          else
          {
            fill(170,123,58);
          }
        }
        //Once the fill colour is decided, draw the button
        rect(buttonX, buttonY, buttonWidth, buttonHeight);
        fill(0);
        //Put the text (label) inside the button
        textAlign(CENTER,CENTER);
        text(attrib.get(i), buttonX+halfW, buttonY+halfH);
        //Increment the y position as the column of buttons is drawn
        buttonY+=buttonHeight;
        //println("ButtonX: " + buttonX + "ButtonY: " + buttonY);
      }//end inner for
      //Incrementing the x position
      buttonX+=buttonWidth;
    }//end outer for
    
  }
  
  //-----------------------------------------------------------------------------------------
  void loadData()
  {
    String[] strings = loadStrings("Camera.csv");
    //Take only the first string, which is the list of attributes, and add them to attribs
    String[] attribs = strings[0].split(";");
    for(int i=1; i<attribs.length; i++)
    {
      attrib.add(attribs[i]);
    }//end for
  }//end loadData
  
  

}