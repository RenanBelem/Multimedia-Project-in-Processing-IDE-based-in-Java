//Classe para exibir linhas nas laterais
class Mur {
  //Posição Z minima e maxima
  float startingZ = -10000;
  float maxZ = 50;
  
  //Variaveis de posição
  float x, y, z;
  float sizeX, sizeY;
  
 
  Mur(float x, float y, float sizeX, float sizeY) {
    //LInha aparecer no local especifico
    this.x = x;
    this.y = y;
    //Profundidade aleatoria
    this.z = random(startingZ, maxZ);  
    
    //Nós determinamos o tamanho porque as paredes dos pisos têm um tamanho diferente das laterais
    this.sizeX = sizeX;
    this.sizeY = sizeY;
  }
  
  //função de exibição
  void display(float scoreLow, float scoreMid, float scoreHi, float intensity, float scoreGlobal) {
    //Cor determinada por sons baixos, médios e altos
    //Opacidade determinada pelo volume geral
    color displayColor = color(scoreMid*0.67, scoreLow*0.67, scoreHi*0.67, scoreGlobal);
    
    //Faça as linhas desaparecerem ao longe para dar uma ilusão de névoa
    fill(displayColor, ((scoreGlobal-5)/1000)*(255+(z/25)));
    noStroke();
    
    //Primeira banda, aquela que se move de acordo com a força
    //Matriz de transformação
    pushMatrix();
    
    //Variação do centro
    translate(x, y, z);
    
    //alargamento
    if (intensity > 100) intensity = 100;
    scale(sizeX*(intensity/100), sizeY*(intensity/100), 20);
    
    //Criação da "caixa"
    box(1);
    popMatrix();
    
    //Segunda banda, a do mesmo tamanho
    displayColor = color(scoreMid*0.5, scoreLow*0.5, scoreHi*0.5, scoreGlobal);
    fill(displayColor, (scoreGlobal/5000)*(255+(z/25)));
    //Matrice de transformation
    pushMatrix();
    
    //Déplacement
    translate(x, y, z);
    
    //Agrandissement
    scale(sizeX, sizeY, 10);
    
    //Création de la "boite"
    box(1);
    popMatrix();
    
    //Déplacement Z
    z+= (pow((scoreGlobal/150), 2));
    if (z >= maxZ) {
      z = startingZ;  
    }
  }
}
