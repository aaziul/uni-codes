package br.edu.ufrgs.model;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;


class CSVModelTest{
    private CSVModel csvModel;

    @BeforeEach
    void setUp(){
        csvModel = new CSVModel();
    }

    @Test
    void testReadFile(){
        String contentCSV = "id_lote,produto,categoria,data_validade,temperatura_registro\n" +
                            "401,Leite Integral,Laticinios,20/05/2026,3.4\n"+
                            "402,Feijão Preto 1kg,Graos,27/05/2026,2.5\n"+
                            "403,Requeijão,Laticinios,08/06/2026,11.9";

        InputStream inputStream = new ByteArrayInputStream(contentCSV.getBytes(StandardCharsets.UTF_8));

        List<String> result = csvModel.readFile(inputStream);

        assertEquals(4, result.size(), "Should return exactly 4 lines read."); // verify file size 
        assertEquals("id_lote,produto,categoria,data_validade,temperatura_registro", result.get(0)); // verify header values

        // verify each product 
        assertEquals("401,Leite Integral,Laticinios,20/05/2026,3.4", result.get(1));
        assertEquals("402,Feijão Preto 1kg,Graos,27/05/2026,2.5", result.get(2));
        assertEquals("403,Requeijão,Laticinios,08/06/2026,11.9", result.get(3));
    }

    @Test
    void testCreateCsv() {
        List<String[]> stockRows = Arrays.asList(
            new String[] {"401", "Leite Integral", "Laticinios", "2026-05-20", "3.4°C", "Normal Sale", "green"},
            new String[] {"402", "Feijão Preto 1kg", "Graos", "2026-05-27", "2.5°C", "Normal Sale", "green"},
            new String[] {"403", "Requeijão", "Laticinios", "2026-06-08", "11.9°C", "Thermal Risk (Above 8°C)", "orange"}
        );

        List<String> result = csvModel.createCsv(stockRows);

        assertEquals(4, result.size()); // verify file size
        assertEquals("BatchID,Product,Category,Expiration,Temperature,Recommended Action", result.get(0)); // verify header values

        // verify each product 
        assertEquals("401,Leite Integral,Laticinios,2026-05-20,3.4°C,Normal Sale", result.get(1));
        assertEquals("402,Feijão Preto 1kg,Graos,2026-05-27,2.5°C,Normal Sale", result.get(2));
        assertEquals("403,Requeijão,Laticinios,2026-06-08,11.9°C,Thermal Risk (Above 8°C)", result.get(3));
    }

    @Test
    void testCreateCsv_emptyList() {
        List<String[]> stockRows = new ArrayList<>();

        List<String> result = csvModel.createCsv(stockRows);

        assertEquals(1, result.size(), "List should contain only the header.");
        assertEquals("BatchID,Product,Category,Expiration,Temperature,Recommended Action", result.get(0));
    }
}