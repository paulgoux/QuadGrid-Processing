

class Scene{
  public PApplet applet;
  public int id,gw = 25,gh = 20,R = 10,M = 1;
  public float bordersize = 1,limit,sw,sh,gW,gH,x,y,w,h;
  public int cols = 40, rows = 30;
  public String label;
  public boolean showq,showf;
  public boolean drag,resize,border = true,fill = true ,visible,clear;
  public int col;
  public int scol;
  public HashMap<String,Boolean> values = new HashMap<String,Boolean>();
  //public ArrayList<Menu> menus = new ArrayList<Menu>();
  //public ArrayList<Slider> sliders = new ArrayList<Slider>();
  //public ArrayList<Button> buttons = new ArrayList<Button>();
  //public ArrayList<Button> nav = new ArrayList<Button>();
  //Boundary boundary;


  public PImage bgimage;
  public ArrayList<Quad> fields = new ArrayList<Quad>();
  public ArrayList<Quad> qgrid = new ArrayList<Quad>();


  public Scene(float xx,float yy, float ww, float hh,Entity e){
    applet = e.applet;
    x = xx;
    y = yy;
    w = ww;
    h = hh;
    init();

    for(int i=0;i<rows;i++){
      for(int j=0;j<cols;j++){

        float X = x + (gw * j);  
        float Y = y + (gh * i);
        int ID = (j + i * cols);

        qgrid.add(new Quad(new PVector(X,Y),ID,i,j,gw,gh,this));
        

      }}
    e.scenes.add(this);
    println(qgrid.size());
  };
  
  void init(){
    R = 20;
    gh = (int) h/(rows);
    gw = (int) w/(cols);
    gW = (w)/(gw);
    gH = h/(gh);
    println(gh,gw,gW,gH);
  };


  Scene(){

  };

  public void save(){

  };

  public void load(){

  };

  public void display(){

    applet.noStroke();applet.fill(255);applet.rect(x,y,w,h);
    applet.strokeWeight(bordersize);
    applet.stroke(0);if(!border){applet.noStroke();}
    applet.fill(255);
    //    if(!fill)
    applet.noFill();

    applet.rect(x,y,w,h);

  };

  public void regression(){

  };

  public void field(){

    for(int i=0;i<fields.size();i++){

      Quad q = fields.get(i);

      q.draw();
      //q.clearLinks();
      //q.setField();
      //q.field();
    }

  };

  public boolean pos(){
    return applet.mouseX>x&&applet.mouseX<x+w&&applet.mouseY>y&&applet.mouseY<y+h;
  }

};
