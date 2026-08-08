package br.edu.ufrgs.model;

public class StockMetrics {
    private int totalItems = 0;
    private int normalCount = 0;
    private int thermalRiskCount = 0;
    private int discardCount = 0;

    // Count the results of stock actions to calculate metrics
    public void addResult(StockAction action) {
        if (action == null) return;
        
        this.totalItems++;
        
        switch (action) {
            case NORMAL_SALE:
                this.normalCount++;
                break;
            case THERMAL_RISK:
                this.thermalRiskCount++;
                break;
            case PRODUCT_DISCARD:
                this.discardCount++;
                break;
            default:
                // Other actions are not counted in metrics
                break;
        }
    }

    
    public int getTotalItems() {
        return this.totalItems;
    }

    public int getThermalRiskCount() {
        return this.thermalRiskCount;
    }

    // Calculate percentages for each action type

    public String getPctNormal() {
        double pct = totalItems > 0 ? ((double) normalCount / totalItems) * 100 : 0.0;
        return String.format("%.1f%%", pct);
    }

    public String getPctThermal() {
        double pct = totalItems > 0 ? ((double) thermalRiskCount / totalItems) * 100 : 0.0;
        return String.format("%.1f%%", pct);
    }

    public String getPctDiscard() {
        double pct = totalItems > 0 ? ((double) discardCount / totalItems) * 100 : 0.0;
        return String.format("%.1f%%", pct);
    }
}