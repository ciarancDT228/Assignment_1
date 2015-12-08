class Piechart
{
  ArrayList<ArrayList<Float>> cameras = new ArrayList<ArrayList<Float>>();
  ArrayList<String> model = new ArrayList<String>();
  
  
  float gWidth;
  float gHeight;
  float border;
  float cx;
  float cy;
  color c;
  color b;
  
  int[] modelCount = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
  String[] models = {"Agfa", "Canon", "Casio", "Contax", "Epson", "Fujifilm", "HP Photosmart", "JVC", "Kodak", "Kyocera", "Leica", "Nikon", "Olympus", "Panasonic", "Pentax", "Ricoh", "Samsung", "Sanyo", "Sigma", "Sony", "Toshiba"};
  color[] r = new color[21];
  
  Piechart()
  {
    gWidth = 1000;
    gHeight = 600;
    border = gWidth*0.1f;
    cx = 0;
    cy = 0;
    c = color(139, 81, 0);
    b = color(3, 51, 90);
  }
  
  //-----------------------------------------------------------------------------------------
  void loadData()
  {
    String[] strings = loadStrings("Camera.csv");  
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
    
    for(int i=0; i<r.length;i++)
    {
      r[i] = color(random(0,255),random(0,255),random(0,255));
    }
    countModels();
  }
  
  //-----------------------------------------------------------------------------------------
  //This method checks every model in the arraylist to see if it contains any String from the models array as a substring.
  void countModels()
  {
    for(int j=0; j<models.length; j++)
    {
      for(int i=0;i<model.size();i++)
      {
        if(model.get(i).toLowerCase().contains(models[j].toLowerCase()))
        {
          //When there is a match, count it in the modelCount array
          modelCount[j]++;
        }
      }
    }
  }
  
  //-----------------------------------------------------------------------------------------
  void drawPie()
  {
    float slice=TWO_PI/sum(modelCount);//Divide 360 degrees by the total number of models to find the angle for one model
    float cx=gWidth/2;//The centre position of the piechart is half the width, and half the height
    float cy=gHeight/2;
    float tx;//tx and ty are the x and y coords for the text
    float ty;
    float dia=gHeight-(border*2);//The diameter of the piechart is half of the drawable area
    float x=0;//x and y are the angles each arch starts and stops
    float y=0;
    float theta=0;//The angle used to position the text
    float fontGap=30;//The extra bit added to the radius when positioning the text
    
    
    for(int i=0; i<modelCount.length; i++)
    {
      //Segments
      if(i==0)
      {
        x=0;
        y=modelCount[i]*slice;
      }
      else
      {
        x=y;
        y+=modelCount[i]*slice;
      }
      fill(r[i]);
      stroke(r[i]);
      arc(cx, cy, dia, dia, x, y, PIE);
      
      //Text
      theta=x+(PI/2)+((y-x)/2);//The angle for the text is half of the angle the segment covers
      tx = cx + sin(theta) * ((dia/2)+fontGap);//
      ty = cy -cos(theta) * ((dia/2)+fontGap);
     
      textAlign(CENTER,CENTER);
      text(models[i], tx, ty);
      
    }//end for
  }//end pie
  
  //---------------------------------------------------------------------------------------------------
  float sum(int[] modelCount)
  {
    float total=0;
    for(int i=0;i<modelCount.length;i++)
    {
      total+=modelCount[i];
    }//end for
    return total;
  }//end sum
  
  //---------------------------------------------------------------------------------------------------
  int maxIndex(int[] modelCount)
  {
    float maximum=-1;
    int maximumI=-1;
    for(int i=0;i<modelCount.length;i++)
    {
      if(modelCount[i]>maximum)
      {
        maximum=modelCount[i];
        maximumI=i;
      }//end if
    }//end for
    return maximumI;
  }//end min
  
  
}