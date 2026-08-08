package br.edu.ufrgs.model;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import java.time.LocalDate;

public class ItemStockTest {

    @Test
    public void testItemStockConstructorAndGetters() {
        // Arrange
        int expectedBatchId = 123;
        String expectedProduct = "Yogurt";
        String expectedCategory = "Dairy";
        LocalDate expectedExpirationDate = LocalDate.now().plusDays(7);
        double expectedTemperature = 5.5;

        // Act
        ItemStock item = new ItemStock(expectedBatchId, expectedProduct, expectedCategory, expectedExpirationDate, expectedTemperature);

        // Assert
        assertEquals(expectedBatchId, item.getBatchId());
        assertEquals(expectedProduct, item.getProduct());
        assertEquals(expectedCategory, item.getCategory());
        assertEquals(expectedExpirationDate, item.getExpirationDate());
        assertEquals(expectedTemperature, item.getRecordedTemperature());
        assertNull(item.getStockAction()); // Action should be null right after instantiation
    }

    @Test
    public void testSetAndGetStockAction() {
        // Arrange
        ItemStock item = new ItemStock(456, "Butter", "Dairy", LocalDate.now().plusDays(15), 4.0);

        // Act & Assert for NORMAL_SALE
        item.setStockAction(StockAction.NORMAL_SALE);
        assertEquals(StockAction.NORMAL_SALE, item.getStockAction());

        // Act & Assert changing to THERMAL_RISK
        item.setStockAction(StockAction.THERMAL_RISK);
        assertEquals(StockAction.THERMAL_RISK, item.getStockAction());
    }
}