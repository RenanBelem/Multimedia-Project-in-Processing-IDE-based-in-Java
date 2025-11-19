// criação da espiral
void espiral() {
  background(0);
  fill(255);     rect(0,height*0.91, 300,100);    fill(0);  textSize(25); text("voltar", 0 + 110,height*0.91 + 55);
  fill(255);     rect(width*0.85,height*0.91, 300,100);    fill(0);  textSize(25); text("proximo", width*0.85 + 100,height*0.91 + 55); 

  translate(width/2,height/2);
  
  // definição do movimento das retas pela posição do mouse
  float wave = sin(radians(frameCount));
  float w = wave*map(mouseX,0,height,2500,0);
  
  for (int i = 0; i <500; i++) {
    rotate(rAngle); // angulo da espiral aleatorio
    
    stroke(255); // cor preta para uma das retas
    line(850,i-w/2, -850, i++); // linha 1
    strokeWeight(map(wave,-1,1,0.5,rStrokeSize));
    
    stroke(0,0,rStroke); // cor de tom azul aleatoria
    strokeWeight(map(wave,-1,1,0.5,rStrokeSize));
    line(-850,-i+w,550,i++); // linha 2
    
    stroke(255,0,0); // cor vermelha 
    line(-850,i-w,850,i++); // linha 3
    
  }
}
