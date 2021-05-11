Entity e;

void settings(){
  size(W,H,FX2D);
  
};

void setup(){
  e = new Entity(this,20);
  
};



float min = 1000;

void draw(){
  //frameRate(10);
  background(42);
  
  e.draw();
  
  fill(255,0,0);
  if(mousePressed)
  fill(255);
  
  text(frameRate,60,20);
};



void mousePressed(){
  if(mouseButton == LEFT){
  toggle ++;
  
  if(toggle==2){
   toggle = 0; 
  }
  if(toggle==1){
    toggle2++;
  }}
};

void debud(){
  if(mousePressed&&mouseButton == RIGHT && frameRate <min) min = frameRate;
};
