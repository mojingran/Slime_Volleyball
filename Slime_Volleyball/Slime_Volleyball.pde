import fisica.*;
FWorld world;

boolean leftCanJump, rightCanJump;
boolean wkey, akey, dkey,upkey,leftkey,rightkey;
FCircle lplayer, rplayer, ball;
color blue   = color(29, 178, 242);
color brown  = color(166,120,24);
color green  = color(74,163,57);
color red    = color(224, 80, 61);
color yellow = color(242, 215, 16);
int lscore,rscore,timer;
FBox lground, rground, lwall, rwall, net,ceiling;
PImage sunset,eightball,water;
void setup() {
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 980);
  sunset=loadImage("sunset.jpg");
  eightball= loadImage("eightball.png");
  water=loadImage("water.jpg");
  sunset.resize(800,600);
  eightball.resize(20,20);
  water.resize(400,100);
  size(800, 600);
  timer=60;
  lground= new FBox(400, 100);
  lground.setNoStroke();
  lground.setPosition(200, 575);
  lground.setStatic(true);
  lground.attachImage(water);
  world.add(lground);

  rground = new FBox(400, 100);
  rground.setNoStroke();
  rground.setPosition(600, 575);
  rground.setStatic(true);
  rground.attachImage(water);
  world.add(rground);


  lplayer= new FCircle(70);
  lplayer.setNoStroke();
  lplayer.setPosition(200, 400);
  lplayer.setFill(0);
  world.add(lplayer);

  rplayer= new FCircle(70);
  rplayer.setNoStroke();
  rplayer.setPosition(600, 400);
  rplayer.setFill(0);
  world.add(rplayer);

  lwall= new FBox(50, 1200);
  lwall.setStatic(true);
  lwall.setFill(0);
  lwall.setPosition(-25, 0);
  world.add(lwall);

  rwall= new FBox(50, 1200);
  rwall.setStatic(true);
  rwall.setFill(0);
  rwall.setPosition(825, 0);
  world.add(rwall);
  
  net= new FBox(25,200);
  net.setStatic(true);
  net.setFill(0);
  net.setPosition(400,550);
  world.add(net);
  
  
  ball=new FCircle(20);
  ball.setFillColor(blue);
  ball.setRestitution(1);
  ball.setPosition(lplayer.getX(),100);
  world.add(ball);
  
  ceiling= new FBox(800,100);
  ceiling.setPosition(400,-50);
  ceiling.setStatic(true);
  world.add(ceiling);
}

void draw() {
 timer--;
 if(timer<0){
  background(sunset);
  fill(255);
  textSize(50);
  
  leftCanJump=false;
  rightCanJump=false;
  lplayer.getContacts();
  ArrayList<FContact> contacts=lplayer.getContacts();

  int i=0;
  while (i<contacts.size()) {
    FContact c=contacts.get(i);
    if (c.contains(lground)) leftCanJump=true;
    i++;
  }
  ArrayList<FContact> contacts2=rplayer.getContacts();

 int j=0;
  while (j<contacts2.size()) {
    FContact c=contacts2.get(j);
    if (c.contains(rground)) rightCanJump=true;
    j++;
  }
  ArrayList<FContact> contacts3=ball.getContacts();
  int k=0;
  while(k<contacts3.size()){
   FContact c=contacts3.get(k);
   if(c.contains(rground)){
     lscore++;
     ball.setPosition(lplayer.getX(),200);
    ball.setVelocity(0,0);
    timer=60;
   }
   if(c.contains(lground)){
     rscore++;
     ball.setPosition(rplayer.getX(),200);
      ball.setVelocity(0,0);
      timer=60;
   }
    k++;
  }
  if(lplayer.getX()>=375) lplayer.setPosition(375,lplayer.getY());
 if(rplayer.getX()<=425) rplayer.setPosition(425,rplayer.getY());
  if (wkey&&leftCanJump) lplayer.addImpulse(0, -2000);
  if (upkey&&rightCanJump) rplayer.addImpulse(0, -2000);
  if (akey) lplayer.addImpulse(-300, 0);
  if (dkey) lplayer.addImpulse(300, 0);
 if(leftkey) rplayer.addImpulse(-300,0);
 if(rightkey) rplayer.addImpulse(300,0);
  world.step();
  world.draw();
 }
 text("LEFT:"+lscore,100,100);
  text("RIGHT:"+rscore,500,100);
if(lscore==3){
 text("LEFT WINS",250,300);
 timer=100;
 timer++;
 text("Click anywhere to restart",250,500);
 if(mousePressed){lscore=0;rscore=0;timer=60;}
}
if(rscore==3){
 text("RIGHT WINS",250,300);
 text("click anywhere to restart",250,500);
 if(mousePressed){lscore=0;rscore=0;timer=60;}
 timer=100;
 timer++;
}
}

void keyPressed() {
  if (key=='w'||key=='W') wkey=true;
  if (key=='a'||key=='A') akey=true;
  if (key=='d'||key=='D') dkey=true;
  if(keyCode==UP) upkey=true;
  if(keyCode==LEFT) leftkey=true;
  if(keyCode==RIGHT) rightkey=true;
}

void keyReleased() {
  if (key=='w'||key=='W') wkey=false;
  if (key=='a'||key=='A') akey=false;
  if (key=='d'||key=='D') dkey=false;
  if(keyCode==UP) upkey=false;
  if(keyCode==LEFT) leftkey=false;
  if(keyCode==RIGHT) rightkey=false;
}
