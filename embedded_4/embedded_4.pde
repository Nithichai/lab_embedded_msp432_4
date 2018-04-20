import processing.serial.*; 
 
Serial port;
int[] ch1, ch2;
int showIndex = 0;
boolean isCh1 = false;

long count = 0;

void setup() { 
  size(800, 600);
  background(0);
  frameRate(100);
  ch1 = new int[width];
  ch2 = new int[width];
  port = new Serial(this, "COM8", 115200); 
  // Draw Table
  stroke(255, 100);
  strokeWeight(1);
  for (int i = 0; i < width; i+=100) {
    line(i, 0, i, height);
  }
  for (int i = 0; i < width; i+=100) {
    line(0, i, width, i);
  }
} 

void draw() {
  if (0 < port.available()) {
    String txt = port.readStringUntil('\n');
    if (txt != null)
      ch1[showIndex] = Integer.parseInt(txt.trim());
    txt = port.readStringUntil('\n');
    if (txt != null)
      ch2[showIndex] = Integer.parseInt(txt.trim());
    showIndex++;
  }
  
  //background(0);
  //stroke(255, 100);
  //strokeWeight(1);
  //for (int i = 0; i < width; i+=100) {
    
  //  line(i, 0, i, height);
  //}
  //for (int i = 0; i < width; i+=100) {
  //  stroke(255, 100);
  //  line(0, i, width, i);
  //}
  //stroke(0, 0, 255);
  //strokeWeight(3);
  //for (int i = 0; i < showIndex-1; i++) {
  //  line(i, (height/2) - ch1[i] * (height/3) / 4096, i+1, (height/2) - ch1[i+1] * (height/3) / 4096);
  //}
  //stroke(0, 255, 0);
  //for (int i = 0; i < showIndex-1; i++) {
  //  strokeWeight(3);
  //  line(i, (height/2) - ch2[i] * (height/3) / 4096, i+1, (height/2) - ch2[i+1] * (height/3) / 4096);
  //}
  
  //if (showIndex >= width) showIndex = 0;
  
  if (0 < port.available()) {
    ch1[showIndex] = Integer.parseInt(port.readStringUntil('\n').trim());
    ch2[showIndex] = Integer.parseInt(port.readStringUntil('\n').trim());
    showIndex++;
  }
  if (showIndex >= width) {
    background(0);
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
    showIndex = 0;
    ch1 = new int[width];
    ch2 = new int[width];
  }
} 