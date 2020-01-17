import fisica.*;
FWorld world;

boolean leftCanJump,rightCanJump;
boolean wkey,akey,dkey;
FCircle lplayer, rplayer,ball;
FBox lground,rground,lwall,rwall,net;
void setup(){
   Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 980);
  size(800,600);

lground= new FBox(400,100);
lground.setNoStroke();
lground.setPosition(200,575);
lground.setStatic(true);
lground.setFill(#EBC288);
world.add(lground);

rground = new FBox(400,100);
rground.setNoStroke();
rground.setPosition(600,575);
rground.setStatic(true);
rground.setFill(#EBC288);
  world.add(rground);
  
  
  lplayer= new FCircle(50);
  lplayer.setNoStroke();
  lplayer.setPosition(200,400);
  lplayer.setFill(0);
  world.add(lplayer);
  
    rplayer= new FCircle(50);
  rplayer.setNoStroke();
  rplayer.setPosition(600,400);
  rplayer.setFill(0);
  world.add(rplayer);
  
  
  
}

void draw(){

  background(255);

  leftCanJump=false;
  lplayer.getContacts();
  ArrayList<FContact> contacts=lplayer.getContacts();
  
  int i=0;
  while(i<contacts.size()){
    FContact c=contacts.get(i);
    if(c.contains(lground)) leftCanJump=true;
    i++;
  }
  
  println(leftCanJump);
  
  if(wkey&&leftCanJump) lplayer.addImpulse(0,-2000);
  if(akey) lplayer.addImpulse(-100,0);
  if(dkey) lplayer.addImpulse(100,0);
  
  world.step();
  world.draw();
}

void keyPressed(){
  if(key=='w'||key=='W') wkey=true;
  if(key=='a'||key=='A') akey=true;
  if(key=='d'||key=='D') dkey=true;
}

void keyReleased(){
    if(key=='w'||key=='W') wkey=false;
  if(key=='a'||key=='A') akey=false;
  if(key=='d'||key=='D') dkey=false;
}
