package br.edu.ufrgs.model;

import java.time.LocalDate;

public class ItemStock {
    private int batchId;
    private String product;
    private String category;
    private LocalDate expirationDate;
    private double recordedTemperature;
    private StockAction stockAction;

    public ItemStock(int batchId, String product, String category,
                       LocalDate expirationDate, double recordedTemperature) {
        this.batchId = batchId;
        this.product = product;
        this.category = category;
        this.expirationDate = expirationDate;
        this.recordedTemperature = recordedTemperature;
    }

    public int getBatchId() { 
        return batchId; }

    public String getProduct() {
         return product; }

    public String getCategory() { 
        return category; }

    public LocalDate getExpirationDate() { 
        return expirationDate; }

    public double getRecordedTemperature() { 
        return recordedTemperature; }

    public StockAction getStockAction() {
        return stockAction;
    }

    public void setStockAction(StockAction stockAction) {
        this.stockAction = stockAction;
    }
}