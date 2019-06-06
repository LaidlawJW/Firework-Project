## Firework-Project: 
A studio that lets a user customize and launch their own fireworks.

There a large clickable area in the program that will trigger the launch of a firework. Up to ten fireworks can be exploding on screen at a time. The color of the flare starts a randomly generated color. In an area to the right of the screen, ther is an area in which fireworks cannot be launched. n this area there are seven buttons. One for the colors of red, orange, yellow, green, blue, purple, and a button that creates a random color. 

### Difficulties or opportunities encountered along the way.

The toughest part was getting the area past the drawn divider to not allow for a firework launch. Another difficult part was getting the flare color to default to a random color instead of black. The black color, or any other dark color, would leave permanent streak marks on the screen, which is my the button options for colors are in lighter shades. 

### Most interesting piece of your code and explanation for what it does:

if (mouseX<700) {//Allows for launch if the mouse is to the left of the divider
    for (int i = 0; i < fs.length; i++) {
      if ((fs[i].hidden)&&(!once)) {
        fs[i].launch();
        once = true;
      }
    }
  }
  
  This section of code is what prevent a firework from being launched in the area past the drawn divider. It is what allows each button to work properly, without firework flares blocking anything. 

* [Processing](https://processing.org/) - This was the IDE used

Project made by Justin Laidlaw. 

### Acknowledgments

Some code (especially the math behind the fireworks) was borrowed and then modified. The borrowed code is by Anders Fisher at https://www.openprocessing.org/sketch/17259/
