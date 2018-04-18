import processing.serial.*; 
 
Serial port;
int[] ch1, ch2;
int ch1Index = 0, ch2Index = 0;
boolean isCh1 = false;

long count = 0;

void setup() { 
  size(800, 600);
  background(0);
  frameRate(300);
  ch1 = new int[width];
  ch2 = new int[width];
  port = new Serial(this, 115200); 
  // Draw Table
  for (int i = 0; i < width; i+=100) {
    stroke(255, 100);
    line(i, 0, i, height);
  }
  for (int i = 0; i < width; i+=100) {
    stroke(255, 100);
    line(0, i, width, i);
  }
} 

void draw() { 
  if (isCh1) {
    if (0 < port.available()) {
      ch1[ch1Index] = port.read();
    }
    ch1Index++;
  } else {
    if (0 < port.available()) {
      ch2[ch2Index] = port.read();
    }
    ch2Index++;
  }
  if (ch1Index >= width && ch2Index >= width) {
    background(0);
    // Draw Wave
    for (int i = 0; i < width; i+=100) {
      stroke(255, 100);
      line(i, 0, i, height);
    }
    for (int i = 0; i < width; i+=100) {
      stroke(255, 100);
      line(0, i, width, i);
    }
    for (int i = 0; i < ch1.length-1; i++) {
      stroke(0, 0, 255);
      strokeWeight(3);
      line(i, (height/2) - ch1[i] * (height/3) / 4096, i+1, (height/2) - ch1[i+1] * (height/3) / 4096);
    }
    for (int i = 0; i < ch2.length-1; i++) {
      stroke(0, 255, 0);
      strokeWeight(3);
      line(i, (height/2) - ch2[i] * (height/3) / 4096, i+1, (height/2) - ch2[i+1] * (height/3) / 4096);
    }
    ch1Index = 0;
    ch2Index = 0;
  }
  isCh1 = !isCh1;
} 