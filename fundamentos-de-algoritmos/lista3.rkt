; CÓDIGO FEITO NO APLICATIVO DRRACKET (definições de dados não são documentadas)

;; ============================================
;; DEFINIÇÕES DE TIPOS DE DADOS (não modificar)
;; ============================================

;; ------------------
;; TIPO GENERO:
;; ------------------
;; Um Genero é
;; 1. a string "feminino", ou
;; 2. a string "masculino", ou
;; 3. a srting "outros"

;; ------------------
;; TIPO FUNCIONARIO:
;; ------------------
(define-struct funcionario (nome genero anos-empresa destaque?))
;; Um elemento do conjunto Funcionario tem o formato
;;     (make-funcionario n g a d) onde
;;      n: String, é o nome do funcionário,
;;      g: Genero, é o genero do funcionário,
;;      a: Número, representa os anos de serviço na empresa do funcionário,
;;      d: Boolean, representa se funcionário foi o destaque o mês.

;; ------------------
;; TIPO SETOR:
;; ------------------
(define-struct setor (nome membros))
;; Um elemento do conjunto Setor tem o formato
;;     (make-setor nome lmemb) onde
;;     nome: String, é o nome do setor e
;;     lmemb: Lista-membros, é uma lista de membros deste setor.

;; ------------------
;; TIPO LISTA-MEMBROS:
;; ------------------
;; Uma Lista-membros é
;; 1. empty (vazia), ou
;; 2. (cons f lm), onde f : Funcionario, e lm : Lista-membros, ou
;; 3. (cons s lm), onde s : Setor, e  lm : Lista-membros.

;; =========================================================================
;;                                 QUESTÃO 1
;; OBJETIVO: definir 10 constantes do tipo Funcionario e 4 constantes do
;; tipo Setor, ao menos um setor deve ter mais 2 níveis de subsetores
;; =========================================================================

; 10 constantes do tipo Funcionario
(define F1
  (make-funcionario "Luísa" "feminino" 3 #t)) 
(define F2
  (make-funcionario "Sofia" "feminino" 7 #t))
(define F3
  (make-funcionario "Carolina" "feminino" 30 #f))
(define F4
  (make-funcionario "Isabella" "feminino" 1 #f))
(define F5
  (make-funcionario "Nicolas" "masculino" 8 #f))
(define F6
  (make-funcionario "Rodrigo" "masculino" 10 #t))
(define F7
  (make-funcionario "João" "masculino" 7 #t))
(define F8
  (make-funcionario "Cauã" "masculino" 5 #t))
(define F9
  (make-funcionario "Arthur" "masculino" 2 #f))
(define F10
  (make-funcionario "Gabriel" "masculino" 9 #f))
(define F11
  (make-funcionario "Rafael" "outro" 4 #t))



; Lista-membros
(define Lista-membros1 (list F1 F3 F5 F7))
(define Lista-membros2 (list F2 F4 F8 F9))
(define Lista-membros3 (list F5 F6 F1 F4))
(define Lista-membros4 (list F10 F8 F9 F3))

; Sub-setores
(define SUBSETOR1
  (make-setor "Sub-Setor1" (list Lista-membros1 Lista-membros2)))
(define SUBSETOR2
  (make-setor "Sub-Setor2" (list Lista-membros4 Lista-membros3)))
(define SUBSETOR3
  (make-setor "Sub-Setor3" (list SUBSETOR2 SUBSETOR1)))
  
; 4 constantes do tipo Setor
(define SETOR1
  (make-setor "Setor de Desenvolvimento" Lista-membros4))
(define SETOR2
  (make-setor "Setor de Projetos" Lista-membros3))
(define SETOR3
  (make-setor "Setor de Marketing" Lista-membros2))
(define SETOR4
  (make-setor "Setor de Recursos Humanos" (list Lista-membros3 SUBSETOR1)))
(define SETOR5
  (make-setor "Setor de Design" Lista-membros1))
(define SETOR6
  (make-setor "Setor Financeiro" (list SUBSETOR1 SUBSETOR2)))
(define SETOR7
  (make-setor "Setor Administrativo" (list F11 SUBSETOR3)))
  

; TESTES E EXEMPLOS
(check-expect F1 (make-funcionario "Luísa" "feminino" 3 #t))
(check-expect SETOR3 (make-setor "Setor de Marketing" (list
                                                       (make-funcionario "Sofia" "feminino" 7 #true)
                                                       (make-funcionario "Isabella" "feminino" 1 #false)
                                                       (make-funcionario "Cauã" "masculino" 5 #true)
                                                       (make-funcionario "Arthur" "masculino" 2 #false))))

;; =========================================================================
;;                                 QUESTÃO 2
;; OBJETIVO: definir uma função que recebe um setor e um genero, devolve a
;; quantidade de funcionários deste gênero no setor informado.
;; =========================================================================
;; quantidade-por-genero: setor genero -> numero

(define (quantidade-por-genero setor genero)
  (cond
    ; se setor-membros vazio, devolve 0
    [(empty? (setor-membros setor)) 0]
    ;se o setor recebido tiver funcionario na lista de membros, entao
    [(funcionario? (first (setor-membros setor)))
     (+
      (cond
        ;[(empty? setor) 0]
        ;se o genero do primero funcionario for igual ao genero recebido, soma 1
        [(string=? (funcionario-genero (first (setor-membros setor))) genero) (+ (quantidade-por-genero (make-setor (setor-nome setor) (rest (setor-membros setor))) genero) 1)]
        ;senão, verifica o genero do resto dos membros da lista
        [else (quantidade-por-genero (make-setor (setor-nome setor) (rest (setor-membros setor))) genero)]))]
    ;senão se o setor recebido tiver subsetores, entao
    [else
     (+
      ;checa se o primeiro membro for do genero informado e aplica a soma na função
      (quantidade-por-genero (first (setor-membros setor)) genero)
      (quantidade-por-genero (make-setor (setor-nome setor) (rest (setor-membros setor))) genero))]))


; EXEMPLOS E TESTES
(check-expect (quantidade-por-genero SETOR5 "feminino") 2)
(check-expect (quantidade-por-genero SETOR1 "masculino") 3)
(check-expect (quantidade-por-genero SETOR2 "outro") 0)
  
;; =========================================================================
;;                                 QUESTÃO 3
;; OBJETIVO: receber uma lista de números naturais e devolver o número maximo
;; desta lista. Se lista vazia, devolve zero.
;; =========================================================================

;; ------------------
;; TIPO ListaNum:
;; ------------------
;; Uma ListaNum é
;; 1. empty (vazia), ou
;; 2. (cons n), onde n é um numero natural

; Listas de Numeros Naturais
(define ListaNum0 empty)
(define ListaNum1 (list 1 3 5 2))
(define ListaNum2 (list 2 9 4 8))
(define ListaNum3 (list 6 10 1 7))

; maximo: ListaNum -> numero
(define (maximo ln)
  (cond
    ; se lista vazia, devolve 0
    [(empty? ln) 0]
    ;se primeiro numero na lista for maior que o primeiro do resto da lista, devolve o primeiro da lista
    [(> (first ln) (first (rest ln))) (first ln)]
    ;senão,
    [else
     (maximo (rest ln))]))

; EXEMPLOS E TESTES
(check-expect (maximo ListaNum0) 0)
(check-expect (maximo ListaNum1) 5)
(check-expect (maximo ListaNum2) 9)
(check-expect (maximo ListaNum3) 10)

;; =========================================================================
;;                                 QUESTÃO 4
;; OBJETIVO: contruir duas funções: uma verifica o maior grau de um setor
;; (qual nó possui maior quantidade de subsetores) e a outra verifica a altura
;; de um setor (um setor sem funcionarios tem altura zero, um setor com
;; funcionarios mas sem subsetores tem altura 1).
;; =========================================================================

;constante extra para teste
(define S8
  (make-setor "Empresa Teste" (list SETOR1 SETOR2 SETOR3 SETOR4)))

; grau: setor -> numero
(define (grau s)
  (max (list (grau-elemento s) (grau-setor s))))

; grau-elemento: setor -> numero
(define (grau-elemento s)
  (cond
    ; se setor-membros vazio, devolve 0
    [(empty? (setor-membros s)) 0]
    ; senão
    [else
     ; soma 1 e aplica a função ao próximo elemento
     (+ (grau-elemento (make-setor (setor-nome s) (rest (setor-membros s)))) 1)]))

; grau-setor: setor -> numero
(define (grau-setor s)
  (cond
    ; se setor-membros vazio, devolve 0
    [(empty? (setor-membros s)) 0]
    ; se primeiro elemento de setor-membros for um setor
    [(setor? (first (setor-membros s)))
     ; utiliza o valor maximo
     (max (cons
              ; do grau do primeiro elemenro
              (grau-elemento (first (setor-membros s)))
              ; aplica a a função para os próximos elementos 
              (grau (first (setor-membros s)))
              ; aplica a função para o resto dos elementos de setor-membros
              (grau (make-setor (setor-nome s) (rest (setor-membros s))))))]
    ; senão
    [else
     ;aplica a função ao resto
     (grau (make-setor (setor-nome s) (rest (setor-membros s))))]))

;..........................

; altura: setor -> numero
(define (altura s)
  (cond
    [(empty? (setor-membros s)) 0]
    [else (+ 1 (soma-altura-setor s))]))

; soma-altura-setor: setor -> numero
(define (soma-altura-setor s)
  (cond
    ; se setor-membros vazio, devolve 0
    [(empty? (setor-membros s)) 0]
    ; se primeiro elemento for um funcionario, calcula a altura do resto de setor membros
    [(funcionario? (first (setor-membros s))) (soma-altura-setor (make-setor (setor-nome s) (rest (setor-membros s))))]
    ; senão
    [else
     ;verifica a maior altura 
     (maximo (cons
              ; entre os primeiros subsetores do setor recebido
              (+ (soma-altura-setor (first (setor-membros s))) (cond
                                                      [(empty? (setor-membros (first (setor-membros s)))) 0]
                                                      [else 1]))
              ; entre os próximos subsetores
              (soma-altura-setor (make-setor (setor-nome s) (rest (setor-membros s))))))]))

;..........................

; TESTES E EXEMPLOS
(check-expect (altura SETOR1) 1)
(check-expect (altura SETOR5) 1)

;; =========================================================================
;;                                 QUESTÃO 5
;; OBJETIVO: dado um setor, mostra a árvore que esse setor representa. De
;; acordo com os requisitos.
;; =========================================================================
;; gera-imagem-setor: setor -> imagem

(define (gera-imagem-setor s)
  (above
    (imagem-setor s)
    (cond
       [(funcionario? (first (setor-membros s))) (imagem-funcionario (setor-membros s))]
       [(setor? (first (setor-membros s))) (gera-imagem-mem-setor s)])))

;(gera-imagem-setor SETOR1)  = .

; -------------------------------

; FUNÇÕES AUXILIARES

; gera-imagem-mem-setor: setor -> imagem

(define (gera-imagem-mem-setor s)
  (cond
    [(setor? (first (setor-membros s))) (above (imagem-setor s) (imagem-funcionario (setor-membros s)))]
    [(funcionario? (first (setor-membros s))) (imagem-funcionario (setor-membros s))]
    [else empty-image]))

; -------------------------------

; imagem-funcionario: listamembros -> imagem
; objetivo: recebe uma lm e devolve uma imagem com todos os membros desta lm
(define (imagem-funcionario lm)
  ; alinha um em cima do outro na esquerda
  (above/align "left"
   (cond
     ; se lm estiver vazia, devolve imagem vazia
    [(empty? lm) empty-image]
    ; se for setor, aplica a função imagem-setor
    [(setor? lm) (imagem-setor lm)]
    ; se for funcionario destaque aplica a função é destaque
    [(funcionario-destaque? (first lm)) (é-destaque (first lm))]
    ; senão
    [else
     ;  se nao for desaque, aplica a função cor-genero
     (cor-genero (first lm))])
   (cond
    ; se lm estiver vazia, devolve imagem vazia
    [(empty? lm) empty-image]
    ; senão aplica a função ao resto de lm
    [else (imagem-funcionario (rest lm))])))

; -------------------------------

; imagem-setor: setor -> imagem
; objetivo: receber um setor e devolve a imagem deste setor
(define (imagem-setor s)
  ; alinha ao lado
   (beside
    ; texto "➔ ", nome do setor e a quantidade de funcionarios diretos
    (text (string-append "➔ " (setor-nome s) "  ") 20 "black")
    (conta-funcionariosIM (setor-membros s))))

; -------------------------------

; conta-funcionarios: lista-membros -> numero
; objetivo: somar a quantidade de funcionarios em uma lista de membros
(define (conta-funcionarios lm)
  (+
   (cond
     ;se lm vazia, devolve zero
    [(empty? lm) 0]
    ; se lm um setor, aplica a função conta-funcionarios-setor
    [(setor? lm) 0]
    [(funcionario? (first lm)) 1])
   (cond
     ; se resto de lm vazio, soma 0
    [(empty? (rest lm)) 0]
    ;senão aplica a função ao resto de lm
    [else (conta-funcionarios (rest lm))])))


; conta-funcionarios-setor: setor -> numero
(define (conta-funcionarios-setor s)
   (cond
     ;se setor-membros vazio, 0
     [(empty? (first(setor-membros s))) 0]
     ; senão aplica a função conta-funcionarios à list de membros
     [else (conta-funcionarios (setor-membros s))]))

;TESTES
(check-expect (conta-funcionarios-setor SETOR1) 4)
(check-expect (conta-funcionarios-setor SETOR5) 4)

; -------------------------------

; conta-funcionariosIM: lista-membros -> imagem
; objetivo: tranforma a função "conta-funcionarios" em uma imagem
(define (conta-funcionariosIM lm)
  (text (string-append
         "("(number->string (conta-funcionarios lm)) "  funcionários diretos)") 15 "darkgreen"))

; -------------------------------

; cor-genero: funcionario -> imagem
; objetivo: atribuir visualizações diferentes para cada gênero
(define (cor-genero f)
  (cond
    ; se funcionario-genero for igual a string "feminino" cria uma imagem
    [(string=? (funcionario-genero f) "feminino")
     (text (string-append " • "(funcionario-nome f) "  -  "(number->string(funcionario-anos-empresa f)) " ano(s) de empresa") 15 "deeppink")]
    ; se funcionario-genero for igual a string "masculino" cria uma imagem diferente do genero anterior
    [(string=? (funcionario-genero f) "masculino")
     (text (string-append " • "(funcionario-nome f) "  -  "(number->string(funcionario-anos-empresa f)) " ano(s) de empresa") 15 "blue")]
    ; se funcionario-genero for igual a string "outro" cria uma imagem diferente dos generos anteriores
    [(string=? (funcionario-genero f) "outro")
     (text (string-append " • "(funcionario-nome f) "  -  "(number->string(funcionario-anos-empresa f)) " ano(s) de empresa") 15 "purple")]))

; -------------------------------

; é-destaque?: funcionario -> imagem
;objetivo: deixar os funcionarios destaquue ressaltados

(define (é-destaque f)
  (cond
    ; se funcionario-detaque for #t, devolve uma imagem com o funcionario em destaque ressaltado com uma estrela ao lado
    [(funcionario-destaque? f)
     (beside
     (text (string-append " • "(funcionario-nome f) "  -  "(number->string(funcionario-anos-empresa f)) " ano(s) de empresa  ") 15 "gold")
     (star 10 "solid" "gold"))]))

;; =========================================================================
;;                                 QUESTÃO 6
;; OBJETIVO: dados um funcionário, o nome de um setor e a árvore de setores
;; de uma empresa e inclui o funcionario informado no setor indicado
;; =========================================================================
;; insere-funcionario: funcionario string setor -> SetorOuString

;;---------------------
;; TIPO SetorOuString
;;---------------------
;; Um SetorOuString é
;; 1. um Setor, ou
;; 2. uma string "Setor não existente!"

(define (insere-funcionario f nome s)
  (cond
    ; se setor-membros vazio, devolve a lista com o setor membros vazia
    [(empty? (setor-membros s)) (make-setor (setor-nome s) empty)]
    ; se primeiro elemento de setor-membros for um setor, adicionamos o funcionario recebido ao setor informado 
    [(setor? (first (setor-membros s))) (make-setor (setor-nome s) (insere-funcionario-setor f nome (first (setor-membros s))))]
    ; se primeiro elemento de setor-membros for um funcionario, aplica a funcao insere-funcionario-setor ao funcionario
    [(funcionario? (first (setor-membros s))) (make-setor (setor-nome s) (insere-funcionario-setor f nome (setor-membros s)))]
    ; senão
    [else (insere-funcionario-setor f nome s)]))


; insere-funcionario-setor: funcionario string setor -> SetorOuString
(define (insere-funcionario-setor f nome s)
  (cond
    ; se setor-membros vazio, devolve a lista com o setor membros vazia
    [(empty? (first(setor-membros s))) (make-setor (setor-nome s) empty)]
    ; se o nome do setor for igual a string recebida, adiciona o funcionario ao setor
    [(string=? (setor-nome s) nome) (make-setor (setor-nome s) (cons f (list (setor-membros s))))]
    ; se nome nao for igual a string recebida, devolve "Setor não existente!"
    [(not (string=? (setor-nome s) nome)) "Setor não existente!"]
    ; senão, 
    [else (insere-funcionario f nome s)]))


  
; TESTES E EXEMPLOS
(check-expect (insere-funcionario F11 "Sub-Setor1" SETOR6)(make-setor "Setor Financeiro" (make-setor
                                                                                                   "Sub-Setor1" (list
                                                                                                                 (make-funcionario "Rafael" "outro" 4 #true)
                                                                                                                 (list
                                                                                                                   (list
                                                                                                                    (make-funcionario "Luísa" "feminino" 3 #true)
                                                                                                                    (make-funcionario "Carolina" "feminino" 30 #false)
                                                                                                                    (make-funcionario "Nicolas" "masculino" 8 #false)
                                                                                                                    (make-funcionario "João" "masculino" 7 #true))
                                                                                                                   (list
                                                                                                                    (make-funcionario "Sofia" "feminino" 7 #true)
                                                                                                                    (make-funcionario "Isabella" "feminino" 1 #false)
                                                                                                                    (make-funcionario "Cauã" "masculino" 5 #true)
                                                                                                                    (make-funcionario "Arthur" "masculino" 2 #false)))))))

(check-expect (insere-funcionario F11 "Setor de Recursos Humanos" SETOR4)(make-setor "Setor de Recursos Humanos" (list
                                                                                                          (make-funcionario "Rafael" "outro" 4 #true)
                                                                                                          (list
                                                                                                           (list
                                                                                                            (make-funcionario "Nicolas" "masculino" 8 #false)
                                                                                                            (make-funcionario "Rodrigo" "masculino" 10 #true)
                                                                                                            (make-funcionario "Luísa" "feminino" 3 #true)
                                                                                                            (make-funcionario "Isabella" "feminino" 1 #false))
                                                                                                           (make-setor "Sub-Setor1" (list
                                                                                                                                     (list
                                                                                                                                      (make-funcionario "Luísa" "feminino" 3 #true)
                                                                                                                                      (make-funcionario "Carolina" "feminino" 30 #false)
                                                                                                                                      (make-funcionario "Nicolas" "masculino" 8 #false)
                                                                                                                                      (make-funcionario "João" "masculino" 7 #true))
                                                                                                                                     (list
                                                                                                                                      (make-funcionario "Sofia" "feminino" 7 #true)
                                                                                                                                      (make-funcionario "Isabella" "feminino" 1 #false)
                                                                                                                                      (make-funcionario "Cauã" "masculino" 5 #true)
                                                                                                                                      (make-funcionario "Arthur" "masculino" 2 #false))))))))

(check-expect (insere-funcionario F11 "Setor de Desenvolvimento" SETOR4) "Setor não existente!")
