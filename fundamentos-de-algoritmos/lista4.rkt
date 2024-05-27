; DESENVOLVIDO NO APLICATIVO DRRACKET - lista sobre recursividade COM IMAGENS para melhor visualização

;; Funções úteis do pacote de imagens (para maiores informações e exemplos, consultar o manual):

;; rotate: Número Imagem -> Imagem
;; Dado um ângulo (em graus) e uma imagem, gera uma nova imagem rotacionando a imagem original
;; no ângulo dado.

;; line: Número Número StringOuPen -> Imagem
;; Dados as as coordenadas x e y de um ponto e uma cor, desenha uma reta desta cor
;; ligando este ponto ao ponto (0,0). O terceiro argumento pode ser também uma caneta (estrutura pen), neste caso se
;; pode fazer linhas diferentes (ver decrição de pen a seguir).

;; Um elemento da estrutura pen é composto por 5 campos: cor (String), largura da linha da caneta (Numero),
;; estilo (String, pode ser "solid", "dash", "dot", ...), o estilo do início/fim da linha ("round", "butt" ou "projecting") e
;; o estilo para unir linhas ("round", "bevel", "miter").

;; image-width: Imagem -> Número
;; Dada uma imagem, devolve a sua largura (em número de pixels)

;; overlay/align/offset: String String Imagem Número Imagem -> Imagem
;; Dados os tipos de alinhameno das imagens na horizontal ("right", "left" ou "center") e na vertical ("bottom", "top" ou "center"),
;; a primeira imagem, o valor do descolamento e a segunda imagem, sobrepõe as imagens considerando os alinhamnentos e descolcamento dados.

;; ========================================================================================
;;                              DEFINIÇÕES DE DADOS
;; ========================================================================================

;; Definição de constantes:

(define LARGURA 400) ;; largura da cena
(define ALTURA 400)  ;; altura da cena
(define CENA-VAZIA (empty-scene 400 400))

;; Definição de tipos de dados:
;; ------------ 
;; TIPO FIGURA:
;; ------------
(define-struct figura (coord-x coord-y altura cor))
;; Um elemento do conjunto Figura é
;;     (make-figura x y a c), onde
;;   x: Número, é a coordenada x do centro da figura
;;   y: Número, é a coordenada y do centro da figura
;;   a : Número, é a altura da figura
;;   c : Número, número que representa a cor da figura, de acordo com a função gera-cor 

;; =====================
;; DEFINIÇÕES DE FUNÇÕES
;; =====================

;; =================================================
;; FUNÇÕES PARA ACESSAR OS COMPONENTES DE UMA FIGURA:
;; =================================================
;; As funções a seguir são definidas como novos nomes para
;; as funções sobre listas first, second, third e fourth.
(define coord-x-figura first)
(define coord-y-figura second)
(define altura-figura third)
(define cor-figura fourth)

;; ========================
;; FUNÇÃO GERA-COR:
;; ========================
;; gera-cor : Número -> String
;; Dado um número positivo, devolve uma de 5 cores: "red", "blue", "green", "yellow" ou "cyan".
;; Exemplos:
;;      (gera-cor 3) = "yellow"
;;      (gera-cor 55) = "red"
(define (gera-cor n)
  (cond
    [(= (remainder n 5) 0) "red"]
    [(= (remainder n 5) 1) "blue"]  
    [(= (remainder n 5) 2) "green"]
    [(= (remainder n 5) 3) "yellow"]
    [(= (remainder n 5) 4) "cyan"]))

;; ========================
;; FUNÇÃO DESENHA-TRIANGULO:
;; ========================
;; desenha-triangulo : Número String ->  Imagem
;; Obj.: Dados um tamanho de lado e uma cor, desenha um triângulo.
;; Exemplos:
;;     (desenha-triangulo 20 "red") = .
;;     (desenha-triangulo 50 "darkgreen") = .
(define (desenha-triangulo lado cor)
  (triangle lado "outline" cor))

;; ========================
;; FUNÇÃO DESENHA-QUADRADO:
;; ========================
;; desenha-quadrado : Número String ->  Imagem
;; Obj.: Dados um tamanho de lado e uma cor, desenha um quadrado.
;; Exemplos:
;;     (desenha-quadrado 20 "red") = .
;;     (desenha-quadrado 50 "darkgreen") = .
(define (desenha-quadrado lado cor)
  (square lado "outline" cor))

;; ========================
;; FUNÇÃO SIERPISNKI:
;; ========================

;; sierpinski: Número String -> Imagem
;; Obj: Dados o tamanho do lado e uma cor, desenha um triângulo de Sierpinski
;; desta cor cujo lado do triângulo externo é o lado passado como argumento. 
;; Exemplos:
;;        (sierpinski 50 "red") = . 
(define (sierpinski lado cor);; Dados um lado e uma cor 
  (cond
       ;; se o lado for muito pequeno, desenhar um triângulo com o lado dado
       [(<= lado 5)  (desenha-triangulo lado cor)]
       ;; senão
       ;;      desenha um triângulo de sierpinksi com a metade do tamanho do lado
       ;;      e dá o nome de TRIANGULO para este desenho:
       [else (local
               (
                (define TRIANGULO (sierpinski (/ lado 2) cor))
               )
                ;; e monta a imagem do triângulo de sierpinski colocando um TRIANGULO
                ;; acima de dois outros TRIANGULOs:
               (above TRIANGULO
                      (beside TRIANGULO TRIANGULO)))]))

;; Argumentação de terminação:
;; Este programa sempre termina porque:
;; (a) Existe um caso base (sem recursão) que é quando o tamanho do lado é menor ou igual a 5.
;;     Neste caso, o programa simplesmente desenha um triângulo com este lado.
;; (b) Cada chamada recursiva é realizada tendo como argumento a metade do lado,
;;     que é um número estritamente menor que o lado, e portanto mais próximo
;;     de se tornar menor que 5 (lembrando que a chamada recursiva só ocorre se o lado for >=5).
;; (c) As funções <=, above, beside e cond terminam, pois são pré-definidas da linguagem.
;;     A função desenha-triangulo termina, pois somente usa funções pré-definidas e não tem laços.

;; Não modifique nada até este ponto!!!
;; A partir daqui estão os exercícios a serem resolvidos.


;;===============================================================
;; 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
;;===============================================================

;; FUNÇÃO: sierpinski-sem-local: Número String -> Imagem
;; Objetivo: Dados o tamanho do lado e uma cor, desenha um triângulo de Sierpinski
;; desta cor cujo lado do triângulo externo é o lado passado como argumento. 
;; Exemplos:
;(sierpinski-sem-local 100 "purple") =  .       (sierpinski-sem-local 80 "orange") = .

(define (sierpinski-sem-local lado cor)
    (cond
       ;; se o lado for muito pequeno, desenhar um triângulo com o lado dado
       [(<= lado 5) (desenha-triangulo lado cor)]
       ;; senão
       [else
       ;;      desenha um triângulo de sierpinksi com a metade do tamanho do lado
       ;;      acima de dois outros triângulos de sierpinksi com a metade do tamanho do lado
        (above (sierpinski (/ lado 2) cor)
               (beside (sierpinski (/ lado 2) cor) (sierpinski (/ lado 2) cor)))]))


;;===============================================================
;; 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
;;===============================================================
;; FUNÇÃO: tapete-sierpinski: Número String -> Imagem
;; Objetivo: Dados o tamanho do lado e uma cor, desenha um triângulo de Sierpinski
;; desta cor cujo lado do triângulo externo é o lado passado como argumento. 
;; Exemplos:
;(tapete-sierpinski 100 "pink") =  .             (tapete-sierpinski 70 "black") = .

(define (tapete-sierpinski lado cor);; Dados um lado e uma cor 
    (cond
      ;; se o lado for muito pequeno, desenhar um quadrado da cor dada com o lado dado
      [(<= lado 5) (square lado "solid" cor)]
      ;; senão 
      [else
       (local ;; definir nomes locais:
                ;; seja NOVO-LADO o lado dos novos tapetes que serão desenhados, definido por lado/3:
                ((define NOVO-LADO (/ lado 3))
                ;; seja T um tapete de sierpinski com o lado NOVO-LADO:
                (define T (tapete-sierpinski NOVO-LADO cor))
                ;; seja TB um quadrado com o lado NOVO-LADO todo branco:
                (define TB (square NOVO-LADO "solid" "white")))
         ;; montar uma imagem com as seguinte linhas, uma acima da outra
         (above
                ;; três tapetes de sierpinski com NOVO-LADO, um ao lado do outro
                (beside T T T)
                ;;  um quadrado branco com NOVO-LADO no meio de dois tapetes de sierpinski com NOVO-LADO 
                (beside T TB T) 
                ;;  três tapetes de sierpinski com NOVO-LADO, um ao lado do outro
                (beside T T T)))]))


;; Argumentação de terminação:
;; Este programa sempre termina porque:
;; (a) Existe um caso base (sem recursão) que é quando o tamanho do lado é menor ou igual a 5.
;;     Neste caso, o programa simplesmente desenha um quadrado com este lado.
;; (b) Cada chamada recursiva é realizada tendo como argumento um terço do lado,
;;     que é um número estritamente menor que o lado, e portanto mais próximo
;;     de se tornar menor que 5 (lembrando que a chamada recursiva só ocorre se o lado for >=5).
;; (c) As funções <=, above, beside e cond terminam, pois são pré-definidas da linguagem.
;;     A função desenha-quadrado termina, pois somente usa funções pré-definidas e não tem laços.

;;===============================================================
;; 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 
;;===============================================================

;;FUNÇÃO: árvore: Número String -> Imagem
;; Objetivo: dado um número, que representa a altura da árvore e uma cor (folhas), devolve a imagem de uma árvore.
;; Exemplos:
;; (árvore 20 "green") = .             (árvore 40 "blue") = .

(define (árvore a c);; Dados uma altura e uma cor
    (cond
      ;; se a altura for muito pequena, desenhar um galho com a altura e cor dada
      [(<= a 3) (galho-sozinho a c)] 
      ;; senão
      [else
       (local ;; definir nomes locais:
                ((define NOVA_ALTURA (/ a 3)) ;; define uma nova altura para a árvore
                (define G (árvore NOVA_ALTURA c))) ;; define uma nova árvore com uma nova altura
    
               (beside/align "center" ;; coloca lado a lado uma arvore(com um galho direito) e um galho esquerdo
                (overlay/align/offset "right" "top" ;; coloca um galho no lado direito do topo de uma árvore
                 (rotate 45 G)  ;; rotaciona o galho em 45 graus
                 5 5 ;; coordenadas do galho direito
                 (galho-sozinho a c)) ;; galho do meio
                   
                 (rotate -45 G)))])) ;; galho da esquerda
                
  
 
;; FUNÇÃO: galho: Numero String -> Imagem
;; OBJETIVO: montar os galhos que serão utilizados na função árvore
;; Exemplos:
;; (galho 10 "green") = .         (galho 30 "deeppink") = .

(define (galho a c)
  (beside
   (beside/align "top"
   (beside/align "top" (circle 3 "solid" c) (line a a (make-pen "brown" 3 "solid" "round" "round")))
   (line 0 (* a 3) (make-pen "brown" 3 "solid" "round" "round")))
   (beside/align "top" (line (* -1 a) a (make-pen "brown" 3 "solid" "round" "round")) (circle 3 "solid" c)))) 

;; FUNÇÃO: galho-sozinho: Numero String -> Imagem
;; OBJETIVO: definir um galho sozinho (tronco) para a função árvore
;; Exemplo:
;; (galho-sozinho 10 "blue") = .        (galho-sozinho 30 "purple") = .

(define (galho-sozinho a c)
  (beside/align "top"
                (circle 3 "solid" c)
                (line 0 (* a 3) (make-pen "brown" 5 "solid" "round" "round"))
                (circle 3 "solid" c)))



;; Chamadas da função árvore (pelo menos 3, colocadas lado a lado):

;(beside/align "bottom"
;              (árvore 90 "red")
;              (árvore 45 "green")
;              (árvore 20 "purple"))

;;  .


;; ==============================================================
;; 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 
;; ==============================================================

;; FUNÇÃO: desenha-sierpinski: Figura -> Imagem
;; Objetivo: dado uma figura, gera um triângulo sierpinski com as especificações dadas na
;; figura passada como argumento.
;; Exemplo:
;;(desenha-sierpinski  (make-figura 10 10 70 24))= .

(define (desenha-sierpinski f)
  (sierpinski
    (* (/ (figura-altura f) (sqrt 3)) 2) ;; fórmula para pegar o lado de um triângulo equilátero
    (gera-cor (figura-cor f)))) 


;; FUNÇÃO: desenha-tapete-sierpinski: Figura -> Imagem
;; Objetivo: dado uma figura, gera um tapete sierpinski com as especificações dadas na
;; figura passada como argumento.
;; Exemplo:
;; (desenha-tapete-sierpinski  (make-figura 10 10 70 24))= .

(define (desenha-tapete-sierpinski f)
  (tapete-sierpinski
   (figura-altura f)
   (gera-cor (figura-cor f))))


;; FUNÇÃO: desenha-árvore: Figura -> Imagem
;; Objetivo: dado uma figura, gera uma árvore com as especificações dadas na
;; figura passada como argumento.
;; Exemplo:
;; (desenha-árvore (make-figura 10 10 50 24))=.

(define (desenha-árvore f)
  (árvore
   (figura-altura f)
   (gera-cor (figura-cor f))))



;; Chamadas da função desenha-tapete-sierpinski (pelo menos 3, colocadas lado a lado):
;(beside/align "bottom"
;              (desenha-tapete-sierpinski  (make-figura 10 10 70 2))
;              (desenha-tapete-sierpinski  (make-figura 10 10 60 1))
;              (desenha-tapete-sierpinski  (make-figura 10 10 50 15)))

;; .

;; Chamadas da função desenha-sierpinski (pelo menos 3, colocadas lado a lado):
;(beside/align "bottom"
;              (desenha-sierpinski  (make-figura 10 10 70 2))
;              (desenha-sierpinski  (make-figura 10 10 60 1))
;              (desenha-sierpinski  (make-figura 10 10 50 15)))

;; .

;; Chamadas da função desenha-árvore (pelo menos 3, colocadas lado a lado):
;(beside/align "bottom"
;              (desenha-árvore  (make-figura 10 10 70 2))
;              (desenha-árvore  (make-figura 10 10 60 1))
;              (desenha-árvore  (make-figura 10 10 50 15)))

;;.

;; ==============================================================
;; 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 
;; ==============================================================

;; FUNÇÃO: desenha-figuras: (Figura --> Image) Figura --> Cena  
;; Objetivo: Dada uma função que gera a imagem de uma figura e uma figura, gera uma cena
;; com várias imagens desta figura.
;; Exemplos:
;;     (desenha-figuras desenha-sierpinski (make-figura 10 10 100 2)) =

;;                .



(define (desenha-figuras fun f);; Dadas uma função de desenho da figura e uma figura
  (cond
    ;; se a figura tiver a altura menor ou igual a 5, desenha uma cena vazia.
    [(>= 5 (figura-altura f)) CENA-VAZIA]
    ;; senão monta uma cena com 
    [else (place-image
               (fun f) ;; o desenho da figura f na
               (figura-coord-x f) ;; coordenada x da figura e
               (figura-coord-y f) ;; coordenada y da figura em
               ;; uma cena contendo os desenhos das figuras a partir da figura modificada
               ;; da seguinte forma 
               (desenha-figuras fun (make-figura
                                          (random 400)
                                          (random 400)
                                          (-(figura-altura f) 5) ;; a altura diminui 5 a cada chamada
                                          (random 5)
                                          )))]) ) 
 

;; Terminação: Assumindo que a função fun (argumento da função) termina,
;;  este programa termina porque:

;; (a) Existe um caso base (sem recursão) que é quando o tamanho do lado é menor ou igual a 5.
;;     Neste caso, o programa simplesmente sobrepõe a penultima cena sobre uma cena vazia.
;; (b) Cada chamada recursiva que é realizada o argumento "altura" é subtraido 5 unidades, que
;;     é um número menor que a altura original e portanto, obviamente, em algum momento se
;;     tornará menor que 5 e o caso base acontecerá, encerrando a função.
;; (c) As funções cond, place-image terminam, pois são pré-definidas da linguagem.


;;===============================================================
;; 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6
;;===============================================================

;; (a) Critérios de terminação: funções do tipo Figura -> Booleano

;; FUNÇÃO: fora-da-borda: Figura -> Booleano
;; Objetivo: dado uma figura, diz se ela está fora de uma cena (400x400) ou não.
;; Se estiver fora, devolve true, senão devolve false.
;; Exemplos:
;;          (fora-da-borda? (make-figura 10 10 100 2))= #false
;;          (fora-da-borda? (make-figura 0 34 128 53))= #true

(define (fora-da-borda? f)
  (cond
    [(= 0 (figura-coord-x f)) #t]
    [(<= 400 (figura-coord-x f)) #t]
    [(= 0 (figura-coord-y f)) #t]
    [(<= 400 (figura-coord-y f)) #t]
    [else #f]))

(check-expect (fora-da-borda? (make-figura 10 10 100 2)) #false)
(check-expect (fora-da-borda? (make-figura 0 34 128 53)) #true)


;; FUNÇÃO: azul?: Figura -> Booleano
;; Objetivo: dado uma figura, diz se ela tem cor azul ou não.
;; Se for azul, devolve true, senão devolve false.
;; Exemplos:
;;          (azul? (make-figura 37 289 100 6))= #true
;;          (azul? (make-figura 390 183 86 9))= #false

(define (azul? f)
  (cond
    [(string=? (gera-cor (figura-cor f)) "blue") #t]
    [else #f]))

; Testes:
(check-expect (azul? (make-figura 10 10 100 2)) #false)
(check-expect (azul? (make-figura 37 289 100 6)) #true)


;; FUNÇÃO: grande?: Figura -> Booleano
;; Objetivo: dado uma figura, se a altura dela for maior que 200, devolve true, senão devolve false.
;; Exemplos:
;;          (grande? (make-figura 37 289 100 6))= #false
;;          (grande? (make-figura 37 289 270 8))= #true

(define (grande? f)
  (cond
    [(<= 200 (figura-altura f)) #t]
    [else #f]))

; Testes:
(check-expect (grande? (make-figura 37 289 100 6)) #false)
(check-expect (grande? (make-figura 37 289 270 8)) #true)

;;===============================================================

;; (b) Funções de modificação de figuras, tipo Figura -> Figura

;; FUNÇÃO: posição-aleatória: Figura -> Figura
;; Objetivo: dada uma figura, devolve outra figura, com seus argumentos coord-x e coord-y aleatórios
;; de valores entre 0 à 400.
;; Exemplo:
;;         (posição-aleatória (make-figura 37 289 100 6))= (make-figura 329 248 100 6)
;;         (posição-aleatória (make-figura 10 10 100 2))= (make-figura 182 242 100 2)

(define (posição-aleatória f)
  (make-figura (random 400) (random 400) (figura-altura f) (figura-cor f)))

;; Observação: não é possível fazer check-expect pois os valores são randomizados.

;; FUNÇÃO: cor-aleatória: Figura -> Figura
;; Objetivo: dada uma figura, devolve outra figura, com seu argumento cor aleatório. O argumento
;; cor pode definir futuramente 5 cores, com base em uma divisão por 5 e observando o resto, logo,
;; pode-se randomizar de 0 a 9, para ter chances iguais para cada cor.
;; Exemplos:
;;          (cor-aleatória (make-figura 37 289 100 6))= (make-figura 37 289 100 4)
;;          (cor-aleatória (make-figura 10 10 100 2))= (make-figura 10 10 100 3)

(define (cor-aleatória f)
  (make-figura (figura-coord-x f) (figura-coord-y f) (figura-altura f) (random 9)))

;; Observação: não é possível fazer check-expect pois os valores são randomizados.

;; FUNÇÃO: aumenta-altura: Figura -> Figura
;; Objetivo: dado uma figura, devolve outra figura, com seu argumento altura aumentado em 10 unidades.
;; Exemplos:
;;          (aumenta-altura (make-figura 37 289 100 6))= (make-figura 37 289 110 6)
;;          (aumenta-altura (make-figura 37 289 270 8))= (make-figura 37 289 280 8))

(define (aumenta-altura f)
  (make-figura (figura-coord-x f) (figura-coord-y f) (+ 10 (figura-altura f)) (figura-cor f)))

; Testes:
(check-expect (aumenta-altura (make-figura 37 289 100 6)) (make-figura 37 289 110 6))
(check-expect (aumenta-altura (make-figura 37 289 270 8)) (make-figura 37 289 280 8))

;; FUNÇÃO: posição-e-cor-aleatória: Figura -> Figura
;; Objetivo: dada uma figura, devolve outra figura, com seus argumentos coord-x e coord-y aleatórios
;; de valores entre 0 à 400. Além disso, modifica seu argumento cor também aleatoriamente. O argumento
;; cor pode definir futuramente 5 cores, com base em uma divisão por 5 e observando o resto, logo,
;; pode-se randomizar de 0 a 9, para ter chances iguais para cada cor.
;; Exemplos:
;;          (posição-e-cor-aleatória (make-figura 37 289 100 6))= (make-figura 172 348 100 0)
;;          (posição-e-cor-aleatória (make-figura 10 10 100 2))= (make-figura 127 147 100 5)

(define (posição-e-cor-aleatória f)
  (make-figura (random 400) (random 400) (figura-altura f) (random 9)))

;; Observação: não é possível fazer check-expect pois os valores são randomizados.

;;===============================================================

;; (c) Função desenha-figuras-gen

;; FUNÇÃO:
;; desenha-figuras-gen: (Figura --> Image) Figura (Figura --> Booleano) (Figura --> Figura) --> Cena
;; Objetivo: Dada uma função que gera a imagem de uma figura, uma figura, um critério de fim e
;; uma função de alteração de figuras, gera uma cena com várias figuras.
;; Exemplo:
;;   (desenha-figuras-gen desenha-sierpinski (make-figura 37 289 100 6) fora-da-borda? posição-aleatória)

;;.

(define (desenha-figuras-gen GI f C A)
  (cond
    ;; se a figura obedecer ao critério, desenha uma cena vazia.
    [(C f) CENA-VAZIA]
    ;; senão monta uma cena com 
    [else (place-image
             (GI f) ;; a imagem da figura f na
             (figura-coord-x f) ;; coordenada x da figura e
             (figura-coord-y f) ;; coordenada y da figura em
             ;; uma cena contendo os desenhos das figuras a partir da figura alterada
             ;; da seguinte forma
             (desenha-figuras-gen GI (A f) C A))])) ;; a figura é alterada pela funçao A
                                  
;; 4 chamadas diferentes da função:

;; 1- (desenha-figuras-gen desenha-sierpinski (make-figura 37 289 100 6) fora-da-borda? posição-aleatória)

;; 2- (desenha-figuras-gen desenha-árvore (make-figura 37 289 100 7) azul? posição-e-cor-aleatória)

;; 3- (desenha-figuras-gen desenha-tapete-sierpinski (make-figura 200 200 100 7) grande? aumenta-altura)

;; 4- (desenha-figuras-gen desenha-sierpinski (make-figura 37 289 100 7) azul? aumenta-altura)

;; Observação: esta última não termina nunca!

           
;;===============================================================

;; (d) Argumentação sobre a terminação das chamadas:  

;; 1- ;; Terminação: este programa talvez não termine porque:

;; O critério de terminação do programa é ficar fora da janela da cena, então se a figura for
;; para fora, o programa encerra. Entretanto, a posição da figura é randomizada à cada chamada recursiva
;; pela função de alteração de figura, logo, existe a possibilidade do programa nunca terminar.

;; 2- ;; Terminação: este programa talvez não termine porque:

;; O critério de terminação do programa é ter como argumento da figura a cor azul, quando a figura tiver
;; o argumento cor azul, o programa encerra. Entretanto a função de alteração da figura, além de randomizar
;; a posição, randomiza também a cor. Como existem 5 opções de cor, com chances iguais, a cada chamada
;; o programa possui 20% de chance de terminar, assim, há uma chance pequeníssima do programa não terminar.

;; 3- ;; Terminação: este programa sempre terminará porque:

;; O critério de terminação do programa é a altura da figura dada ser maior ou igual a 200. Além disso,
;; a função de alteração da figura, à cada chamada recursiva aumenta a altura da figura em 10 unidades,
;; logo, que é um número maior que a altura original e portanto, em algum momento a altura ficará maior
;; ou igual a 200 e o critério dado se tornará verdadeiro, encerrando a função.

;; 4- ;; Terminação: este programa nunca terminará porque:

;; O critério de terminação do programa é ter como argumento da figura a cor azul, quando a figura tiver
;; o argumento cor azul, o programa encerra. Entretanto a função de alteração da figura, altera o argumento
;; altura da figura em +10 unidades e a cor nunca é alterada, logo a cada chamada recursiva a função cria
;; uma cena com uma imagem maior, infinitamente, pois o critério de encerramento nunca é atingido. Assim,
;; o programa nunca termina. Obs: o programa pode terminar se o argumento cor da figura inicial já for
;; azul, assim o programa apenas monta uma cena vazia e encerra.
