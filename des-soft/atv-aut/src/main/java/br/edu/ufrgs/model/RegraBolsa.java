package br.edu.ufrgs.model;

import java.math.BigDecimal;

public class RegraBolsa {
    private String tipoBolsa;
    private double mediaMinima;
    private int limiteFaltas;
    private boolean exigeRendaBaixa;
    private BigDecimal rendaMaxima;

    public RegraBolsa(String tipoBolsa, double mediaMinima, int limiteFaltas, 
                     boolean exigeRendaBaixa, BigDecimal rendaMaxima) {
        this.tipoBolsa = tipoBolsa;
        this.mediaMinima = mediaMinima;
        this.limiteFaltas = limiteFaltas;
        this.exigeRendaBaixa = exigeRendaBaixa;
        this.rendaMaxima = rendaMaxima;
    }

    public String getTipoBolsa() {
        return tipoBolsa;
    }

    public double getMediaMinima() {
        return mediaMinima;
    }

    public int getLimiteFaltas() {
        return limiteFaltas;
    }

    public boolean isExigeRendaBaixa() {
        return exigeRendaBaixa;
    }

    public BigDecimal getRendaMaxima() {
        return rendaMaxima;
    }
    
    public String getNomeBolsaFormatado() {
        switch (tipoBolsa) {
            case "IniciacaoCientifica":
                return "Iniciação Científica";
            case "Extensao":
                return "Extensão";
            case "AuxilioPermanencia":
                return "Auxílio Permanência";
            default:
                return tipoBolsa;
        }
    }
}