// pontilhismo da fenix
void fenix() {
  background(0);
      fill(255);     rect(0,height*0.91, 300,100);    fill(0);  textSize(25); text("voltar", 0 + 110,height*0.91 + 55);
  
  // pintura do fundo
  fill(58, 36, 35);
  noStroke();
  float tiles1 = mouseX/10;
  float tileSize1 = width/tiles1;
  translate(tileSize1/2,tileSize1/2);
  for (int x = 0; x < tiles1; x++) {
    for (int y = 0; y < tiles1; y++) {
      color c = img.get(int(x*tileSize1),int(y*tileSize1));
      float size = map(brightness(c),0,100,tileSize1,0);    
      ellipse(x*tileSize1, y*tileSize1, size, size);
    }
  }
  
  //pintura em amerelo
   fill(255, 200, 0);
  noStroke();
  float tiles2 = mouseX/10;
  float tileSize2 = width/tiles2;
  translate(tileSize2/2,tileSize2/2);
  for (int x = 0; x < tiles2; x++) {
    for (int y = 0; y < tiles2; y++) {
      color c = img.get(int(x*tileSize2),int(y*tileSize2));
      float size = map(brightness(c),255,0,tileSize2,0);    
      ellipse(x*tileSize2, y*tileSize2, size, size);
    }
  }
  
  // finalização da pintura em vermelho
  fill(255);     rect(width*0.85,height*0.91, 300,100);    fill(0);  textSize(25); text("proximo", width*0.85 + 100,height*0.91 + 55); 
    fill(255,0,0);
  noStroke();
  float tiles = mouseX/10;
  float tileSize = width/tiles;
  translate(tileSize/2,tileSize/2);
  for (int x = 0; x < tiles; x++) {
    for (int y = 0; y < tiles; y++) {
      color c = img.get(int(x*tileSize),int(y*tileSize));
      float size = map(brightness(c),225,0,tileSize,0);    
      ellipse(x*tileSize, y*tileSize, size, size);
    }
  }
}
