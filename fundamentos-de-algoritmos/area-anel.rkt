;; Código realizado com o aplicativo DrRacket com o objetivo de calcular a área de um círculo, recebendo o raio interno e exerno

;; area-anel: numero numero -> numero
;; objetivo: dados dois numeros, raio interno e raio externo de um anel, calcule sua área
;; exemplo: (area-anel 5 3) = 50.24

(define (area-circ raio)
        (* 3.14 (* raio raio))) ;; utiliza a fórmula de area = pi * r²

(define (area-anel raio-ext raio-int)
        (-
           (area-circ raio-ext)
           (area-circ raio-int)
         )
 )

;; teste
(check-expect (area-anel 5 3) 50.24)
