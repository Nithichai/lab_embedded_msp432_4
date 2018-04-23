import processing.serial.*; 
 
Serial port;
int[] ch1, ch2;
int showIndex = 0;
boolean isCh1 = false;

long count = 0;

void setup() { 
  size(800, 600);
  background(0);
  frameRate(300);
  ch1 = new int[width];
  ch2 = new int[width];
  port = new Serial(this, "COM8", 115200); 
  port.bufferUntil('\n');
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

void draw(){
  if (port.available() > 0) {
    String txt = port.readStringUntil('\n');
    String[] ls = split(txt, ' ');
    if (txt != null)
      ch1[showIndex] = Integer.parseInt(ls[0].trim());
    if (txt != null)
      ch2[showIndex] = Integer.parseInt(ls[1].trim());
      
      
    stroke(0, 0, 255);
    strokeWeight(3);
    if (showIndex == 0)
      point(showIndex, (height/2) - ch1[showIndex] * (height/2) / 4096);
    else
      line(showIndex, (height/2) - ch1[showIndex-1] * (height/2) / 4096, showIndex, (height/2) - ch1[showIndex] * (height/2) / 4096);
    
    stroke(0, 255, 0);
    strokeWeight(3);
    if (showIndex == 0)
      point(showIndex, (height/2) - ch2[showIndex] * (height/2) / 4096);
    else
      line(showIndex, (height/2) - ch2[showIndex-1] * (height/2) / 4096, showIndex, (height/2) - ch2[showIndex] * (height/2) / 4096);
    
    showIndex++;
    
    if (showIndex >= width) {
      showIndex = 0;
      ch1 = new int[width];
      ch2 = new int[width];  
      background(0);
      stroke(255, 100);
      strokeWeight(1);
      for (int i = 0; i < width; i+=100) {
        line(i, 0, i, height);
      }
      for (int i = 0; i < width; i+=100) {
        line(0, i, width, i);   
      }
    }
  }
}