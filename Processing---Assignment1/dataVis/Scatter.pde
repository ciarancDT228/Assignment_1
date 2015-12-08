class Scatter
{
  //This arraylist stores arraylists which have the fields from the dataset
  ArrayList<ArrayList<Float>> cameras = new ArrayList<ArrayList<Float>>();
  //This arraylist stores the models of the cameras (the first field on each line of the file)
  ArrayList<String> model = new ArrayList<String>();
  //This arraylist stores the name of each attribute from the first line on the file (model, price, weight, etc)
  ArrayList<String> attrib = new ArrayList<String>();
  
  //Using gWidth and gHeight instead of height and width. This allows the graph to be drawn in a predefined size instead of always depending on the screen size
  float gWidth;
  float gHeight;
  float border;
  //chev is the size of the little lines drawn on the axes
  float chev;
  //cx and cy are the coords of the top left corner of the graph. These are used so the graph can be moved around the screen (functionality not currently added yet)
  float cx;
  float cy;
  //intervals is the number of points on each axis
  float intervals;
  color c;
  color b;

  Scatter()
  {
    gWidth = 800;
    gHeight = 600;
    border = gWidth*0.1f;
    cx = 0;
    cy = 0;
    chev = border*0.1f;
    intervals = 10;
    c = color(0,40,74);
    b = color(1,10,79);
  }
  
  void drawGraph(int x, int y)
  {
    //To draw the graph just call each method
    plotPoints(x,y);//needs x and y to know what fields to plot
    horizontal(x);//needs x to calculate the x axis labels
    vertical(y);//needs y to calculate the y axis labels
  }
  
  void plotPoints(int x, int y)
  {
    stroke(b);
    fill(b);
    //Loop through the entire dataset (arraylist of arraylists)
    for(int i=0; i<cameras.size(); i++)
    {
      //make a temporary arraylist variable called data so we can use .get on this arraylist in an arraylist
      ArrayList<Float> data = cameras.get(i);
      //The x and y coords of the point that is about to be drawn
      float px;
      float py;
      //To get the coord of the point, map the value of the field it represents from the min->max of that field, to start->end of the axis area
      px = map(data.get(x), getMin(x), getMax(x), cx+border, gWidth-border);
      py = map(data.get(y), getMin(y), getMax(y), gHeight-border, border);
      ellipse(cx+px, cy+py, 1, 1);//cx and cy are added to everything, so the graph could be moved later
    }
  }
  
  //-----------------------------------------------------------------------------------------
  void loadData()
  {
    String[] strings = loadStrings("Camera.csv");
    //Temporary array of Strings to store the first line of the file, which is the attributes like model, price, etc
    String[] attribs = strings[0].split(";");
    //Use this attribs array to populate the attrib arraylist 
    for(int i=1; i<attribs.length; i++)
    {
      attrib.add(attribs[i]);
    }//end for
    
    //Starting at 2 because the first two lines are not floats
    for(int i=2; i<strings.length; i++)
    {
      String[] fields = strings[i].split(";");
      //Take the first field and add it to model, because it's a String
      model.add(fields[0]);
      //Temporary arraylist to store the fields of a single line
      ArrayList<Float> data = new ArrayList<Float>();
      for(int j=1; j<fields.length;j++)
      {
        //Adding the fields to the temporary arraylist
        data.add(Float.parseFloat(fields[j]));
      }
      //Add this arraylist to the arraylist of arraylists (say that 10 times fast)
      cameras.add(data);
    }
  }
  
  //-----------------------------------------------------------------------------------------
  void horizontal(int x)
  {
    float gap = 0;//The distance from the origin to the current interval/point
    stroke(c);
    fill(c);
    //The x axis itself
    line(cx+border, cy+gHeight-border, cx+gWidth-border, cy+gHeight-border);
    //Loop to draw the intervals, the numbers/labels underneath, the little lines marking each interval, and the text/label under the axis
    for(int i=0;i<=intervals;i++)
    {
      //Calculating the gap
      gap = map(i, 0, intervals, cx+border, cx+gWidth-border);
      //Drawing the little line
      line(gap, cy+gHeight-border, gap, cy+gHeight-border+chev);
      //Get the index of the highest and lowest value being plotted on the x axis
      int maxIndex = getMaxIndex(x);
      int minIndex = getMinIndex(x);
      //Use this index to get the actual value of the highest and lowest
      ArrayList<Float> data = cameras.get(maxIndex);
      float maximum = data.get(x);
      ArrayList<Float> data2 = cameras.get(minIndex);
      float minimum = data2.get(x);
      textAlign(CENTER,TOP);
      //Use this maximum and minumum to map i onto some values (for writing the numbers under each interval)
      text((int)map(i, 0, intervals, minimum, maximum), gap, cy+gHeight-border+chev+chev);
    }
    //The axis label. Comes from the attrib array
    text(attrib.get(x), cx+(gWidth/2), cy+gHeight-border+(chev*5));
  }  
  
  //-----------------------------------------------------------------------------------------
  //This whole method is basically the same as the previous one, except the axis label is rotated at the end
  void vertical(int x)
  {
    float gap=0;
    stroke(c);
    fill(c);
    line(cx+border, cy+gHeight-border, cx+border, cy+border);
    for(int i=0; i<=intervals; i++)
    {
      gap = map(i, 0, intervals, cy+gHeight-border, cy+border);
      line(cx+border, gap, cx+border-chev, gap);
      int maxIndex = getMaxIndex(x);
      int minIndex = getMinIndex(x);
      ArrayList<Float> data = cameras.get(maxIndex);
      float maximum = data.get(x);
      ArrayList<Float> data2 = cameras.get(minIndex);
      float minimum = data2.get(x);
      textAlign(CENTER,TOP);
      text((int)map(i, 0, intervals, minimum, maximum), cx+border-(chev*3), gap-chev);
    }
    //Rotating the axis label
    pushMatrix();
    translate(cx+border-(chev*8), cy+(gHeight/2));
    rotate(PI*3/2);
    translate(-(cx+border-(chev*8)), -(cy+(gHeight/2)));
    text(attrib.get(x), cx+border-(chev*8), cy+(gHeight/2));
    popMatrix();
  }  

  //-----------------------------------------------------------------------------------------
  //The get max, get min, get sum, etc. are all pretty basic methods, I don't think it's necessary to explain these...
  int getMaxIndex(int x)
  {
    float max=0;
    int maxInd=0;
    for(int i=0; i<cameras.size(); i++)
    {
      ArrayList<Float> data = cameras.get(i);
      if(data.get(x)>max)
      {
        max = data.get(x);
        maxInd = i;
      }
    }
    return maxInd;
  }
  
  float getMax(int x)
  {
    int m = getMaxIndex(x);
    ArrayList<Float> data = cameras.get(m);
    return data.get(x);
  }
  
  //-----------------------------------------------------------------------------------------
  int getMinIndex(int x)
  {
    float min=9999;
    int minInd=0;
    for(int i=0; i<cameras.size(); i++)
    {
      ArrayList<Float> data = cameras.get(i);
      if(data.get(x)<min)
      {
        min = data.get(x);
        minInd = i;
      }
    }
    return minInd;
  }  
  
  float getMin(int x)
  {
    int m = getMinIndex(x);
    ArrayList<Float> data = cameras.get(m);
    return data.get(x);
  }
  
  //-----------------------------------------------------------------------------------------
  float getSum(int x)
  {
    float total=0;
    for(int i=0; i<cameras.size(); i++)
    {
      ArrayList<Float> data = new ArrayList<Float>();
      total += data.get(x);
    }
    return total;
  }  

  
}//end class