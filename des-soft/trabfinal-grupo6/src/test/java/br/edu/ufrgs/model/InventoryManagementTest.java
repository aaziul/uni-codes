package br.edu.ufrgs.model;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import java.time.LocalDate;

public class InventoryManagementTest {
    @Test
    /* Tests the thermal risk check for items */
    public void testThermalRisk() {
        InventoryManagement gerencia = new InventoryManagement();
        ItemStock item1 = new ItemStock(1, "Leite", "Laticinios", LocalDate.now().plusDays(5), 9.0);
        ItemStock item2 = new ItemStock(2, "Queijo", "Laticinios", LocalDate.now().plusDays(5), 7.0);
        ItemStock item3 = new ItemStock(3, "Arroz", "Graos", LocalDate.now().plusDays(5), 9.0);

        assertTrue(gerencia.isThermalRisk(item1));
        assertFalse(gerencia.isThermalRisk(item2));
        assertFalse(gerencia.isThermalRisk(item3));
    }
    @Test
    /* Tests the expired check for items */
    public void testExpired() {
        InventoryManagement gerencia = new InventoryManagement();
        ItemStock item1 = new ItemStock(1, "Leite", "Laticinios", LocalDate.now().minusDays(1), 5.0);
        ItemStock item2 = new ItemStock(2, "Queijo", "Laticinios", LocalDate.now().plusDays(1), 5.0);

        assertTrue(gerencia.isExpired(item1));
        assertFalse(gerencia.isExpired(item2));
    }
    @Test
    /* Tests the discounted check for items */
    public void testDiscounted() {
        InventoryManagement gerencia = new InventoryManagement();
        ItemStock item1 = new ItemStock(1, "Leite", "Laticinios", LocalDate.now().plusDays(2), 5.0);
        ItemStock item2 = new ItemStock(2, "Queijo", "Laticinios", LocalDate.now().plusDays(5), 5.0);

        assertTrue(gerencia.isDiscounted(item1));
        assertFalse(gerencia.isDiscounted(item2));
    }
    @Test
    /* Tests the action verification for items */
    public void testVerifyAction() {
        InventoryManagement gerencia = new InventoryManagement();
        ItemStock item1 = new ItemStock(1, "Leite", "Laticinios", LocalDate.now().minusDays(1), 5.0);
        ItemStock item2 = new ItemStock(2, "Queijo", "Laticinios", LocalDate.now().plusDays(2), 5.0);
        ItemStock item3 = new ItemStock(3, "Iogurte", "Laticinios", LocalDate.now().plusDays(5), 9.0);
        ItemStock item4 = new ItemStock(4, "Arroz", "Graos", LocalDate.now().plusDays(5), 5.0);

        assertEquals(StockAction.PRODUCT_DISCARD, gerencia.verifyAction(item1).getStockAction());
        assertEquals(StockAction.PRODUCT_PROMOTION, gerencia.verifyAction(item2).getStockAction());
        assertEquals(StockAction.THERMAL_RISK, gerencia.verifyAction(item3).getStockAction());
        assertEquals(StockAction.NORMAL_SALE, gerencia.verifyAction(item4).getStockAction());
    }
}