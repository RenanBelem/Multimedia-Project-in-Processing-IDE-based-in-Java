// tela de lasers cobrindo a tela anterior
void laser() {
 image(canvas,0,0);
 canvas.beginDraw();
 canvas.stroke(random(255),random(255),random(255));
 canvas.line(width/2,height/2, random(width), random(height));
 canvas.endDraw();
 
 fill(255);     rect(0,height*0.91, 300,100);    fill(0);  textSize(25); text("voltar", 0 + 110,height*0.91 + 55);
 fill(255);     rect(width*0.85,height*0.91, 300,100);    fill(0);  textSize(25); text("proximo", width*0.85 + 100,height*0.91 + 55); 
 
}
