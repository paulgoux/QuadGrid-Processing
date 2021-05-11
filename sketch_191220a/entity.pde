class Entity {
  PApplet applet;
  int total;
  ArrayList<object> grid  = new ArrayList<object>();
  ArrayList<Scene> scenes  = new ArrayList<Scene>();
  Scene scene;

  Entity() {
  }

  Entity(PApplet P) {
    applet = P;
    scene = new Scene(0,0,applet.width,applet.height,this);
    pop();
  };
  
  Entity(PApplet P,int a) {
    applet = P;
    scene = new Scene(0,0,applet.width,applet.height,this);
    pop(a);
  };

  void draw() {
    //mouse();
    for (int i=0; i<grid.size(); i++) {
      object c = grid.get(i);
      if (toggle==1) {
        c.move();
      }
      c.update();
      c.draw();
      //c.updates();
      c.getNeighbours2(1);
      c.collisions2();
      //c.updateQgrid();
    }
    clearLinks();
    mouse();
    //scene.field();
  };

  void clearLinks() {
    for (int i=scene.qgrid.size()-1; i>-1; i--) {
      Quad q = scene.qgrid.get(i);
      q.draw();
      if (q.links.size()>1)q.clearLinks();
    }
  };

  void mouse() {
    int k = floor(applet.mouseX/scene.gw) + floor(applet.mouseY/scene.gh) * int(scene.cols);

    if(k<scene.qgrid.size())scene.qgrid.get(k).fillc();
    fill(255, 0, 0);
    text(floor(applet.mouseX/scene.gw) + floor(applet.mouseY/scene.gh) * scene.gw, applet.mouseX, applet.mouseY);
  }

  void pop() {

    for (int i=0; i<total; i++) {
      PVector a = new PVector(applet.random(applet.width), applet.random(applet.height));

      grid.add(new object(a, i,this));
    }
  };
  
  void pop(int n) {

    for (int i=0; i<n; i++) {
      PVector a = new PVector(applet.random(W), applet.random(H));

      grid.add(new object(a, i,this));
    }
  };
};
