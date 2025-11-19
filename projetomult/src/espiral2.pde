float x = width*5;
float y = height*5;
float angle ;
float dia = 20;

void espiral_2() {
 background(0);
 fill(255);     rect(0,height*0.91, 300,100);    fill(0);  textSize(25); text("voltar", 0 + 110,height*0.91 + 55);
 fill(255);     rect(width*0.85,height*0.91, 300,100);    fill(0);  textSize(25); text("proximo", width*0.85 + 100,height*0.91 + 55); 
 
 translate(width/2,height/2);
 rotate(radians(angle/3));
 for(float a=0; a<360; a+=10) {
  pushMatrix();
  rotate(radians(a));
  stroke(rStroke,0,100);
  strokeWeight(3);
  line(x*sin(radians(angle)), 0, 0, y-dia/2);
  
  noStroke();
  fill(0,100,rStroke);
  ellipse(x*sin(radians(angle)), 0, dia/2, dia/2);
  stroke(100,rStroke,0);
  ellipse(0,y,dia,dia);
  popMatrix();
 }
 angle++;
}
