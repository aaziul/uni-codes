package br.edu.ufrgs.model;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

public class StockActionTest {

    @Test
    public void testEnumProperties() {
        // Validates if descriptions and colors match the expected values
        assertEquals("Normal Sale", StockAction.NORMAL_SALE.getDescription());
        assertEquals("green", StockAction.NORMAL_SALE.getColor());

        assertEquals("Promotion (Near Expiration)", StockAction.PRODUCT_PROMOTION.getDescription());
        assertEquals("orange", StockAction.PRODUCT_PROMOTION.getColor());

        assertEquals("Discard (Expired)", StockAction.PRODUCT_DISCARD.getDescription());
        assertEquals("red", StockAction.PRODUCT_DISCARD.getColor());

        assertEquals("Thermal Risk (Above 8°C)", StockAction.THERMAL_RISK.getDescription());
        assertEquals("orange", StockAction.THERMAL_RISK.getColor());
    }
}