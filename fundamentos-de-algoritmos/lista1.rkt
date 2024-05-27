; CÓDIGO FEITO NO APLICATIVO DRRACKET (definições de dados e funções que devolvem imagens não são documentadas)

;#####################################################################################################
;### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 #####
;#####################################################################################################
;=====================================================================================================
;Defina um tipo de dados chamado Pet, que deve registrar o nome do animal de estimação (pet), a sua cor,
;a sua idade, o nome do seu dono e de que tipo de animal ele é (ex.: "Gato", "Cachorro", "Cavalo", etc).
;Defina 4 constantes cujos valores sejam do tipo Pet. Adicionalmente, defina um tipo de dados chamado
;Vet, que deve registrar o nome do veterinário, o seu turno de plantão, a sua especialidade (se realiza
;atendimento em "Gato", "Cachorro", "Cavalo", etc) e os três Pets que ele pode realizar o atendimento.
;Defina 4 constantes cujos valores sejam do tipo Vet.
;=====================================================================================================
; Pet -> string string number string string
;objetivo: definir a estrutura da função Pet para informar dados sem necessidade de repetição
(define-struct Pet (nomePet cor idade nomeDono tipo))
; (make-Pet nP c i nD t)
; onde:
;  nP: string, representa o nome do animal
;  c: string, representa a cor do animal
;  i: number, representa a idade (em anos) do animal
;  nD: string, representa o nome do dono do animal
;  t: string, representa o tipo de animal

; EXEMPLOS
(define PETGATO
        (make-Pet "Napolitano"
                  "Tricolor"
                  9
                  "Luiza"
                  "Gato")
)

(define PETGATO1
        (make-Pet "Mary Jane"
                  "Frajola"
                  5
                  "Valentina"
                  "Gato"))

(define PETGATO2
        (make-Pet "Princesa"
                  "Branco"
                  3
                  "Carlos"
                  "Gato"))

(define PETGATO3 (make-Pet "Antonio"
                           "Siames"
                           1
                           "Marcela"
                           "Gato"))

(define PETCACHORRO
        (make-Pet "Peter Parker"
                  "Branco"
                  5
                  "Luisa"
                  "Cachorro"))

(define PETCACHORRO1 (make-Pet "Spike"
                             "Caramelo"
                             7
                             "Pedro"
                             "Cachorro"))

(define PETCACHORRO2 (make-Pet "Rufus"
                             "Marrom"
                             6
                             "Marco"
                             "Cachorro"))

(define PETCACHORRO3 (make-Pet "Bella"
                               "Cinza"
                               3
                               "Rosa"
                               "Cachorro"))

(define PETCAVALO
        (make-Pet "Cócega"
                  "Preto"
                  9
                  "Isabella"
                  "Cavalo")
 )

(define PETCAVALO1 (make-Pet "Marcela"
                              "Branco"
                              8
                              "Carla"
                              "Cavalo"))

(define PETCAVALO2 (make-Pet "Mimosa"
                             "Marrom"
                             5
                             "Francisco"
                             "Cavalo"))


(define PETPERIQUITO
         (make-Pet "Fernando Alonso"
                   "Verde"
                   6
                   "Sofia"
                   "Periquito"))

(define PETPERIQUITO1 (make-Pet "Felipe Massa"
                                "Amarelo"
                                2
                                "Marcia"
                                "Periquito"))


; TESTES
(check-expect PETGATO (make-Pet "Napolitano"
                  "Tricolor"
                  9
                  "Luiza"
                  "Gato"))
(check-expect PETCACHORRO (make-Pet "Peter Parker"
                  "Branco"
                  5
                  "Luisa"
                  "Cachorro"))
(check-expect PETCAVALO (make-Pet "Cócega"
                  "Preto"
                  9
                  "Isabella"
                  "Cavalo"))
(check-expect PETPERIQUITO (make-Pet "Fernando Alonso"
                   "Verde"
                   6
                   "Sofia"
                   "Periquito"))

;--------------------------------
; TIPO PetOuString:
; i) Pet
; ii) String
;--------------------------------

; Vet -> string string string string string string
; objetivo: definir a função Vet para para informar dados sem necessidade de repetição 
(define-struct Vet (nomeVet turno especialidade pet1 pet2 pet3))
; (make-Vet nV t e p1 p2 p3)
; onde:
;  nV: string, representa o nome do veterinario
;  t: string, representa o turno do veterinario
;  e: string, representa a especialidade em que o veterinario reliza atendimento
;  p1: string, pets que o veterinaio pode realizar o atendimento
;  p2: string, pets que o veterinaio pode realizar o atendimento
;  p3: string, pets que o veterinaio pode realizar o atendimento

;EXEMPLOS
(define VETCAROLINA
        (make-Vet "Carolina"
                  "Manhã"
                  "Periquitos"
                  "Livre"
                  PETPERIQUITO
                  "Livre"))

(define VETMARIA
        (make-Vet "Maria"
                  "Tarde"
                  "Gatos"
                  PETGATO
                  "Livre"
                  PETGATO1))
(define VETVINICIUS
         (make-Vet "Vinicius"
                   "Noite"
                   "Cachorros"
                   PETCACHORRO
                   PETCACHORRO1
                   PETCACHORRO2))

(define VETFERNANDO
          (make-Vet "Fernando"
                    "Tarde"
                    "Cavalos"
                    PETCAVALO
                    PETCAVALO1
                    "Livre"))

(define VETPINGU
  (make-Vet "Pingu"
            "Manhã"
            "Periquitos"
            PETPERIQUITO1
            "Livre"
            "Livre"))
                

; TESTES
(check-expect VETCAROLINA (make-Vet "Carolina"
                  "Manhã"
                  "Periquitos"
                  "Livre"
                  PETPERIQUITO
                  "Livre"))

(check-expect VETMARIA (make-Vet "Maria"
                  "Tarde"
                  "Gatos"
                  PETGATO
                  "Livre"
                  PETGATO1))

(check-expect VETVINICIUS (make-Vet "Vinicius"
                   "Noite"
                   "Cachorros"
                   PETCACHORRO
                   PETCACHORRO1
                   PETCACHORRO2))

(check-expect VETFERNANDO (make-Vet "Fernando"
                    "Tarde"
                    "Cavalos"
                    PETCAVALO
                    PETCAVALO1
                    "Livre"))



;#####################################################################################################
;### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 ### 1 #####
;#####################################################################################################




;#####################################################################################################
;### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 #####
;#####################################################################################################
;=====================================================================================================
;Desenvolva um função chamada é-pet? que, dado um Pet ou uma String, verifica se a entrada é do tipo
;Pet ou do tipo String, retornando verdadeiro se for do tipo Pet e falso caso contrário.
;=====================================================================================================



; ---------------
; FUNÇÃO  é-pet?: petOrString -> boolean
; OBJETIVO: verificar se a variável informada é do tipo Pet, definida anteriormente, e retorna verdadeiro
; quando o resultado for do tipo Pet, e falso quando nao for do tipo Pet
; ---------------

(define (é-Pet? petOuString)
  (cond
    ; verifica se a variável recebida é do tipo pet, se sim, retorna true
    [(Pet? petOuString) true]
    ; se não, false
    [else false]))

; EXEMPLOS:
; (é-Pet? "napolitano") -> #false
; (é-Pet? "PETGATO") -> #true
; (é-Pet? 2) -> #false


; TESTES
(check-expect (é-Pet? PETCAVALO) #true)
(check-expect (é-Pet? "Peter Parker") #false)
(check-expect (é-Pet? 2) #false)

 
;#####################################################################################################
;### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 ### 2 #####
;#####################################################################################################



;#####################################################################################################
;### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 #####
;#####################################################################################################
;=====================================================================================================
;Desenvolva uma função que dado um veterinário realiza a verificação de disponibilidade de em sua
;agenda, gerando um resultado verdadeiro se alguma das posições de Pets está livre. Caso contrário,
;gera um resultado falso.
;=====================================================================================================

; ---------------------------------
; FUNÇÃO  verifica-disponibilidade:
; verifica-disponibilidade -> booleano
; OBJETIVO: verificar se a agenda do veterinario esta cheia, caso sim, retorna #false e caso nao esteja
; cheia, retorna #true
; ---------------------------------

(define (verifica-disponibilidade Vet)
  (cond
    ; Verifica se tem uma string em Vet-pet[numerodopet], caso seja uma string, neste caso "Livre", retorna #true. 
    [(or (string? (Vet-pet1 Vet))
         (string? (Vet-pet2 Vet))
         (string? (Vet-pet3 Vet))) #true]
    ; Caso não seja uma string, retorna #false
    [else #false]))

; EXEMPLOS
; (verifica-disponibilidade VETCAROLINA) -> #true
; (verifica-disponibilidade VETVINICIUS) -> #false
; (verifica-disponibilidade VETFERNANDO) -> #true

; TESTES
(check-expect (verifica-disponibilidade VETCAROLINA) true)
(check-expect (verifica-disponibilidade VETVINICIUS) false)
(check-expect (verifica-disponibilidade VETFERNANDO) true)

;#####################################################################################################
;### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 ### 3 #####
;#####################################################################################################


;#####################################################################################################
;### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 #####
;#####################################################################################################
;=====================================================================================================
;Quando um animal chega na petshop para ser atendido, deve ser verificado se o veterinário pode ou não
;atendê-lo. Desenvolva uma função chamada adiciona-pet que, dado um veterinário e um animal, nesta ordem,
;realiza o encaminhamento deste animal para este veterinário. O animal deve ser inserido na primeira
;posição de atendimento livre do veterinário, gerando assim um novo registro de veterinário. Caso não
;seja possível o encaixe (ou seja, caso todas as posições estejam ocupadas), devolver a frase
;"Sem horário disponível".
;=====================================================================================================

; ---------------------
; TIPO VetOuString:
; O tipo misto pode ser:
; i) Vet, ou
; ii) string "Sem horário disponível"
; ---------------------

; ---------------------
; FUNÇÃO  adiciona-pet: vet pet -> VetOuString
; OBJETIVO: Receber um Vet e um Pet, nesta ordem e encaminha o animal para o veterinario escolhido.
; ---------------------

(define (adiciona-pet vet pet)
  (cond
    ; se pet de Vet tiver uma string (a string "Livre") em seus dados, aloca o pet recebido  no lugar da string "Livre"
    [(string? (Vet-pet1 vet))(make-Vet(Vet-nomeVet vet)(Vet-turno vet)(Vet-especialidade vet) pet (Vet-pet2 vet)(Vet-pet3 vet))]
    [(string? (Vet-pet2 vet))(make-Vet(Vet-nomeVet vet)(Vet-turno vet)(Vet-especialidade vet)(Vet-pet1 vet) pet (Vet-pet3 vet))]
    [(string? (Vet-pet3 vet))(make-Vet(Vet-nomeVet vet)(Vet-turno vet)(Vet-especialidade vet)(Vet-pet1 vet)(Vet-pet2 vet) pet)]
    ; se não, retorna a strind "Sem horário disponível"
    [else "Sem horário disponível"]))

; EXEMPLOS
; (adiciona-pet VETCAROLINA PETPERIQUITO1) -> (make-Vet
;                                                             "Carolina"
;                                                             "Manhã"
;                                                             "Periquitos"
;                                                             (make-Pet "Felipe Massa" "Amarelo" 2 "Marcia" "Periquito")
;                                                             (make-Pet "Fernando Alonso" "Verde" 6 "Sofia" "Periquito")
;                                                              "Livre"))

; (adiciona-pet VETVINICIUS PETCACHORRO3) -> "Sem horário disponível"

; (adiciona-pet VETMARIA PETGATO3) -> (make-Vet
;                                                    "Maria"
;                                                    "Tarde"
;                                                    "Gatos"
;                                                    (make-Pet "Napolitano" "Tricolor" 9 "Luiza" "Gato")
;                                                    (make-Pet "Antonio" "Siames" 1 "Marcela" "Gato")
;                                                    (make-Pet "Mary Jane" "Frajola" 5 "Valentina" "Gato"))

; TESTES
(check-expect (adiciona-pet VETCAROLINA PETPERIQUITO1) (make-Vet
                                                             "Carolina"
                                                             "Manhã"
                                                             "Periquitos"
                                                             (make-Pet "Felipe Massa" "Amarelo" 2 "Marcia" "Periquito")
                                                             (make-Pet "Fernando Alonso" "Verde" 6 "Sofia" "Periquito")
                                                              "Livre"))

(check-expect (adiciona-pet VETVINICIUS PETCACHORRO3) "Sem horário disponível")

(check-expect (adiciona-pet VETMARIA PETGATO3) (make-Vet
                                                    "Maria"
                                                    "Tarde"
                                                    "Gatos"
                                                    (make-Pet "Napolitano" "Tricolor" 9 "Luiza" "Gato")
                                                    (make-Pet "Antonio" "Siames" 1 "Marcela" "Gato")
                                                    (make-Pet "Mary Jane" "Frajola" 5 "Valentina" "Gato")))


;#####################################################################################################
;### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 ### 4 #####
;#####################################################################################################


;#####################################################################################################
;### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 #####
;#####################################################################################################
;=====================================================================================================
;Defina um tipo de dados chamado PetShop, que deve registrar o nome do local, o endereço do local,
;o telefone de contato, e os dois veterinários que estão de plantão no momento. Defina 3 constantes
;cujos valores sejam do tipo PetShop.
;=====================================================================================================

;OBJETIVO: define PETSHOP, com nome, endereço, telefone e veterinarios de plantao

(define-struct PetShop (nomeEmpresa endereco telefone plantaoVet1 plantaoVet2))
; (make-PetShop nE e t pV1 pV2)
; onde:
;   nE: string, representa o nome da empresa
;   e: string, representa o endereco da empresa
;   t: number, representa o telefone para contato da empresa
;   pV1 e pV2: string, representa os veterinarios de plantao

;EXEMPLOS
(define clubPenguin
         (make-PetShop "Club Penguin"
                       "Rua Larga, 123 - Porto Alegre"
                       32456789
                       VETCAROLINA
                       VETVINICIUS))

(define littlestPetShop
          (make-PetShop "Littlelest Pet Shop"
                                "Avenida Bento Gonçalves, 456 - Porto Alegre"
                                32476589
                                VETMARIA
                                VETFERNANDO))

(define terraria
           (make-PetShop "Terraria"
                          "Avenida Winceslau Escobar, 789"
                          33445566
                          VETCAROLINA
                          VETFERNANDO))

(define caoPeludo
          (make-PetShop "Cão Peludo"
                        "Avenida Longe Demais, 900"
                        36784567
                        VETVINICIUS
                        VETPINGU))

; TESTES
(check-expect clubPenguin (make-PetShop
                              "Club Penguin"
                              "Rua Larga, 123 - Porto Alegre"
                              32456789
                              (make-Vet
                                  "Carolina"
                                  "Manhã"
                                  "Periquitos"
                                  "Livre"
                              (make-Pet "Fernando Alonso" "Verde" 6 "Sofia" "Periquito")
                              "Livre")
                              (make-Vet
                                   "Vinicius"
                                   "Noite"
                                   "Cachorros"
                              (make-Pet "Peter Parker" "Branco" 5 "Luisa" "Cachorro")
                              (make-Pet "Spike" "Caramelo" 7 "Pedro" "Cachorro")
                              (make-Pet "Rufus" "Marrom" 6 "Marco" "Cachorro"))))

(check-expect littlestPetShop (make-PetShop
                                    "Littlelest Pet Shop"
                                    "Avenida Bento Gonçalves, 456 - Porto Alegre"
                                     32476589
                                    (make-Vet
                                          "Maria"
                                          "Tarde"
                                          "Gatos"
                                    (make-Pet "Napolitano" "Tricolor" 9 "Luiza" "Gato")
                                    "Livre"
                                    (make-Pet "Mary Jane" "Frajola" 5 "Valentina" "Gato"))
                                    (make-Vet
                                        "Fernando"
                                        "Tarde"
                                        "Cavalos"
                                    (make-Pet "Cócega" "Preto" 9 "Isabella" "Cavalo")
                                    (make-Pet "Marcela" "Branco" 8 "Carla" "Cavalo")
                                    "Livre")))

(check-expect terraria (make-PetShop
                            "Terraria"
                            "Avenida Winceslau Escobar, 789"
                            33445566
                            (make-Vet
                               "Carolina"
                               "Manhã"
                               "Periquitos"
                               "Livre"
                            (make-Pet "Fernando Alonso" "Verde" 6 "Sofia" "Periquito")
                            "Livre")
                            (make-Vet
                                "Fernando"
                                "Tarde"
                                "Cavalos"
                           (make-Pet "Cócega" "Preto" 9 "Isabella" "Cavalo")
                           (make-Pet "Marcela" "Branco" 8 "Carla" "Cavalo")
                           "Livre")))

;#####################################################################################################
;### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 ### 5 #####
;#####################################################################################################



;#####################################################################################################
;### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 #####
;#####################################################################################################
;=====================================================================================================
;No momento da troca de turno, o registro da petshop deve ser atualizado, removendo os veterinários que
;não atuam no novo turno de trabalho. Construa uma função chamada termina-plantão que, dados uma PetShop
;e o novo turno (que pode ser "Manhã", "Tarde" ou "Noite"), nesta ordem, remove do registro os
;veterinários que não atuam neste novo turno. No caso de um veterinário ser removido, o registro deste
;veterinário na petshop deve atualizado para ao valor "vago". 
;=====================================================================================================
; CONTRATO: termina-plantão: petshop string -> petshop
; OBJETIVO: recebendo a petshop e o turno, remove do registro os veterinarios que não atuam no turno
; informado, quando isso acontecer, deve informar "vago"
; !!!!! ATENÇÃO: a string que define o turno deve ser recebida IGUAL a forma que está escrita nos dados de PetShop!!!!!!!

(define (termina-plantão petshop turno)

(cond
  ; se o turno recebido for a string "Manhã" devolve os veterinários que trabalham no turno da manhã
  [(and (string=? "Manhã" (Vet-turno (PetShop-plantaoVet1 petshop)))(string=? "Manhã" (Vet-turno (PetShop-plantaoVet2 petshop)))) (make-PetShop (PetShop-nomeEmpresa petshop) (PetShop-endereco petshop) (PetShop-telefone petshop) (PetShop-plantaoVet1 petshop) (PetShop-plantaoVet2 petshop))]
  [(not (string=? "Manhã" (Vet-turno (PetShop-plantaoVet1 petshop))))(make-PetShop (PetShop-nomeEmpresa petshop) (PetShop-endereco petshop) (PetShop-telefone petshop) (PetShop-plantaoVet1 petshop) "vago")]
  [(not (string=? "Manhã" (Vet-turno (PetShop-plantaoVet1 petshop)))) (make-PetShop (PetShop-nomeEmpresa petshop) (PetShop-endereco petshop) (PetShop-telefone petshop) "vago" (PetShop-plantaoVet2 petshop))]

  ; se o turno recebido for a string "Tarde" devolve os veterinários que trabalham no turno da tarde
  [(and (string=? "Tarde" (Vet-turno (PetShop-plantaoVet1 petshop)))(string=? "Tarde" (Vet-turno (PetShop-plantaoVet2 petshop)))) (make-PetShop (PetShop-nomeEmpresa petshop) (PetShop-endereco petshop) (PetShop-telefone petshop) (PetShop-plantaoVet1 petshop) (PetShop-plantaoVet2 petshop))]
  [(not (string=? "Tarde" (Vet-turno (PetShop-plantaoVet1 petshop))))(make-PetShop (PetShop-nomeEmpresa petshop) (PetShop-endereco petshop) (PetShop-telefone petshop) (PetShop-plantaoVet1 petshop) "vago")]
  [(not (string=? "Tarde" (Vet-turno (PetShop-plantaoVet1 petshop)))) (make-PetShop (PetShop-nomeEmpresa petshop) (PetShop-endereco petshop) (PetShop-telefone petshop) "vago" (PetShop-plantaoVet2 petshop))]

  ; se o turno recebido for a string "Noite" devolve os veterinários que trabalham no turno da noite
  [(and (string=? "Noite" (Vet-turno (PetShop-plantaoVet1 petshop)))(string=? "Noite" (Vet-turno (PetShop-plantaoVet2 petshop)))) (make-PetShop (PetShop-nomeEmpresa petshop) (PetShop-endereco petshop) (PetShop-telefone petshop) (PetShop-plantaoVet1 petshop) (PetShop-plantaoVet2 petshop))]
  [(not (string=? "Noite" (Vet-turno (PetShop-plantaoVet1 petshop))))(make-PetShop (PetShop-nomeEmpresa petshop) (PetShop-endereco petshop) (PetShop-telefone petshop) (PetShop-plantaoVet1 petshop) "vago")]
  [(not (string=? "Noite" (Vet-turno (PetShop-plantaoVet1 petshop)))) (make-PetShop (PetShop-nomeEmpresa petshop) (PetShop-endereco petshop) (PetShop-telefone petshop) "vago" (PetShop-plantaoVet2 petshop))]

  [else (make-PetShop (PetShop-nomeEmpresa petshop) (PetShop-endereco petshop) (PetShop-telefone petshop) "vago" "vago")]))

; EXEMPLO
;(termina-plantão clubPenguin "Manhã")
;(termina-plantão terraria "Manhã")

;TESTES
(check-expect (termina-plantão clubPenguin "Manhã") (make-PetShop
                                                          "Club Penguin"
                                                          "Rua Larga, 123 - Porto Alegre"
                                                          32456789
                                                          (make-Vet
                                                               "Carolina"
                                                               "Manhã"
                                                               "Periquitos"
                                                               "Livre"
                                                              (make-Pet
                                                                   "Fernando Alonso"
                                                                   "Verde"
                                                                   6
                                                                   "Sofia"
                                                                   "Periquito")
                                                               "Livre")
                                                          "vago"))

;#####################################################################################################
;### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 ### 6 #####
;#####################################################################################################


;#####################################################################################################
;### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 #####
;#####################################################################################################
;=====================================================================================================
;Quando um animal chega na petshop para atendimento, é necessário verificar se algum dos veterinários
;de plantão presta atendimento para este tipo de animal e tem horário livre para atendê-lo. Desenvolva
;uma função chamada aloca-pet-vet que, dados um animal (tipo Pet) e uma petshop (tipo PetShop), nesta
;ordem, verifica se algum dos veterinários que estão de plantão atende este tipo de animal e se possui
;vaga para o seu atendimento. Em caso positivo, deve-se incluir este animal no primeiro espaço de
;atendimento livre do veterinário e atualizar o registro da petshop. Caso contrário, deve-se retornar
;a mensagem "Sem horário disponível".
;=====================================================================================================

; aloca-pet-vet: string string -> booleano
; OBJETIVO: verifica quais veterinarios possuem horários disponiveis para agendamento de consultas

(define (aloca-pet-vet pet petshop)
  (cond
    [(cond
       ; se não for do tipo Vet, retorna false
       [(not (Vet? (PetShop-plantaoVet1 petshop))) false]
       ; se o pet-tipo for igual à especialidade do vet , retorna true
       [(and (string=? (Vet-especialidade (PetShop-plantaoVet1 petshop))(Pet-tipo pet))(Vet? (adiciona-pet (PetShop-plantaoVet1 petshop) pet))) true]
       ; senão, retorna false e faz um novo PetShop com os Pet de acordo com o veterinario especializado
       [else false]) (make-PetShop (PetShop-nomeEmpresa petshop) (PetShop-endereco petshop) (PetShop-telefone petshop) (adiciona-pet (PetShop-plantaoVet1 petshop) pet) (PetShop-plantaoVet2 petshop))]
    
     [(cond
       [(not (Vet? (PetShop-plantaoVet2 petshop))) false]
       [(and (string=? (Vet-especialidade (PetShop-plantaoVet1 petshop))(Pet-tipo pet))(Vet? (adiciona-pet (PetShop-plantaoVet2 petshop) pet))) true]
       [else false]) (make-PetShop (PetShop-nomeEmpresa petshop) (PetShop-endereco petshop) (PetShop-telefone petshop) (PetShop-plantaoVet1 petshop) (adiciona-pet (PetShop-plantaoVet2 petshop) pet))]

     [else "Sem horário disponivel"]))

;EXEMPLO
;(aloca-pet-vet PETGATO clubPenguin)

;TESTES
(check-expect (alocapet-vet PETGATO clubPenguin) "Sem horário disponivel")

    
;#####################################################################################################
;### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 ### 7 #####
;#####################################################################################################


;#####################################################################################################
;### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 #####
;#####################################################################################################
;=====================================================================================================
;Desenvolva uma função que recebe uma PetShop e gera um prontuario dos atendimentos que serão
;realizados nestaa PetShop pelos veterinários. A saída desta função é uma imagem contendo as
;informações do Pet, do local onde foi realizado o atendimento (nome e endereço) e o nome do
;veterinário.
;=====================================================================================================

; gera-prontuario: petshop -> imagem

; OBJETIVO: gerar um prontuário que informa os atendimentos realizados na petshop solicitada.

(define (gera-prontuario petshop)
  (above
   (above
    (text (format "Prontuário do PetShop: ~a" (PetShop-nomeEmpresa petshop))30 "red")
    (text (format "Endereço: ~a" (PetShop-endereco petshop))20 "red"))
    (cond
      [(not(Vet? (PetShop-plantaoVet1 petshop))) #false]
      [else (above(cond
                     [(Pet?(Vet-pet1 (PetShop-plantaoVet1 petshop)))(above
                                                                (text(format "PET: ~a. | Cor do Pet: ~a. | Idade do Pet: ~a. | Dono do Pet: ~a. | Tipo: ~a"(Pet-nomePet(Vet-pet1 (PetShop-plantaoVet1 petshop)))(Pet-cor(Vet-pet1 (PetShop-plantaoVet1 petshop)))(Pet-idade(Vet-pet1 (PetShop-plantaoVet1 petshop)))(Pet-nomeDono(Vet-pet1 (PetShop-plantaoVet1 petshop)))(Pet-tipo(Vet-pet1 (PetShop-plantaoVet1 petshop))) ) 20 "purple")
                                                                (text(format "Veterinário do Pet: ~a"(Vet-nomeVet(PetShop-plantaoVet1 petshop)))20 "pink"))]
                     [else (rectangle 40 1 "solid" "white")])
                  (cond
                     [(Pet?(Vet-pet2 (PetShop-plantaoVet1 petshop)))(above
                                                               (text(format "PET: ~a. | Cor do Pet: ~a. | Idade do Pet: ~a. | Dono do Pet: ~a. | Tipo: ~a"(Pet-nomePet(Vet-pet2 (PetShop-plantaoVet1 petshop)))(Pet-cor(Vet-pet2 (PetShop-plantaoVet1 petshop)))(Pet-idade(Vet-pet2 (PetShop-plantaoVet1 petshop)))(Pet-nomeDono(Vet-pet2 (PetShop-plantaoVet1 petshop)))(Pet-tipo(Vet-pet2 (PetShop-plantaoVet1 petshop))) ) 20 "purple")
                                                                (text(format "Veterinário do Pet: ~a"(Vet-nomeVet(PetShop-plantaoVet1 petshop)))20 "deeppink"))]
                     [else (rectangle 40 1 "solid" "white")])
                  (cond
                     [(Pet?(Vet-pet3 (PetShop-plantaoVet1 petshop)))(above
                                                               (text(format "PET: ~a. | Cor do Pet: ~a. | Idade do Pet: ~a. | Dono do Pet: ~a. | Tipo: ~a"(Pet-nomePet(Vet-pet3 (PetShop-plantaoVet1 petshop)))(Pet-cor(Vet-pet3 (PetShop-plantaoVet1 petshop)))(Pet-idade(Vet-pet3 (PetShop-plantaoVet1 petshop)))(Pet-nomeDono(Vet-pet3 (PetShop-plantaoVet1 petshop)))(Pet-tipo(Vet-pet3 (PetShop-plantaoVet1 petshop))) ) 20 "purple")
                                                                (text(format "Veterinário do Pet: ~a"(Vet-nomeVet(PetShop-plantaoVet1 petshop)))20 "deeppink"))]
                     [else (rectangle 40 1 "solid" "white")]))])
    (cond
      [(not(Vet? (PetShop-plantaoVet2 petshop))) #false]
      [else (above(cond
                     [(Pet?(Vet-pet1 (PetShop-plantaoVet2 petshop)))(above
                                                                (text(format "PET: ~a. | Cor do Pet: ~a. | Idade do Pet: ~a. | Dono do Pet: ~a. | Tipo: ~a"(Pet-nomePet(Vet-pet1 (PetShop-plantaoVet2 petshop)))(Pet-cor(Vet-pet1 (PetShop-plantaoVet2 petshop)))(Pet-idade(Vet-pet1 (PetShop-plantaoVet2 petshop)))(Pet-nomeDono(Vet-pet1 (PetShop-plantaoVet2 petshop)))(Pet-tipo(Vet-pet1 (PetShop-plantaoVet2 petshop))) ) 20 "purple")
                                                                (text(format "Veterinário do Pet: ~a"(Vet-nomeVet(PetShop-plantaoVet2 petshop)))20 "deeppink"))]
                     [else (rectangle 40 1 "solid" "white")])
                  (cond
                     [(Pet?(Vet-pet2 (PetShop-plantaoVet2 petshop)))(above
                                                               (text(format "PET: ~a. | Cor do Pet: ~a. | Idade do Pet: ~a. | Dono do Pet: ~a. | Tipo: ~a"(Pet-nomePet(Vet-pet2 (PetShop-plantaoVet2 petshop)))(Pet-cor(Vet-pet2 (PetShop-plantaoVet2 petshop)))(Pet-idade(Vet-pet2 (PetShop-plantaoVet2 petshop)))(Pet-nomeDono(Vet-pet2 (PetShop-plantaoVet2 petshop)))(Pet-tipo(Vet-pet2 (PetShop-plantaoVet2 petshop))) ) 20 "purple")
                                                                (text(format "Veterinário do Pet: ~a"(Vet-nomeVet(PetShop-plantaoVet2 petshop)))20 "deeppink"))]
                     [else (rectangle 40 1 "solid" "white")])
                  (cond
                     [(Pet?(Vet-pet3 (PetShop-plantaoVet2 petshop)))(above
                                                                (text(format "PET: ~a. | Cor do Pet: ~a. | Idade do Pet: ~a. | Dono do Pet: ~a. | Tipo: ~a"(Pet-nomePet(Vet-pet3 (PetShop-plantaoVet2 petshop)))(Pet-cor(Vet-pet3 (PetShop-plantaoVet2 petshop)))(Pet-idade(Vet-pet3 (PetShop-plantaoVet2 petshop)))(Pet-nomeDono(Vet-pet3 (PetShop-plantaoVet2 petshop)))(Pet-tipo(Vet-pet3 (PetShop-plantaoVet2 petshop))) ) 20 "purple")
                                                                (text(format "Veterinário do Pet: ~a"(Vet-nomeVet(PetShop-plantaoVet2 petshop)))20 "deeppink"))]
                     [else (rectangle 40 1 "solid" "white")]))])))
  
  
(gera-prontuario clubPenguin)
 

;#####################################################################################################
;### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 ### 8 #####
;#####################################################################################################
