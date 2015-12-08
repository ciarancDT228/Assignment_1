class Scatter
{
  ArrayList<ArrayList<Float>> cameras = new ArrayList<ArrayList<Float>>();
  ArrayList<String> model = new ArrayList<String>();
  ArrayList<String> attrib = new ArrayList<String>();
  
  
  float gWidth;
  float gHeight;
  float border;
  float chev;
  float cx;
  float cy;
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
    plotPoints(x,y);
    horizontal(x);
    vertical(y);
  }
  
  void plotPoints(int x, int y)
  {
    stroke(b);
    fill(b);
    for(int i=0; i<cameras.size(); i++)
    {
      ArrayList<Float> data = cameras.get(i);
      float px;
      float py;
      px = map(data.get(x), getMin(x), getMax(x), cx+border, gWidth-border);
      py = map(data.get(y), getMin(y), getMax(y), gHeight-border, border);
      ellipse(cx+px, cy+py, 1, 1);
    }
  }
  
  //-----------------------------------------------------------------------------------------
  void loadData()
  {
    String[] strings = loadStrings("Camera.csv");
    String[] attribs = strings[0].split(";");
    for(int i=1; i<attribs.length; i++)
    {
      attrib.add(attribs[i]);
    }//end for
    
    for(int i=2; i<strings.length; i++)
    {
      String[] fields = strings[i].split(";");
      model.add(fields[0]);
      ArrayList<Float> data = new ArrayList<Float>();
      for(int j=1; j<fields.length;j++)
      {
        data.add(Float.parseFloat(fields[j]));
      }
      cameras.add(data);
    }
  }
  
  //-----------------------------------------------------------------------------------------
  void horizontal(int x)
  {
    float gap = 0;
    stroke(c);
    fill(c);
    line(cx+border, cy+gHeight-border, cx+gWidth-border, cy+gHeight-border);
    for(int i=0;i<=intervals;i++)
    {
      gap = map(i, 0, intervals, cx+border, cx+gWidth-border);
      line(gap, cy+gHeight-border, gap, cy+gHeight-border+chev);
      int maxIndex = getMaxIndex(x);
      int minIndex = getMinIndex(x);
      ArrayList<Float> data = cameras.get(maxIndex);
      float maximum = data.get(x);
      ArrayList<Float> data2 = cameras.get(minIndex);
      float minimum = data2.get(x);
      textAlign(CENTER,TOP);
      text((int)map(i, 0, intervals, minimum, maximum), gap, cy+gHeight-border+chev+chev);
    }
    text(attrib.get(x), cx+(gWidth/2), cy+gHeight-border+(chev*5));
  }  
  
  //-----------------------------------------------------------------------------------------
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
    pushMatrix();
    translate(cx+border-(chev*8), cy+(gHeight/2));
    rotate(PI*3/2);
    translate(-(cx+border-(chev*8)), -(cy+(gHeight/2)));
    text(attrib.get(x), cx+border-(chev*8), cy+(gHeight/2));
    popMatrix();
  }  

  //-----------------------------------------------------------------------------------------
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