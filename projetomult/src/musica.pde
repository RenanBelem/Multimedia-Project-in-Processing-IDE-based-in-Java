// tela das musicas
void music() {
  // tocar musica
  song.play();
  song.setGain(-35);
  
   //Avance a música. Draw() para cada "quadro" da música ...
  fft.forward(song.mix);
  
  // Cálculo das "pontuações" (potência) para três categorias de som
  // Primeiro, salve os valores antigos
  oldScoreLow = scoreLow;
  oldScoreMid = scoreMid;
  oldScoreHi = scoreHi;
  
  // Reinicialize os valores
  scoreLow = 0;
  scoreMid = 0;
  scoreHi = 0;
 
  //Calcular os novos "scores"
  for(int i = 0; i < fft.specSize()*specLow; i++)
  {
    scoreLow += fft.getBand(i);
  }
  
  for(int i = (int)(fft.specSize()*specLow); i < fft.specSize()*specMid; i++)
  {
    scoreMid += fft.getBand(i);
  }
  
  for(int i = (int)(fft.specSize()*specMid); i < fft.specSize()*specHi; i++)
  {
    scoreHi += fft.getBand(i);
  }
  
  //Faire ralentir la descente.
  if (oldScoreLow > scoreLow) {
    scoreLow = oldScoreLow - scoreDecreaseRate;
  }
  
  if (oldScoreMid > scoreMid) {
    scoreMid = oldScoreMid - scoreDecreaseRate;
  }
  
  if (oldScoreHi > scoreHi) {
    scoreHi = oldScoreHi - scoreDecreaseRate;
  }
  
  // Volume para todas as frequências neste momento, com sons mais altos mais proeminentes.
  // Isso permite que a animação vá mais rápido para sons de alta frequência, que são mais perceptíveis
  float scoreGlobal = 0.66*scoreLow + 0.8*scoreMid + 1*scoreHi;
  
  //Cor sutil de fundo
  background(scoreLow/100, scoreMid/100, scoreHi/100);
   
  //Cubo para cada banda de frequência
  for(int i = 0; i < nbCubes; i++)
  {
    //valor da banda de frequencia
    float bandValue = fft.getBand(i);
    
    //A cor é representada da seguinte forma: vermelho para graves, verde para sons médios e azul para agudos.
    //A opacidade é determinada pelo volume da fita e pelo volume geral.
    cubes[i].display(scoreLow, scoreMid, scoreHi, bandValue, scoreGlobal);
  }
  
  //Paredes de linha, aqui você tem que manter o valor da faixa anterior e da próxima para conectá-las
  float previousBandValue = fft.getBand(0);
  
  //Distância entre cada ponto da linha, negativa porque na dimensão z
  float dist = -25;
  
  //Multiplique a altura por esta constante
  float heightMult = 2;
  
  //Para cada banda
  for(int i = 1; i < fft.specSize(); i++)
  {
    //Valor da banda de frequência, multiplicamos as bandas mais afastadas para que fiquem mais visíveis.
    float bandValue = fft.getBand(i)*(1 + (i/50));
    
    //Seleção da cor de acordo com a intensidade dos diferentes tipos de sons
    stroke(200+scoreMid, 0+scoreLow, 255+scoreHi, 255-i);
    strokeWeight(1 + (scoreGlobal/100));
    
    //linha inferior esquerda
    line(0, height-(previousBandValue*heightMult), dist*(i-1), 0, height-(bandValue*heightMult), dist*i);
    line((previousBandValue*heightMult), height, dist*(i-1), (bandValue*heightMult), height, dist*i);
    line(0, height-(previousBandValue*heightMult), dist*(i-1), (bandValue*heightMult), height, dist*i);
    
    //linha superior esquerda
    line(0, (previousBandValue*heightMult), dist*(i-1), 0, (bandValue*heightMult), dist*i);
    line((previousBandValue*heightMult), 0, dist*(i-1), (bandValue*heightMult), 0, dist*i);
    line(0, (previousBandValue*heightMult), dist*(i-1), (bandValue*heightMult), 0, dist*i);
    
    //linha inferior direita
    line(width, height-(previousBandValue*heightMult), dist*(i-1), width, height-(bandValue*heightMult), dist*i);
    line(width-(previousBandValue*heightMult), height, dist*(i-1), width-(bandValue*heightMult), height, dist*i);
    line(width, height-(previousBandValue*heightMult), dist*(i-1), width-(bandValue*heightMult), height, dist*i);
    
    //linha superior direita
    line(width, (previousBandValue*heightMult), dist*(i-1), width, (bandValue*heightMult), dist*i);
    line(width-(previousBandValue*heightMult), 0, dist*(i-1), width-(bandValue*heightMult), 0, dist*i);
    line(width, (previousBandValue*heightMult), dist*(i-1), width-(bandValue*heightMult), 0, dist*i);
    
    
  // Salve o valor para a próxima rodada
    previousBandValue = bandValue;
  }
  
   //Paredes retangulares
  for(int i = 0; i < nbMurs; i++)
  {
     //Atribuímos uma banda a cada parede e enviamos sua força.
    float intensity = fft.getBand(i%((int)(fft.specSize()*specHi)));
    murs[i].display(scoreLow, scoreMid, scoreHi, intensity, scoreGlobal);
  }
  // botão de voltar
  fill(255);     rect(0,height*0.91, 300,100);    fill(0);  textSize(25); text("voltar", 0 + 110,height*0.91 + 55);
}
  
