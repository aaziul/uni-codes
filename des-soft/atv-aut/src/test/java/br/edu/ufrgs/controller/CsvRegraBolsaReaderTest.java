package br.edu.ufrgs.controller;

import br.edu.ufrgs.model.RegraBolsa;
import org.junit.jupiter.api.Test;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

public class CsvRegraBolsaReaderTest {
    
    @Test
    public void testLerRegras() throws IOException {
        List<RegraBolsa> regras = CsvRegraBolsaReader.lerRegras("/regras_bolsa.csv");
        
        assertNotNull(regras, "Lista de regras não deve ser nula");
        assertEquals(3, regras.size(), "Deve ter 3 tipos de bolsa");
        
        // verifica iniciacao cientifica
        RegraBolsa primeiraRegra = regras.get(0);
        assertEquals("IniciacaoCientifica", primeiraRegra.getTipoBolsa());
        assertEquals(8.5, primeiraRegra.getMediaMinima());
        assertEquals(3, primeiraRegra.getLimiteFaltas());
        assertFalse(primeiraRegra.isExigeRendaBaixa());
        
        // verifica bolsa extensao
        RegraBolsa segundaRegra = regras.get(1);
        assertEquals("Extensao", segundaRegra.getTipoBolsa());
        assertEquals(7.5, segundaRegra.getMediaMinima());
        assertEquals(4, segundaRegra.getLimiteFaltas());
        
        // verifica auxilio permanencia
        RegraBolsa terceiraRegra = regras.get(2);
        assertEquals("AuxilioPermanencia", terceiraRegra.getTipoBolsa());
        assertEquals(7.0, terceiraRegra.getMediaMinima());
        assertEquals(5, terceiraRegra.getLimiteFaltas());
        assertTrue(terceiraRegra.isExigeRendaBaixa());
    }
    
    @Test
    public void testLerRegrasArquivoNaoEncontrado() {
        // testa um arquivo q nao existe
        assertThrows(IOException.class, () -> {
            CsvRegraBolsaReader.lerRegras("/arquivo_inexistente.csv");
        }, "IOException, o arquivo não existe");
    }
    
    @Test
    public void testNomeBolsaFormatado() throws IOException {
        List<RegraBolsa> regras = CsvRegraBolsaReader.lerRegras("/regras_bolsa.csv");
        
        // testa as formatacoes de cada bolsa
        assertEquals("Iniciação Científica", regras.get(0).getNomeBolsaFormatado());
        assertEquals("Extensão", regras.get(1).getNomeBolsaFormatado());
        assertEquals("Auxílio Permanência", regras.get(2).getNomeBolsaFormatado());
    }
}