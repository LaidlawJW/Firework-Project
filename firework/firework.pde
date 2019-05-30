Firework[] fs = new Firework[10];
boolean once;
//For color changes
int r;
int g;
int b;
//For click location checks
float mouseXPos=mouseX;
float mouseYPos=mouseY;

void setup() {
  size(800, 600);
  smooth();
  for (int i = 0; i < fs.length; i++) {
    fs[i] = new Firework();
  }
}
void draw() {//Draws background and buttons
  noStroke();
  fill(50, 50, 50, 20);//Background color
  rect(0, 0, width, height);//Background shape

  stroke(255);//Divider color
  line(700, 0, 700, 600);
  noStroke();//Removes button outlines

  fill(255, 255, 255);//"Colors:" text color
  text("Colors:", 729, 25);

  fill(255, 0, 0);//Red button
  rect(710, 50, 35, 35);//Left colum placement at 710

  fill(255, 165, 0);//Orange button
  rect(755, 50, 35, 35);//Right colum placement at 755

  fill(255, 255, 0);//Yellow button
  rect(710, 95, 35, 35);//Space vertically by 45

  fill(50, 205, 50);//Green button
  rect(755, 95, 35, 35);

  fill(30, 144, 255);//Blue button
  rect(710, 140, 35, 35);

  fill(138, 43, 226);//Purple button
  rect(755, 140, 35, 35);

  fill(255, 255, 255);//Random color button
  rect(709, 185, 82, 35);

  fill(0, 0, 0);//"Random" text color
  text("Random color", 710, 205);

  fill(255, 0, 0);//Loop button
  rect(709, 265, 82, 35);

  fill(255, 255, 255);//"Loop Pattern" text color
  text("Loop Pattern", 713, 260);

  fill(255, 255, 255);//Speed - button
  rect(709, 340, 38, 35);

  fill(255, 255, 255);//Speed + button
  rect(754, 340, 38, 35);

  fill(0, 0, 0);//"-" text color
  text("-", 724, 362);

  fill(0, 0, 0);//"+" text color
  text("+", 768, 362);

  fill(255, 255, 255);//"Speed:" text color
  text("Speed:", 709, 330);

  for (int i = 0; i < fs.length; i++) {
    fs[i].draw();
  }
}
void mouseReleased() {//Launches fireworks
  once = false;
  for (int i = 0; i < fs.length; i++) {
    if ((fs[i].hidden)&&(!once)) {
      fs[i].launch();
      once = true;
    }
  }
}
class Firework {
  float x, y, oldX, oldY, ySpeed, targetX, targetY, explodeTimer, flareWeight, flareAngle;
  int flareAmount, duration;
  boolean launched, exploded, hidden, onButton;
  color flare;
  Firework() {
    launched = false;
    exploded = false;
    hidden = true;
  }
  void draw() {//Draws each firework and does click location checks for buttons
    fill(255, 255, 255);//Speed: value text
    text(ySpeed, 751, 330);
    if ((launched)&&(!exploded)&&(!hidden)) {
      launchMaths();
      strokeWeight(1);
      stroke(255);
      line(x, y, oldX, oldY);
    }
    if ((!launched)&&(exploded)&&(!hidden)) {
      explodeMaths();
      noStroke();
      strokeWeight(flareWeight);
      stroke(flare);
      for (int i = 0; i < flareAmount + 1; i++) {
        pushMatrix();
        translate(x, y);
        point(sin(radians(i*flareAngle))*explodeTimer, cos(radians(i*flareAngle))*explodeTimer);
        popMatrix();
      }
    }
    if ((!launched)&&(!exploded)&&(hidden)) {
      //Do nothing
    }
    //Begin button click location checks
  }
  void mousePressed() {
    if (mouseXPos>=700) {//Within divider
      launched = false;
      exploded = false;
      hidden = true;
      if (mouseXPos>=710 && mouseXPos<=745 && mouseYPos>=50 && mouseYPos<=85) {//On red button
        onButton=true;
        flare=color(255, 0, 0);
      }
    }
  }
  void launch() {
    x = oldX = mouseX + ((random(5)*10) - 25);
    y = oldY = height;
    targetX = mouseX;
    targetY = mouseY;

    //Make speed into a button and click location check
    ySpeed = random(3) + 2;

    //Make flare into several color buttons and click location checks
    flare = color(random(3)*50 + 105, random(3)*50 + 105, random(3)*50 + 105);//Use this for random color button

    flareAmount = ceil(random(30)) + 20;
    //Always makes the flare split even
    while (360%flareAmount!=0) {
      if (360%flareAmount!=0) {
        flareAmount = ceil(random(30)) + 20;
      }
    }
    flareWeight = ceil(random(3));
    duration = ceil(random(4))*20 + 30;
    flareAngle = 360/flareAmount;
    launched = true;
    exploded = false;
    hidden = false;
    onButton=false;
  }
  void launchMaths() {
    oldX = x;
    oldY = y;
    if (dist(x, y, targetX, targetY) > 6) {
      x += (targetX - x)/2;
      y += -ySpeed;
    } else {
      explode();
    }
  }
  void explode() {
    explodeTimer = 0;
    launched = false;
    exploded = true;
    hidden = false;
    onButton=false;
  }
  void explodeMaths() {
    if (explodeTimer < duration) {
      explodeTimer+= 0.4;
    } else {
      hide();
    }
  }
  void hide() {
    launched = false;
    exploded = false;
    hidden = true;
    onButton=false;
  }
}
