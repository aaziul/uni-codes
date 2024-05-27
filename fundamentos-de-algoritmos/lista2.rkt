; CÓDIGO FEITO NO APLICATIVO DRRACKET (definições de dados não são documentadas)

;; ========================================================================================
;;                              DEFINIÇÕES DE DADOS
;; ========================================================================================
;; -----------------
;; TIPO TipoDeForma:
;; -----------------
;; Um TipoDeForma pode ser
;; 1. "retângulo", ou
;; 2. "triângulo", ou
;; 3. "círculo", ou
;; 4. "estrela"

;; -----------------
;; TIPO CorDeForma:
;; -----------------
;; Uma CorDeForma pode ser
;; 1. "red", ou
;; 2. "blue", ou
;; 3. "green", ou
;; 4. "yellow", ou
;; 5. "orange", ou
;; 6. "brown"

;; -------------------
;; TIPO ListaDeNumeros:
;; -------------------
;; Uma ListaDeNumeros é
;; 1. empty (lista vazia), ou
;; 2. (cons n ln), onde n: Número e ln: ListaDeNumeros 

;; -----------
;; TIPO Forma:
;; -----------
(define-struct forma (nome tipo cor args))
;; Um elemento do conjunto Forma tem o formato
;;    (make-forma n t c a), onde
;;    n : String, é o nome da forma
;;    t : TipoDeForma, é o tipo da forma
;;    c : CorDeForma, é a cor da forma
;;    a : ListaDeNumeros, é a lista de argumentos da forma, confore seu tipo:
;;                        - retângulos possumes 2 argumentos, largura e altura;
;;                        - triângulos possumes 1 argumento, o lado;
;;                        - círculos possumes 1 argumento, o raio;
;;                        - estrelas possumes 3 argumentos, o número de pontas, o
;;                          raio interno e o raio externo.

;; -------------------
;; TIPO ListaDeFormas:
;; -------------------
;; Uma ListaDeFormas é
  ;; 1. vazia (empty), ou
  ;; 2. (cons f lf), onde
  ;;     f : Forma
  ;;     lf: ListaFormas

;; -----------
;; TIPO Aluno:
;; -----------

(define-struct aluno (nome  desenho conceito))
;; Um elemento do conjunto Aluno tem o formato
;;    (make-aluno n d c), onde
;;    n : String, é o nome do aluno
;;    d : ListaDeFormas, é o desenho do aluno
;;    c : String, é o conceito do aluno

;; ========================================================================================
;;                                    FUNÇÕES ÚTEIS 
;; ========================================================================================

;; ----------------------------------------------
;; FUNÇÃO length: (funcão pré-definida no Racket)
;; ----------------------------------------------
;; length : Lista -> Número
;; Dada uma lista (de qualquer tipo), devolve o número de elementos da lista
;; Exemplos:
;;        (length empty) = 0
;;        (length (cons 1 (con 3 (cons -10 empty)))) = 3

;; -------------------------
;; FUNÇÃO conta-formas-cor:
;; -------------------------
;; conta-formas-cor: ListaDeFormas CorDeForma -> Numero
;; Dada uma lista de formas e uma cor, diz quantas formas desta cor há na lista.
;; Exemplos:
;;    (conta-formas-cor empty "red") = 0
;;    (conta-formas-cor (cons (make-forma "C2" "circulo" "blue"  (cons 30 empty))
;;                            (cons  (make-forma "E1" "estrela" "red"     (cons 40 (cons 20 (cons 40 empty)))) empty)) "red"))) =   1

(define (conta-formas-cor @LF @COR)
  (cond
    ;; se a lista estiver vazia, devolve zero
    [(empty? @LF) 0]
    ;; senão, soma
    [else  (+
               ;; 1, se o primeiro elemento da lista @LF for da cor @COR, ou zero, caso contrário
               (cond
                    [(string=? (forma-cor (first @LF)) @COR) 1]
                    [else 0])
               ;; ao número de formas da cor @COR do resto da lista @LF
               (conta-formas-cor (rest @LF) @COR))]))
  


;; ========================================================================================
;;                                 EXERCÍCIOS
;; ========================================================================================

;; ==============================================================
;; 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
;; ==============================================================
; OBJETIVO: definir um tipo de dado para armazenar os dados de uma turma. Definir 10 constantes do tipo Aluno
; e 4 contantes do tipo ListaDeAlunos

;; -----------
;; TIPO Forma:
;; -----------
(define RETANGULO1
  (make-forma "R1" "retângulo" "orange" (cons 50 (cons 100 empty))))
(define RETANGULO2
  (make-forma "R2" "retângulo" "blue" (cons 50 (cons 100 empty))))
(define RETANGULO3
  (make-forma "R3" "retângulo" "brown" (cons 50 (cons 100 empty))))
(define TRIANGULO1
  (make-forma "T1" "triângulo" "green" (cons 60 empty)))
(define TRIANGULO2
  (make-forma "T2" "triângulo" "blue" (cons 60 empty)))
(define TRIANGULO3
  (make-forma "T3" "triângulo" "brown" (cons 60 empty)))
(define ESTRELA1
  (make-forma "E1" "estrela" "orange" (cons 40 (cons 20 (cons 40 empty)))))
(define ESTRELA2
  (make-forma "E2" "estrela" "yellow" (cons 40 (cons 20 (cons 40 empty)))))
(define ESTRELA3
  (make-forma "E3" "estrela" "brown" (cons 40 (cons 20 (cons 40 empty)))))
(define CIRCULO1
  (make-forma "C1" "círculo" "yellow" (cons 50 empty)))
(define CIRCULO2
  (make-forma "C2" "círculo" "red" (cons 50 empty)))
(define CIRCULO3
  (make-forma "C3" "círculo" "brown" (cons 50 empty)))

;; -------------------
;; TIPO ListaDeFormas:
;; Uma ListaDeFormas é
  ;; 1. vazia (empty), ou
  ;; 2. (cons f lf), onde
  ;;     f : Forma
  ;;     lf: ListaFormas
;; -------------------
(define ListaDeFormas0 empty)
(define ListaDeFormas1 (cons RETANGULO1 (cons TRIANGULO1 (cons ESTRELA2 empty))))
(define ListaDeFormas2 (cons CIRCULO1 (cons TRIANGULO2 (cons ESTRELA2 empty)))) ; possui cores iguais
(define ListaDeFormas3 (cons CIRCULO2 (cons RETANGULO2 (cons TRIANGULO2 (cons ESTRELA1 empty))))) ; possui cores iguais
(define ListaDeFormas4 (cons ESTRELA2 (cons RETANGULO2 (cons TRIANGULO2 empty)))) 
(define ListaDeFormas5 (cons CIRCULO1 (cons TRIANGULO1 (cons RETANGULO1 (cons ESTRELA1 empty))))) ; possui cores iguais
(define ListaDeFormas6 (cons RETANGULO3 (cons TRIANGULO3  (cons ESTRELA3 (cons CIRCULO3 empty)))))

;; Constantes do tipo Aluno:
;; -----------
;; TIPO Aluno:
;; -----------
(define ALUNO1
  (make-aluno "Luísa" ListaDeFormas4 "A"))
(define ALUNO2
  (make-aluno "Isabella" ListaDeFormas2 "A"))
(define ALUNO3
  (make-aluno "Carolina" ListaDeFormas1 "A"))
(define ALUNO4
  (make-aluno "Sofia" ListaDeFormas4 "A"))
(define ALUNO5
  (make-aluno "João" ListaDeFormas5 "A"))
(define ALUNO6
  (make-aluno "Nicolas" ListaDeFormas3 "A"))
(define ALUNO7
  (make-aluno "Cauã" ListaDeFormas2 "A"))
(define ALUNO8
  (make-aluno "Gabriel" ListaDeFormas1 "A"))
(define ALUNO9
  (make-aluno "Rodrigo" ListaDeFormas6 "A"))
(define ALUNO10
  (make-aluno "Arthur" ListaDeFormas2 "A"))

;; -----------------
;; TIPO ListaDeAlunos:
;; Uma ListaDeAlunos é
;; 1. empty (lista vazia), ou
;; 2. (cons a), onde a: aluno
;; -----------------

;; Constantes do tipo ListaDeAlunos:
(define ListaDeAlunos0 empty)
(define ListaDeAlunos1 (cons ALUNO1 (cons ALUNO2 (cons ALUNO3 (cons ALUNO4 (cons ALUNO5 empty))))))
(define ListaDeAlunos2 (cons ALUNO6 (cons ALUNO7 (cons ALUNO8 (cons ALUNO9 (cons ALUNO10 empty))))))
(define ListaDeAlunos3 (cons ALUNO1 (cons ALUNO7 (cons ALUNO3 (cons ALUNO9 (cons ALUNO5 empty))))))
(define ListaDeAlunos4 (cons ALUNO6 (cons ALUNO2 (cons ALUNO8 (cons ALUNO4 (cons ALUNO10 empty))))))


;; ==============================================================
;; 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2
;; ==============================================================

; OBJETIVO: dada uma lista de formas e tipo de forma, verifica se há uma forma do tipo informado

;; ------------------------------
;; FUNÇÃO  existe-forma-na-lista?:
;; ListaDeFormas tipoForma(string) -> booleano
;; ------------------------------

(define (existe-forma-na-lista? lf tf)
  (cond
    [(empty? lf) #f]
    [else
     (cond
       [(string=? (forma-tipo (first lf)) tf) #t]
       [(not (string=? (forma-tipo (first lf)) tf)) #f])]))

; TESTES E EXEMPLOS:
; (check-expect (existe-forma-na-lista? ListaDeFormas4 "Estrela") #true)
; (check-expect (existe-forma-na-lista? ListaDeFormas5 "Retângulo") #false)

;; ==============================================================
;; 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3
;; ==============================================================

; OBJETIVO: dada uma ListaDeFormas remove as formas da mesma cor, deixando no máximo uma de cada cor (a forma mais ao final)

;; ------------------------------
;; FUNÇÃO remove-formas-mesma-cor
;; ListaDeFormas -> Lista
;; ------------------------------

(define (remove-formas-mesma-cor lf)
  (cond
    ; se lista vazia, devolve empty (vazio)
  [(empty? lf) empty]
    ; se tiver mais de dois elementos, remove o primeiro elemento
  [(< (conta-formas-cor lf (forma-cor (first lf))) 2) (cons (first lf) (remove-formas-mesma-cor (rest lf)))]
    ; senão, informa a lista
  [else (remove-formas-mesma-cor (rest lf))]))

; TESTES E EXEMPLOS
; (check-expect (remove-formas-mesma-cor ListaDeFormas3) (cons
;                                                          (make-forma "C2" "circulo" "red" (cons 70 '()))
;                                                            (cons
;                                                              (make-forma "T2" "triângulo" "blue" (cons 50 '()))
;                                                                (cons
;                                                                  (make-forma
;                                                                    "E1"
;                                                                    "estrela"
;                                                                    "orange"
;                                                                    (cons 50 (cons 60 (cons 70 '()))))
;                                                                    '())))

; (check-expect (remove-formas-mesma-cor ListaDeFormas2) (cons
;                                                         (make-forma "T2" "triângulo" "blue" (cons 50 '()))
;                                                           (cons
;                                                            (make-forma
;                                                              "E2"
;                                                              "estrela"
;                                                              "yellow"
;                                                              (cons 50 (cons 60 (cons 70 '()))))
;                                                                '()))

;; ==============================================================
;; 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 
;; ==============================================================

;  OBJETIVO: construir três funções que recebe o desenho de um aluno e devolve #true ou #false

;; -------------------------
;; FUNÇÃO  4tipos?:
;; ListaDeFormas -> booleano
;; -------------------------

;(1) todos os quatro tipos de formas devem aparecer  no desenho;

(define (4tipos? lf)
  (cond
     ; se lista vazia devolve vazio
    [(empty? lf) empty]
     ; se a quantidade de forma for menor que 4, retorna false
    [(< (length lf) 4) #f]
     ; senão, retorna #true
    [else #t]))

; TESTES E EXEMPLOS
; (check-expect (4tipos? ListaDeFormas1) #false)
; (check-expect (4tipos? ListaDeFormas5) #true)

;; -------------------------
;; FUNÇÃO  num-min-cores?:
;; ListaDeFormas -> booleano
;; -------------------------

;(2) devem ser usadas pelo menos 2 cores diferentes;

(define (num-min-cores? lf)
  (cond
    ; se lista vazia, devolve vazio
    [(empty? lf) empty]
    ; se num de cores for maior que 2, retorna #true
    [(>= (length(remove-formas-mesma-cor lf)) 2) #t]
    ; senão, devolve false
    [else #f]))

; EXEMPLOS E TESTES
; (check-expect (num-min-cores? ListaDeFormas2) #true)
; (check-expect (num-min-cores? ListaDeFormas0) empty)
; (check-expect (num-min-cores? ListaDeFormas6) #false)
;; -------------------------
;; FUNÇÃO  num-par-cores?:
;; ListaDeFormas -> booleano
;; -------------------------

;(3) para cada cor usada no desenho, o número de formas desenhadas desta cor deve ser par

(define (num-par-cores? lf)
  (cond
    ; se lista vazia, devolve vazio
    [(empty? lf) empty]
    ; se numero for par com determinada cor, retorna true
    [(and 
    (even? (conta-formas-cor lf "red"))
    (even? (conta-formas-cor lf "blue"))
    (even? (conta-formas-cor lf "green"))
    (even? (conta-formas-cor lf "yellow"))
    (even? (conta-formas-cor lf "orange")) 
    (even? (conta-formas-cor lf "brown"))) #t]
    ; senão, retorna false
    [else #f]))

; TESTES E EXEMPLOS
; (check-expect (num-par-cores? ListaDeFormas6) #t)
; (check-expect (num-par-cores? ListaDeFormas4) #f)
      
;; ==============================================================
;; 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 
;; ==============================================================

; OBJETIVO: recebe uma ListaDeFormas e devolve o número de requisitos da questão 4 que ele satisfaz 

;; -------------------------
;; FUNÇÃO  conta-requisitos:
;; ListaDeFormas -> numero
;; -------------------------

(define ListaDeFormas7 (cons RETANGULO1 (cons ESTRELA2 (cons CIRCULO1 (cons TRIANGULO2 (cons RETANGULO3 (cons TRIANGULO3  (cons ESTRELA3 (cons CIRCULO3 empty)))))))))

(define (conta-requisitos lf)
          (+
           (cond
            ;; soma 1, se a lista cumpre tal requisito, senão soma 0
              [(4tipos? lf) 1]
              [else 0])
           (cond
              [(num-min-cores? lf) 1]
              [else 0])
           (cond
              [(num-par-cores? lf) 1]
              [else 0])))
    
; TESTES E EXEMPLOS:
; (check-expect (conta-requisitos ListaDeFormas5) 2)
; (check-expect (conta-requisitos ListaDeFormas1) 1)

;; ==============================================================
;; 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 6 
;; ==============================================================

; OBJETIVO: atribuir o conceito correto aos alunos, com os requisitos da questão 4, de acordo com os seguintes requisitos:
;                                                  - se o desenho atender os tres requisitos, conceito A
;                                                  - se o desenho atender dois requisitos, conceito B
;                                                  - se o desenho atender um requisito, conceito C
;                                                  - se desenho vazio, conceito E
;                                                  - caso contrário, conceito D

;; -----------------------------
;; FUNÇÃO atribui-conceito-aluno:
;; aluno -> string (alteração do conceito de make-aluno)
;; -----------------------------

(define (atribui-conceito-aluno a)
  (cond
    ;verifica se requisitos é igual a 3, se for, altera o conceito do aluno para A
    [(=(conta-requisitos (aluno-desenho a))3) (make-aluno (aluno-nome a) (aluno-desenho a) "A")]
    ;verifica se requisitos é igual a 2, se for, altera o conceito do aluno para B
    [(=(conta-requisitos (aluno-desenho a))2) (make-aluno (aluno-nome a) (aluno-desenho a) "B")]
    ;verifica se requisitos é igual a 1, se for, altera o conceito do aluno para C
    [(=(conta-requisitos (aluno-desenho a))1) (make-aluno (aluno-nome a) (aluno-desenho a) "C")]
    ;se o desenho do aluo estiver vazio, altera o conceito do aluno para E
    [(empty? (aluno-desenho a)) (make-aluno (aluno-nome a) (aluno-desenho a) "E")]
    [else (make-aluno (aluno-nome a) (aluno-desenho a) "D")]))
    
; (check-expect (atribui-conceito-aluno ALUNO5) (make-aluno
;                                                     "João"
;                                                     (cons
;                                                        (make-forma
;                                                              "C1"
;                                                              "circulo"
;                                                              "yellow"
;                                                              (cons 70 '()))
;                                                     (cons
;                                                        (make-forma
;                                                              "T1"
;                                                              "triângulo"
;                                                              "green"
;                                                              (cons 50 '()))
;                                                     (cons
;                                                        (make-forma
;                                                              "R1"
;                                                              "retângulo"
;                                                              "orange"
;                                                              (cons 50 (cons 100 '())))
;                                                     (cons
;                                                        (make-forma
;                                                              "E1"
;                                                              "estrela"
;                                                              "orange"
;                                                              (cons 50 (cons 60 (cons 70 '()))))
;                                                      '()))))
;                                                      "B")

; (check-expect (atribui-conceito-aluno ALUNO1) (make-aluno
;                                                    "Luísa"
;                                                    (cons
;                                                      (make-forma
;                                                            "E2"
;                                                            "estrela"
;                                                            "yellow"
;                                                            (cons 50 (cons 60 (cons 70 '()))))
;                                                   (cons
;                                                      (make-forma
;                                                            "R2"
;                                                            "retângulo"
;                                                            "blue"
;                                                            (cons 50 (cons 100 '())))
;                                                   (cons
;                                                      (make-forma
;                                                            "T2"
;                                                            "triângulo"
;                                                            "blue"
;                                                            (cons 50 '()))
;                                                   '())))
;                                                   "C")

;; ==============================================================
;; 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 
;; ==============================================================

; OBJETIVO: atribuir conceitos a todos os alunos da turma. Devolve uma Lista de Alunos.

;; ------------------------
;; FUNÇÃO atribui-conceitos:
;; ListaDeAlunos -> ListaDeAlunos
;; ------------------------

(define (atribui-conceitos la)
   (cond
     ; se lista de alunos vazia, devolve vazio
     [(empty? la) empty]
     ; senão, atribuir o conceito para o primeiro aluno da lista de alunos e para o resto da lista
     [else (cons (atribui-conceito-aluno (first la)) (atribui-conceitos (rest la)))]))

; TESTES E EXEMPLOS
;(check-expect (atribui-conceitos ListaDeAlunos2) (cons
; (make-aluno
;  "Nicolas"
;  (cons
;   (make-forma
;    "C2"
;    "circulo"
;    "red"
;    (cons 70 '()))
;   (cons
;    (make-forma
;     "R2"
;     "retângulo"
;     "blue"
;     (cons
;      50
;      (cons 100 '())))
;    (cons
;     (make-forma
;      "T2"
;      "triângulo"
;      "blue"
;      (cons 50 '()))
;     (cons
;      (make-forma
;       "E1"
;       "estrela"
;       "orange"
;       (cons
;        50
;        (cons
;         60
;         (cons 70 '()))))
;      '()))))
;  "B")
; (cons
;  (make-aluno
;   "Cauã"
;   (cons
;    (make-forma
;    "C1"
;     "circulo"
;     "yellow"
;     (cons 70 '()))
;    (cons
;     (make-forma
;      "T2"
;      "triângulo"
;      "blue"
;      (cons 50 '()))
;     (cons
;      (make-forma
;       "E2"
;       "estrela"
;       "yellow"
;       (cons
;        50
;        (cons
;         60
;         (cons 70 '()))))
;      '())))
;   "C")
;  (cons
;   (make-aluno
;    "Gabriel"
;    (cons
;     (make-forma
;      "R1"
;      "retângulo"
;      "orange"
;      (cons
;       50
;       (cons 100 '())))
;     (cons
;      (make-forma
;       "T1"
;       "triângulo"
;       "green"
;       (cons 50 '()))
;      (cons
;       (make-forma
;        "E2"
;        "estrela"
;        "yellow"
;        (cons
;         50
;         (cons
;          60
;          (cons 70 '()))))
;       '())))
;    "C")
;   (cons
;    (make-aluno
;     "Rodrigo"
;     (cons
;      (make-forma
;       "R3"
;       "retângulo"
;       "brown"
;       (cons
;        50
;        (cons 100 '())))
;      (cons
;       (make-forma
;        "T3"
;        "triângulo"
;        "brown"
;        (cons 50 '()))
;       (cons
;        (make-forma
;         "E3"
;         "estrela"
;         "brown"
;         (cons
;          50
;          (cons
;           60
;           (cons 70 '()))))
;        (cons
;         (make-forma
;          "C3"
;          "circulo"
;          "brown"
;          (cons 70 '()))
;         '()))))
;     "B")
;    (cons
;     (make-aluno
;      "Arthur"
;      (cons
;       (make-forma
;        "C1"
;        "circulo"
;        "yellow"
;        (cons 70 '()))
;       (cons
;        (make-forma
;         "T2"
;         "triângulo"
;         "blue"
;         (cons 50 '()))
;        (cons
;         (make-forma
;          "E2"
;          "estrela"
;          "yellow"
;          (cons
;           50
;           (cons
;            60
;            (cons 70 '()))))
;         '())))
;      "C")
;     '()))))))
     
;; ==============================================================
;; 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8
;; ==============================================================

; OBJETIVO: gerar uma imagem com todos os alunos desta turma, com nome, desenhos e conceitos.

;############################################################################################
    
; AUXILIARES DA QUESTÃO 8

; criada para realizar o espaçamento entre as formas
(define ESPAÇAMENTO (rectangle 10 10 "solid" "transparent"))

;;--------------------------
;; FUNÇÃO nome-aluno-desenho
;; ListaDeAlunos -> Imagem
;;--------------------------

; OBJETIVO: recebe uma lista de alunos e devolve uma imagem do nome do primeiro aluno da lista

(define (nome-aluno-desenho la)
  (text
   (string-append
    ; junta a string do nome do aluno do primeiro elemento da lista de alunos com o caractere ":"
    (aluno-nome (first la)) ":") 20 "black"))

;;--------------------------
;; FUNÇÃO conceito-aluno-desenho
;; ListaDeAlunos -> Imagem
;;--------------------------

; OBJETIVO: recebe uma lista de alunos e devolve uma imagem do conceito do primeiro aluno da lista

(define (conceito-aluno-desenho la)
  (text
   (string-append
    ; junta a string "Conceito: " com o conceito correto do primeiro aluno da lista
    "Conceito: "(aluno-conceito (atribui-conceito-aluno (first la)))) 20 "brown"))

;; -----------------------
;; FUNÇÃO desenha-com-nome:
;; -----------------------
;; desenha : Forma -> Imagem
;; Dada uma forma, desenha esta forma com o  seu nome dentro
;; Exemplos:
;;     (desenha-com-nome (make-forma "C2" "circulo" "blue"  (cons 30 empty))) = .
;;     (desenha-com-nome (make-forma "E1" "estrela" "red"     (cons 40 (cons 20 (cons 40 empty))))) = .

 (define (desenha-com-nome @F) ;; Dada uma forma @F
   (overlay  ;; sobrepõe
      ;; o nome da forma @F, e
      (text (forma-nome @F) 20 "black")
      ;; o desenho da forma @F
      (cond
              ;; se @F for um retângulo, desenha este retângulo
              [(string=? "retângulo" (forma-tipo @F))
               (rectangle (first (forma-args @F))(second (forma-args @F)) "solid"(forma-cor @F))]
              ;; se @F for um triângulo, desenha este triângulo
              [(string=? "triângulo" (forma-tipo @F))
               (triangle (first (forma-args @F)) "solid" (forma-cor @F))]
              ;; se @F for um círculo, desenha este circulo
              [(string=? "círculo" (forma-tipo @F))
               (circle (first (forma-args @F)) "solid"(forma-cor @F))]
              ;; se @F for uma estrela, desenha esta estrela
              [(string=? "estrela" (forma-tipo @F))
               (radial-star (first (forma-args @F))(second (forma-args @F)) (third (forma-args @F)) "solid" (forma-cor @F))])))


;; ---------------------------
;; FUNÇÃO desenha-lista-formas:
;; ---------------------------
;; desenha-lista-formas: ListaDeFormas -> Imagem
;; Dada uma lista de formas, desenha as formas da lista lado a lado, com os nomes dentro das formas.
;; Exemplo:
;;    (desenha-lista-formas (cons (make-forma "C2" "circulo" "blue"  (cons 30 empty))
;;                            (cons  (make-forma "E1" "estrela" "red"     (cons 40 (cons 20 (cons 40 empty)))) empty))) = .
 
(define (desenha-lista-formas @LF) ;; Dada uma lista de formas @LF
  (cond
    ;; se a lista @LF estiver vazia, devolve a imagem vazia
    [(empty? @LF) empty-image]
    ;; senão coloca lado a lado
                  ;; o desenho do primeiro elemento de @LF, e 
    [else (beside (desenha-com-nome (first @LF))
                  ;; o desenho do resto dos elementos da lista @LF
                  (desenha-lista-formas (rest @LF)))]))

;;--------------------------
;; FUNÇÃO desenha-lista-formas-com-nomes
;; ListaDeAlunos -> Imagem
;;--------------------------

; OBJETIVO: recebe uma lista de formas e devolve uma imagem com a lista de formas com nome

(define (desenha-lista-formas-com-nomes la)
  (beside
   ; une as funções desenha-com-nome e desenha-lista-formas
   (desenha-com-nome (first (aluno-desenho (first la))))
   ESPAÇAMENTO
   (desenha-lista-formas (aluno-desenho (first la)))
   ESPAÇAMENTO))

; ##################################################################################################

;; -----------------------------
;; FUNÇÃO mostra-conceitos-turma:
;; ListaDeAlunos -> Imagem
;; -----------------------------

(define (mostra-conceitos-turma la)
  (cond
    ; se lista vazia, devolve imagem vazia
    [(empty? la) empty-image]
    [else (above
      (beside (nome-aluno-desenho la)
              (desenha-lista-formas-com-nomes la)
              (conceito-aluno-desenho la)) (mostra-conceitos-turma (rest la)))]))

; EXEMPLOS E TESTES:
;(mostra-conceitos-turma ListaDeAlunos0)
;(mostra-conceitos-turma ListaDeAlunos1)
;(mostra-conceitos-turma ListaDeAlunos2)
;(mostra-conceitos-turma ListaDeAlunos3)
;(mostra-conceitos-turma ListaDeAlunos4)
