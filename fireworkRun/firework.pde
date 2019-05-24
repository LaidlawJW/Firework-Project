Firework[] f=new Firework [10];
int red;
int green;
int blue;

float expand;
int mouseXPos=mouseX;
int mouseYPos=mouseY;

int angle1=0;

void setup() {
  size(700, 400);
  smooth();
  background(51);
  for (int i=0; i<f.length; i++) {
    f[i]=new Firework();
  }
}

void draw() {//Draws buttons
  noStroke();
}

void mousePressed() {//Different functions when clicked in certain areas
}

class Firework {
  float xPos, yPos, oldX, oldY, ySpeed, targetX, targetY, explodeTime, flareAngles;
  int flareAmount, duration;
  color flare;
  boolean loop;
  boolean onButton;
  boolean launched;
  boolean exploded;
  boolean hidden;
  Firework() {
    loop=false;
    onButton=false;
    launched=false;
    exploded=false;
    hidden=false;
  }

  void draw() {//Draws fireworks
    if ((launched)&&(!exploded)&&(!hidden)&&(!onButton) {
      launchMath();
      strokeWeight(3);
      stroke(255);
      line(xPos, yPos, oldX, oldY);

      if ((!launched)&&(exploded)&&(!hidden)) {
        explodeMath();
        noStroke();
        stroke(flare);
        for (int i=0; i<flareAmount+1; i++) {
          pushMatrix();
          translate(x, y);
          point(sin(radians(i*flareAngles))*explodeTime, cos(radians(i*flareAngles))*explodeTime);
          popMatrix();
        }
      }
      if ((!launched)&&(!exploded)&&(hidden)) {
        //Do nothing here
      }
    }
    void launch() {
      xPos=oldX=mouseX;
      yPos=oldY=height;
      targetX=mouseX;
      targetY=mouseY;
      ySpeed=5;
      //Implement flare color/amount/weight here (buttons)
      flareAngle=360/flareAmount;
      launched=true;
      exploded=false;
      hidden=false;
  }
}
