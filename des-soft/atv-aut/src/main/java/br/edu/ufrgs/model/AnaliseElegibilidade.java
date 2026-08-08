package br.edu.ufrgs.model;

import java.math.BigDecimal;

public class AnaliseElegibilidade {
    public String verificaElegibilidadeBolsa(double media, int faltas, RegraBolsa regra) {
        if (media >= regra.getMediaMinima() && faltas < regra.getLimiteFaltas()) {
            return "Candidato Elegível";
        } else {
            return "Não cumpre os requisitos";
        }
    }
    
    public String verificaElegibilidadeBolsa(double media, int faltas) {
        if (media > 8.5 && faltas < 3) {
            return "Candidato Elegível";
        } else {
            return "Não cumpre os requisitos";
        }
    }
}