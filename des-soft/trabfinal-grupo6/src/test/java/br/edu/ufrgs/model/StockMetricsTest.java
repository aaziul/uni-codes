package br.edu.ufrgs.model;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class StockMetricsTest {

    @Test
    public void testInitialMetrics() {
        StockMetrics metrics = new StockMetrics();
        
        // Ensures a new instance starts at zero and handles division by zero safely
        assertEquals(0, metrics.getTotalItems());
        assertEquals(0, metrics.getThermalRiskCount());
        assertTrue(metrics.getPctNormal().contains("0"));
        assertTrue(metrics.getPctThermal().contains("0"));
        assertTrue(metrics.getPctDiscard().contains("0"));
    }

    @Test
    public void testAddResultsAndCounts() {
        StockMetrics metrics = new StockMetrics();
        
        // Simulates item insertion with different action types
        metrics.addResult(StockAction.NORMAL_SALE);
        metrics.addResult(StockAction.THERMAL_RISK);
        metrics.addResult(StockAction.THERMAL_RISK);
        metrics.addResult(StockAction.PRODUCT_DISCARD);

        // Validates absolute counters
        assertEquals(4, metrics.getTotalItems());
        assertEquals(2, metrics.getThermalRiskCount());
    }

    @Test
    public void testPercentagesCalculation() {
        StockMetrics metrics = new StockMetrics();
        
        // Controlled scenario: 4 items (1 normal = 25%, 2 risk = 50%, 1 discard = 25%)
        metrics.addResult(StockAction.NORMAL_SALE);     
        metrics.addResult(StockAction.THERMAL_RISK);    
        metrics.addResult(StockAction.THERMAL_RISK);    
        metrics.addResult(StockAction.PRODUCT_DISCARD); 

        // Note: Using .contains() protects the test from breaking due to system Locale variations (dot vs comma)
        assertTrue(metrics.getPctNormal().contains("25"));
        assertTrue(metrics.getPctThermal().contains("50"));
        assertTrue(metrics.getPctDiscard().contains("25"));
    }

    @Test
    public void testNullAndDefaultActionsHandling() {
        StockMetrics metrics = new StockMetrics();
        
        // 1. Tests safety protection against null values
        metrics.addResult(null);
        assertEquals(0, metrics.getTotalItems());

        // 2. Tests an action handled by the default block (PRODUCT_PROMOTION)
        // It should increment total items but keep specific target metrics at zero
        metrics.addResult(StockAction.PRODUCT_PROMOTION);
        
        assertEquals(1, metrics.getTotalItems());
        assertEquals(0, metrics.getThermalRiskCount());
        assertTrue(metrics.getPctNormal().contains("0"));
        assertTrue(metrics.getPctThermal().contains("0"));
        assertTrue(metrics.getPctDiscard().contains("0"));
    }
}