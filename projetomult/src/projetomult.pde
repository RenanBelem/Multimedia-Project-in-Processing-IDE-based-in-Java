// parte das espirais
float rAngle = random(0.1,30);
float rStroke = random(0,255);
float rStrokeSize = random(0.25,3);

// parte da fenix
PImage img; 
PImage menuF;
int svar = 0;

// parte responsavel pelos lasers
PGraphics canvas;

// parte responsavel pela musica
import ddf.minim.*;
import ddf.minim.analysis.*;
 
Minim minim;
AudioPlayer song;
FFT fft;

// Variáveis que definem as "zonas" do espectro
// Por exemplo, para baixo, pegamos apenas os primeiros 4% do espectro total
float specLow = 0.03; // 3%
float specMid = 0.125;  // 12.5%
float specHi = 0.20;   // 20%

// Portanto, permanece 64% do espectro possível que não será usado.
// De qualquer forma, esses valores geralmente são muito altos para o ouvido humano.

// Pontuação dos valores para cada zona
float scoreLow = 0;
float scoreMid = 0;
float scoreHi = 0;

// Valor anterior, para suavizar a redução
float oldScoreLow = scoreLow;
float oldScoreMid = scoreMid;
float oldScoreHi = scoreHi;

// Valor de suavização
float scoreDecreaseRate = 25;

// Cubos que aparecem no espaço
int nbCubes;
Cube[] cubes;

//Linhas nas paredes
int nbMurs = 500;
Mur[] murs;


// criação do canvas
void setup() {
  fullScreen(P3D); // tamanho de tela
  background(0);
  smooth(); 
  frameRate(1000);
  // fenix setup
  img = loadImage("fenix.png");
  img.resize(width,height);
  menuF = loadImage("menu.png");
  menuF.resize(width,height);
  
  // setup pras linhas
  canvas = createGraphics(width,height);
  canvas.beginDraw();
  canvas.background(0);
  canvas.endDraw();
  
  // setup music
   // carrega biblioteca minimim e a musica
  minim = new Minim(this);
  song = minim.loadFile("song.mp3");
  
  // Crie o objeto FFT para analisar a música
  fft = new FFT(song.bufferSize(), song.sampleRate());
  
  //Um cubo por banda de frequência
  nbCubes = (int)(fft.specSize()*specHi);
  cubes = new Cube[nbCubes];
  
  // Quantas paredes quisermos
  murs = new Mur[nbMurs];

  // Crie todos os objetos
  // Crie os objetos de cubo
  for (int i = 0; i < nbCubes; i++) {
   cubes[i] = new Cube(); 
  }

  // Crie os objetos de parede
  // Paredes esquerdas
  for (int i = 0; i < nbMurs; i+=4) {
   murs[i] = new Mur(0, height/2, 10, height); 
  }
  
  // Paredes laterais
  for (int i = 1; i < nbMurs; i+=4) {
   murs[i] = new Mur(width, height/2, 10, height); 
  }
  
  
  // chão
  for (int i = 2; i < nbMurs; i+=4) {
   murs[i] = new Mur(width/2, height, width, 10); 
  }
  
  // teto
  for (int i = 3; i < nbMurs; i+=4) {
   murs[i] = new Mur(width/2, 0, width, 10); 
  }
  
}

// switch de tela
void draw(){
  if (svar != 5) song.pause();
  if (svar==0) menu();
  if (svar==1) espiral();
  if (svar==2) espiral_2();
  if (svar==3) fenix();
  if (svar==4) laser();
  if (svar==5) music();

}

// menu
void menu(){
 background (menuF);
 fill(255);   rect(width*0.40, height*0.4, 300, 100);  fill(0); textSize(25); text("COMEÇAR", width*0.445, height*0.454);
 fill(255);   rect(0,height*0.91, 300,100);  fill(0); textSize(25); text("SAIR", 0 + 110,height*0.91 + 55);
 
  if (mousePressed) {
    if((mouseX>width*0.40)&&(mouseY>height*0.4)&&(mouseX<width*0.555)&&(mouseY<height*0.5)) svar = 1;
  }
}


// comando para os botões de voltar e proximo
void mousePressed(){
  if (svar >= 1){
    if((mouseX>width*0.85)&&(mouseY>height*0.91)) svar += 1;
    if((mouseX<300)&&(mouseY>height*0.91)) svar -= 1;
  }
  else {
    if((mouseX>0)&&(mouseY>height*0.91)&&(mouseX<300)) exit();
  }
}

void keyPressed() { 
  if (svar >= 1){
  if (key == CODED) { // teste para evitar posição negativa, teste se celula a ir está vazia

   if (keyCode == RIGHT) svar += 1;

   if (keyCode == LEFT) svar -= 1;

  }
  keyPressed=false;
  }
}
