Firework[] fs = new Firework[10];
float x, y, oldX, oldY, ySpeed, targetX, targetY, explodeTimer, flareWeight, flareAngle;
int flareAmount, duration;
boolean launched, exploded, hidden;
//Colors are randomized by default
color flare=color(random(3)*50 + 105, random(3)*50 + 105, random(3)*50 + 105);
color newFlare=color(random(3)*50 + 105, random(3)*50 + 105, random(3)*50 + 105);
boolean once;
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

  fill(255, 82, 82);//Red button
  rect(710, 50, 35, 35);//Left colum placement at 710

  fill(255, 166, 76);//Orange button
  rect(755, 50, 35, 35);//Right colum placement at 755

  fill(255, 251, 127);//Yellow button
  rect(710, 95, 35, 35);//Space vertically by 45

  fill(144, 238, 144);//Green button
  rect(755, 95, 35, 35);

  fill(135, 206, 235);//Blue button
  rect(710, 140, 35, 35);

  fill(238, 130, 238);//Purple button
  rect(755, 140, 35, 35);

  fill(255, 255, 255);//Random color button
  rect(709, 185, 82, 35);

  fill(0, 0, 0);//"Random" text color
  text("Random color", 709.30, 205);

  for (int i = 0; i < fs.length; i++) {
    fs[i].draw();
  }
}
void mousePressed() {//Launches fireworks and checks for buttons
  once = false;
  if (mouseX>=710 && mouseX<=745 && mouseY>=50 && mouseY<=85) {//Red button
    if (mousePressed) {
      stroke(255);
      rect(710, 50, 35, 35);
      newFlare = color(255, 82, 82);//All of the colors are a lighter shade to avoid persisting streak marks
      flare=newFlare;
    }
  }
  if (mouseX>=755 && mouseX<=790 && mouseY>=50 && mouseY<=85) {//Orange button
    if (mousePressed) {
      stroke(255);
      rect(755, 50, 35, 35);
      newFlare = color(255, 166, 76);
      flare=newFlare;
    }
  }
  if (mouseX>=710 && mouseX<=745 && mouseY>=95 && mouseY<=130) {//Yellow button
    if (mousePressed) {
      stroke(255);
      rect(710, 95, 35, 35);
      newFlare = color(255, 251, 127);
      flare=newFlare;
    }
  }
  if (mouseX>=755 && mouseX<=790 && mouseY>=95 && mouseY<=130) {//Green button
    if (mousePressed) {
      stroke(255);
      rect(755, 95, 35, 35);
      newFlare = color(144, 238, 144);
      flare=newFlare;
    }
  }
  if (mouseX>=710 && mouseX<=745 && mouseY>=140 && mouseY<=175) {//Blue button
    if (mousePressed) {
      stroke(255);
      rect(710, 140, 35, 35);
      newFlare = color(135, 206, 235);
      flare=newFlare;
    }
  }
  if (mouseX>=755 && mouseX<=790 && mouseY>=140 && mouseY<=175) {//Purple button
    if (mousePressed) {
      stroke(255);
      rect(755, 140, 35, 35);
      newFlare = color(238, 130, 238);
      flare=newFlare;
    }
  }
  if (mouseX>=709 && mouseX<=791 && mouseY>=185 && mouseY<=220) {//Random color button
    if (mousePressed) {
      stroke(255);
      rect(709, 185, 82, 35);
      newFlare = color(random(3)*50 + 105, random(3)*50 + 105, random(3)*50 + 105);
      flare=newFlare;
    }
  }
  if (mouseX<700) {//Allows for launch if the mouse is to the left of the divider
    for (int i = 0; i < fs.length; i++) {
      if ((fs[i].hidden)&&(!once)) {
        fs[i].launch();
        once = true;
      }
    }
  }
}
class Firework {
  float x, y, oldX, oldY, ySpeed, targetX, targetY, explodeTimer, flareWeight, flareAngle;
  int flareAmount, duration;
  boolean launched, exploded;
  boolean onButton, withinButton, onRed, onOrange, onYellow, onGreen, onBlue, onPurple;
  color flare=color(random(3)*50 + 105, random(3)*50 + 105, random(3)*50 + 105);
  boolean hidden;
  Firework() {
    launched = false;
    exploded = false;
    hidden = true;
  }
  void draw() {//Draws each firework
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
  }
  void launch() {
    x = oldX = mouseX + ((random(5)*10) - 25);
    y = oldY = height;
    targetX = mouseX;
    targetY = mouseY;
    ySpeed = random(4) + 2;
    flare=newFlare;
    flareAmount = ceil(random(30)) + 20;
    //Always makes the flare split even
    while (360%flareAmount!=0) {
      if (360%flareAmount!=0) {
        flareAmount = ceil(random(30)) + 20;
      }
    }
    flareWeight = ceil(random(2));
    duration = ceil(random(4))*20 + 30;
    flareAngle = 360/flareAmount;
    launched = true;
    exploded = false;
    hidden = false;
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
  }
}
