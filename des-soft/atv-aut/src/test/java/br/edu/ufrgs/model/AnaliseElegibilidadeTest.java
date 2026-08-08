package br.edu.ufrgs.model;

import java.math.BigDecimal;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class AnaliseElegibilidadeTest {
    
    @Test
    public void testVerificaElegibilidadeIniciacao() {
        // Arrange
        RegraBolsa regraIniciacao = new RegraBolsa("IniciacaoCientifica", 8.5, 3, false, BigDecimal.ZERO);
        AnaliseElegibilidade analise = new AnaliseElegibilidade();
        
        // Act & Assert
        assertEquals("Candidato Elegível", 
            analise.verificaElegibilidadeBolsa(9.0, 2, regraIniciacao));
        
        // Act & Assert
        assertEquals("Não cumpre os requisitos", 
            analise.verificaElegibilidadeBolsa(8.0, 2, regraIniciacao));
        
        // Act & Assert
        assertEquals("Não cumpre os requisitos", 
            analise.verificaElegibilidadeBolsa(9.0, 3, regraIniciacao));
    }
    
    @Test
    public void testVerificaElegibilidadeExtensao() {
        // Arrange
        RegraBolsa regraExtensao = new RegraBolsa("Extensao", 7.5, 4, false, BigDecimal.ZERO);
        AnaliseElegibilidade analise = new AnaliseElegibilidade();
        
        // Act & Assert
        assertEquals("Candidato Elegível", 
            analise.verificaElegibilidadeBolsa(7.5, 3, regraExtensao));
        
        // Act & Assert
        assertEquals("Não cumpre os requisitos", 
            analise.verificaElegibilidadeBolsa(7.0, 3, regraExtensao));
    }
    
    @Test
    public void testVerificaElegibilidadeAuxPermanencia() {
        // Arrange
        RegraBolsa regraAuxilio = new RegraBolsa("AuxilioPermanencia", 7.0, 5, true, new BigDecimal("2500.0"));
        AnaliseElegibilidade analise = new AnaliseElegibilidade();
        
        // Act & Assert
        assertEquals("Candidato Elegível", 
            analise.verificaElegibilidadeBolsa(8.0, 4, regraAuxilio));
        
        // Act & Assert
        assertEquals("Não cumpre os requisitos", 
            analise.verificaElegibilidadeBolsa(6.5, 4, regraAuxilio));
    }
    
    @Test
    public void testVerificaElegibilidadeValoresLimite() {
        // Arrange
        RegraBolsa regra = new RegraBolsa("Teste", 7.0, 5, false, BigDecimal.ZERO);
        AnaliseElegibilidade analise = new AnaliseElegibilidade();
        
        // mediaMin = true (elegivel)
        assertEquals("Candidato Elegível", 
            analise.verificaElegibilidadeBolsa(7.0, 4, regra));
        
        // mediaMin = false (nao elegivel)
        assertEquals("Não cumpre os requisitos", 
            analise.verificaElegibilidadeBolsa(6.9, 4, regra));
        
        // faltas = limiteFaltas (nao elegivel)
        assertEquals("Não cumpre os requisitos", 
            analise.verificaElegibilidadeBolsa(7.5, 5, regra));
        
        // faltas < limiteFaltas (elegivel)
        assertEquals("Candidato Elegível", 
            analise.verificaElegibilidadeBolsa(7.5, 4, regra));
    }
}