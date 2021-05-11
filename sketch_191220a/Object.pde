class object{
  
  PVector a,v,p;
  float xpos,ypos,id,x,y,r;
  color col= color(0);
  boolean collide = false, update = false, ext = false;
  ArrayList<Integer> iid = new ArrayList<Integer>();
  ArrayList<Quad> neighbours = new ArrayList<Quad>();
  ArrayList<Quad> currentLinks = new ArrayList<Quad>();
  int t,range,gid;
  Scene scene;
  Entity parent;
  
  object(PVector P,int ID){
    
    p = P;
    a = new PVector();
    v = new PVector();
    id = ID;
    
  };
  
  object(PVector P, int ID,Entity e) {
    
    p = P;
    a = new PVector();
    v = new PVector();
    id = ID;
    scene = e.scene;
    r = e.scene.R*2;
    parent = e;
  };
  
  void update(){
    float W = parent.scene.w;
    float H = parent.scene.h;
    if(p.x>W)p.x = 1;
    if(p.x<0)p.x = W-1;
    if(p.y>H)p.y = 1;
    if(p.y<0)p.y = H-1;
    
    x = p.x;y = p.y;
    xpos = floor(p.x/parent.scene.gw);
    ypos = floor(p.y/parent.scene.gh);
    int pos = int(xpos + ypos * (parent.scene.cols));
    
    if(iid.size()==2&&iid.get(0)!=pos)update = true;
    else update = false;
    
    boolean k = iid.contains(pos);
    
    if(iid.size()==0)iid.add(pos);
    else if(iid.get(iid.size()-1)!=pos)iid.add(pos);
    
    if(iid.size()>2)iid.remove(0); 
    if(pos<parent.scene.qgrid.size())gid = pos;
    //if(update){
    //println(1, id ,pos);
    //if(iid.size()==2)println(0 , id, iid.get(0));
    //}
  };
  
  void updateQgrid(){
    
    //updates the corresponding qgrid array's children with the last id in the iid arraylist
    
    // iid is either of length 1 at the start or of length 2 any time after. If iid is size 2 then you need to check if the perticle crosses a border at anytime by comparing iid(0)
    // and iid(1), if they are different then the particle has crossed a border. Therefore update the corresponding previous grid space by removing this id, and update the new grid
    // space by adding the id.
    
    if(iid.size()==2&&update){
    //boolean a = qgrid.get(gid).children.contains(this);
    ArrayList<Quad> qgrid = parent.scene.qgrid;
    boolean b = qgrid.get(iid.get(0)).children.contains(this);
    //if(!a){
    //  //qgrid.get(iid.get(1)).children.add(this);
    //  //qgrid.get(iid.get(1)).fillc();
    //  }
    if (b){
      int k = qgrid.get(iid.get(0)).children.indexOf(this);
      qgrid.get(iid.get(0)).children.remove(k);
      Quad q = qgrid.get(iid.get(0));
      for(int i=q.xpos-range;i<=q.xpos+range;i++){
        for(int j=q.ypos-range;j<=q.ypos+range;j++){
          if(int(i+j*parent.scene.cols)!=iid.get(0)&&int(i+j*parent.scene.cols)<qgrid.size()&&int(i+j*parent.scene.cols)>0){
            Quad q1 = qgrid.get(int(i+j*parent.scene.cols));
            //if(id==0)println(q.id);
              if(q1.links.contains(q))q1.links.remove(q1.links.indexOf(q));
            }
      }}}}
    //if(iid.size()==1){
    //boolean a = qgrid.get(iid.get(0)).children.contains(this);
    //if(!a){
    //  //qgrid.get(iid.get(0)).fillc();
    //  qgrid.get(iid.get(0)).children.add(this);
    //}}
  };
  
  void move(){
    
    float k = 0.1;
    a.x = random(-k,k);
    a.y = random(-k,k);
    
    v.add(a);
    v.limit(2);
    
    p.add(v);
    x = p.x;
    y = p.y;
  };
  
  void draw(){
    stroke(0);
    fill(0); 
    if(collide)fill(255); 
    //if(update)fill(255,0,0);
    ellipse(p.x,p.y,r,r);
  };
  
  void getNeighbours2(int k){
    range = k;
    int pos = gid;
    //if(update){
    //if(id%10==0)println("neighbours",neighbours.size(),pos);
    ArrayList<Quad> qgrid = parent.scene.qgrid;
    ArrayList<Quad> n = new ArrayList<Quad>();
    Quad myTile = qgrid.get(pos);
      
      
      for(int i=floor(xpos-k);i<=xpos+ k;i++){
        for(int j=floor(ypos-k);j<=ypos+ k;j++){
          
          if(int(i+j*parent.scene.cols)<qgrid.size()&&int(i+j*parent.scene.cols)>0){
            Quad q = qgrid.get(int(i+j*parent.scene.cols));
              if(!n.contains(q))n.add(q);
              if(q.id==pos&&!q.children.contains(this))q.children.add(this);
              
              if(q!=myTile&&!q.links.contains(myTile)){
                q.links.add(myTile);
              }}
    }}
    //if(id%10==0)println(n.size());
    neighbours = n;
     // }
  };
  
  void collisions2(){
    t = 0;
    ArrayList<Quad> n = new ArrayList<Quad>();
    
    for(int i=0;i<neighbours.size();i++){
      Quad a = neighbours.get(i);
      for(int j=0;j<a.links.size();j++){
        if(a.links.size()>1&&!n.contains(a.links.get(j)))n.add(a.links.get(j));
        
      }}
      currentLinks = n;
        for(int k=0;k<n.size();k++){
          //if(id%10==0)println("children",n.get(k).children.size());
          for(int i=0;i<n.get(k).children.size();i++){
          object b = n.get(k).children.get(i);
        
          float d = dist(x,y,b.x,b.y);
          
          if (d<r&&b!=this){
            t++;
            b.collide = true;
            //break;
      }}}
    
    if(t==0)collide = false;
    else collide = true;
  };
  
};
