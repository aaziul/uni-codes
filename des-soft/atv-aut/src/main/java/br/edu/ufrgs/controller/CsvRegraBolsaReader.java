package br.edu.ufrgs.controller;

import br.edu.ufrgs.model.RegraBolsa;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CsvRegraBolsaReader {
    public static List<RegraBolsa> lerRegras(String csvResourcePath) throws IOException {
        List<RegraBolsa> regras = new ArrayList<>();
        
        InputStream inputStream = CsvRegraBolsaReader.class.getResourceAsStream(csvResourcePath);
        if (inputStream == null) {
            throw new IOException("Arquivo CSV não encontrado: " + csvResourcePath);
        }
        
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream))) {
            String linha;
            boolean primeiraLinha = true;
            
            while ((linha = reader.readLine()) != null) {
                // pula a primeira linha
                if (primeiraLinha) {
                    primeiraLinha = false;
                    continue;
                }
                
                String[] campos = linha.split(",");
                if (campos.length >= 5) {
                    String tipoBolsa = campos[0].trim();
                    double mediaMinima = Double.parseDouble(campos[1].trim());
                    int limiteFaltas = Integer.parseInt(campos[2].trim());
                    boolean exigeRendaBaixa = Boolean.parseBoolean(campos[3].trim());
                    BigDecimal rendaMaxima = new BigDecimal(campos[4].trim());
                    
                    RegraBolsa regra = new RegraBolsa(tipoBolsa, mediaMinima, limiteFaltas, 
                                                      exigeRendaBaixa, rendaMaxima);
                    regras.add(regra);
                }
            }
        }
        
        return regras;
    }
    
    public static Map<String, RegraBolsa> lerRegrasComoMapa(String csvResourcePath) throws IOException {
        Map<String, RegraBolsa> mapa = new HashMap<>();
        List<RegraBolsa> regras = lerRegras(csvResourcePath);
        
        for (RegraBolsa regra : regras) {
            mapa.put(regra.getTipoBolsa(), regra);
        }
        
        return mapa;
    }
}