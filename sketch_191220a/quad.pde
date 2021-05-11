//--------------------------------------------------------------------------------

class Quad {
  int id, iid, xpos, ypos;
  float x, y,w,h;
  PVector p;
  public PApplet applet;
  ArrayList<object> children = new ArrayList<object>();
  ArrayList<Quad> links = new ArrayList<Quad>();
  ArrayList<Quad> linksb = new ArrayList<Quad>();
  Scene scene;

  Quad(PVector P, int ID) {
    p = P;
    id = ID;
    x = p.x;
    y = p.y;
  };

  Quad(PVector P, int ID, int i, int j) {
    p = P;
    id = ID;
    x = p.x;
    y = p.y;
    xpos = i;
    ypos = j;
    links.add(this);
    linksb.add(this);
  };
  
  Quad(PVector P, int ID, int i, int j,Scene s) {
    applet = s.applet;
    p = P;
    id = ID;
    x = p.x;
    y = p.y;
    xpos = i;
    ypos = j;
    links.add(this);
    linksb.add(this);
    scene = s;
  };
  
  Quad(PVector P, int ID, int i, int j,float W,float H,Scene s) {
    applet = s.applet;
    p = P;
    id = ID;
    x = p.x;
    y = p.y;
    xpos = i;
    ypos = j;
    w = W;
    h = H;
    links.add(this);
    linksb.add(this);
    scene = s;
  };

  void draw() {
    strokeWeight(1);
    stroke(255);
    noFill();
    rect(p.x, p.y, scene.gw, scene.gh);
  };

  void fillc() {
    fill(255);
    rect(p.x, p.y, scene.gw, scene.gh);
  };

  void fill2() {
    fill(0);
    rect(p.x, p.y, scene.gw, scene.gh);
    println(id);
  };

  void getNeighbours() {
  };

  void update() {

    for (int i=0; i<children.size(); i++) {

      object a = children.get(i);
      int t = 0;
      for (int j=0; j<children.size(); j++) {

        object b = children.get(j);
        float d = dist(a.x, a.y, b.x, b.y);

        if (d<a.r&&a!=b)t++;
      }
      if (t>0)a.collide = true;
      else a.collide = false;
    }
  };
  void clearLinks() {
    //links = new ArrayList<Quad>();
    //links.add(this);
    while (links.size()>1)links.remove(links.size()-1);
    children = new ArrayList<object>();
  };

  boolean pos() {
    return mouseX>p.x&&mouseX<p.x+scene.gW&&mouseY>p.y&&mouseY<p.y+scene.gH;
  };

  void debug() {
    fill(255);
    //text(xpos+" "+ypos,p.x + 10,p.y + gH/2);
    text(links.size() + " " + children.size(), p.x + 10, p.y + scene.gH/2);
    if (pos()) {
      for (int i=0; i<links.size(); i++) {
        Quad q = links.get(i);
        q.fillc();
      }
    }
  };
};
