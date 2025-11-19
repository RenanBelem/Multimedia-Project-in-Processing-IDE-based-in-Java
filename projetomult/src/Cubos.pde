//Flutuação dos cubos no espaço
class Cube {
  // Posição 'z' origem e maxima
  float startingZ = -10000;
  float maxZ = 1000;
  
  //variaveis de posição
  float x, y, z;
  float rotX, rotY, rotZ;
  float sumRotX, sumRotY, sumRotZ;
  
  //Gerador
  Cube() {
    //Geração aleatoria dos cubos
    x = random(0, width);
    y = random(0, height);
    z = random(startingZ, maxZ);
    
    //e rotação aleatoria
    rotX = random(0, 1);
    rotY = random(0, 1);
    rotZ = random(0, 1);
  }
  
  void display(float scoreLow, float scoreMid, float scoreHi, float intensity, float scoreGlobal) {
    //Seleção das cores, a opacidade varia com a intensidade/bandas de frequencia
    color displayColor = color(scoreHi*0.67, scoreLow*0.67, scoreMid*0.67, intensity*5);
    fill(displayColor, 255);
    
    //Arestas coloridas
    color strokeColor = color(255-(20*intensity));
    stroke(strokeColor);
    strokeWeight(1 + (scoreGlobal/300));
    
    //matriz de transformaçoes pra rotação
    pushMatrix();
    
    //mudança do centro
    translate(x, y, z);
    
    //Cálculo da rotação em função da intensidade do cubo
    sumRotX += intensity*(rotX/1000);
    sumRotY += intensity*(rotY/1000);
    sumRotZ += intensity*(rotZ/1000);
    
    //Aplicação da rotação
    rotateX(sumRotX);
    rotateY(sumRotY);
    rotateZ(sumRotZ);
    
    //Criação das caixas
    box(100+(intensity/2));
    
    //aplicação da matriz
    popMatrix();
    
    //Variação de z
    z+= (1+(intensity/5)+(pow((scoreGlobal/150), 2)));
    
    //substituição da caixa qnd mudar
    if (z >= maxZ) {
      x = random(0, width);
      y = random(0, height);
      z = startingZ;
    }
  }
}
