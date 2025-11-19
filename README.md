## Projeto Multimídia Interativo

Este é um projeto multimídia escrito em **Processing (.pde)** que combina visualizações dinâmicas, interatividade do mouse e teclado, e análise de áudio (Visualizador de Música).

### Requisitos e Configuração

[cite_start]O projeto utiliza a biblioteca **Minim** para análise de áudio[cite: 80, 90].

* [cite_start]**Modo de Tela:** O `setup()` define a tela em modo `fullScreen(P3D)`[cite: 88], indicando que usa renderização 3D.
* [cite_start]**Taxa de Quadros:** Definida inicialmente como `frameRate(1000)`[cite: 88].
* [cite_start]**Arquivos de Mídia:** Requer um arquivo de imagem chamado **`fenix.png`** [cite: 88] [cite_start]e um arquivo de áudio chamado **`song.mp3`**[cite: 90].

### Visão Geral da Navegação

O projeto funciona como uma apresentação de slides interativa, com telas que podem ser navegadas usando o mouse (botões na tela) ou o teclado (setas).

| Variável de Estado | Tela | Descrição |
| :---: | :--- | :--- |
| `svar == 0` | `menu()` | [cite_start]Tela inicial com opções "COMEÇAR" e "SAIR"[cite: 99, 100]. |
| `svar == 1` | `espiral()` | [cite_start]Visualização de espiral dinâmica[cite: 99]. |
| `svar == 2` | `espiral_2()` | [cite_start]Segunda visualização de espiral[cite: 99]. |
| `svar == 3` | `fenix()` | [cite_start]Visualização baseada em pontilhismo (halftoning)[cite: 99]. |
| `svar == 4` | `laser()` | [cite_start]Efeito de "lasers" cobrindo a tela anterior[cite: 99]. |
| `svar == 5` | `music()` | [cite_start]Visualizador de música 3D[cite: 99]. |

#### Controles de Navegação

* **Mouse:**
    * [cite_start]**"Próximo" (Proximo):** Move para a próxima tela (`svar += 1`)[cite: 102, 103].
    * [cite_start]**"Voltar" (voltar):** Move para a tela anterior (`svar -= 1`)[cite: 103].
    * [cite_start]**"COMEÇAR" (Menu):** Define `svar = 1`[cite: 101].
    * [cite_start]**"SAIR" (Menu):** Chama `exit()`[cite: 104].
* **Teclado:**
    * [cite_start]**Seta Direita (RIGHT):** Move para a próxima tela (`svar += 1`)[cite: 105].
    * [cite_start]**Seta Esquerda (LEFT):** Move para a tela anterior (`svar -= 1`)[cite: 105].

---

### Módulos e Visualizações

#### 1. Visualizador de Música (`music.pde`)

[cite_start]Esta tela é o visualizador de música 3D e só toca a música quando `svar == 5`[cite: 98].

* [cite_start]**Áudio:** Inicializa `Minim`, carrega `song.mp3`, e usa `FFT` (Fast Fourier Transform) para analisar o áudio[cite: 90, 91].
* **Análise de Frequência:** O espectro é dividido em três bandas:
    * [cite_start]**Graves (`scoreLow`):** 0% a 3% do espectro (`specLow = 0.03`)[cite: 80, 81, 16].
    * [cite_start]**Médios (`scoreMid`):** 3% a 12.5% do espectro (`specMid = 0.125`)[cite: 81, 17].
    * [cite_start]**Agudos (`scoreHi`):** 12.5% a 20% do espectro (`specHi = 0.20`)[cite: 81, 82, 18].
* **Visualização:**
    * [cite_start]**Fundo:** Uma cor sutil de fundo muda com base nas pontuações de frequência (`scoreLow/100, scoreMid/100, scoreHi/100`)[cite: 24].
    * [cite_start]**Cubos (`Cube`):** Objetos 3D flutuantes que giram e se movem ao longo do eixo Z (`z`) em função da intensidade do som[cite: 57, 64, 66].
    * [cite_start]**Linhas de Parede:** Linhas dinâmicas que criam um efeito de túnel/parede, com cor e espessura baseadas nas pontuações de som[cite: 28, 32, 33].

#### 2. Visualização Espiral (`espiral.pde`, `espiral2.pde`)

Ambas as telas geram efeitos visuais de espiral, com parâmetros aleatórios e interatividade.

* [cite_start]**`espiral()`:** Cria múltiplas linhas que giram (`rotate(rAngle)`) [cite: 72] [cite_start]e se movem verticalmente em função da posição horizontal do mouse (`wave*map(mouseX,0,height,2500,0)`)[cite: 71].
* [cite_start]**`espiral_2()`:** Desenha uma série de elipses e linhas que giram ao redor do centro (`translate(width/2,height/2)`), com o ângulo de rotação (`angle`) aumentando a cada quadro[cite: 108, 109].

#### 3. Pontilhismo da Fênix (`fenix.pde`)

[cite_start]Esta tela implementa um efeito de pontilhismo (halftoning) usando elipses, onde o tamanho do ponto é mapeado para o brilho (`brightness`) da imagem **`fenix.png`**[cite: 78].

* [cite_start]**Interatividade:** O número de "ladrilhos" (`tiles1`, `tiles2`, `tiles`) é determinado pela posição X do mouse (`mouseX/10`), controlando a granularidade do efeito[cite: 4, 7, 10].
* **Mapeamento de Cores:** O processo é repetido três vezes para diferentes gamas de cores:
    * [cite_start]**Marrom Escuro:** Fundo para o efeito inicial[cite: 4].
    * [cite_start]**Amarelo:** Para a segunda camada de pontos[cite: 7].
    * [cite_start]**Vermelho:** Para a camada final de pontos[cite: 10].

#### 4. Tela de Lasers (`laser.pde`)

Esta tela cria um efeito de "lasers" piscantes.

* [cite_start]**Efeito:** Usa um `PGraphics` (`canvas`) para desenhar linhas a partir do centro (`width/2,height/2`) para um ponto aleatório na tela (`random(width), random(height)`)[cite: 1].
* [cite_start]**Cor:** A cor de cada linha é aleatória (`random(255),random(255),random(255)`)[cite: 1].

### Classes Adicionais

#### `Cube` (`Cubos.pde`)

Gerencia cubos 3D que flutuam no espaço.
* [cite_start]**Rotação:** A rotação é acumulada e calculada com base na intensidade da banda de frequência do cubo[cite: 64, 65].
* [cite_start]**Movimento Z:** A profundidade (`z`) aumenta continuamente, e o cubo é reposicionado aleatoriamente quando atinge o `maxZ`[cite: 66, 67, 68].

#### `Mur` (`Paredes.pde`)

Gerencia as "paredes" 3D que criam o efeito de túnel.
* [cite_start]**Cor:** A cor da parede é baseada nas pontuações de frequência (`scoreLow`, `scoreMid`, `scoreHi`)[cite: 47].
* [cite_start]**Opacidade:** A opacidade diminui com a distância (ilusão de névoa) e é modulada pelo volume geral (`scoreGlobal`)[cite: 48].
* [cite_start]**Movimento Z:** A posição `z` se move em função do volume geral e reseta ao atingir `maxZ`[cite: 55].
