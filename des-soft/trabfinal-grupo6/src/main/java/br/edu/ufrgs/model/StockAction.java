package br.edu.ufrgs.model;

/*
Represents the possible stock actions applied to inventory items
Each action has an associated color to distinguish it from the others.
*/

public enum StockAction {
    NORMAL_SALE("Normal Sale", "green"),
    PRODUCT_PROMOTION("Promotion (Near Expiration)", "orange"),
    PRODUCT_DISCARD("Discard (Expired)", "red"),
    THERMAL_RISK("Thermal Risk (Above 8°C)", "orange");

    private final String description;
    private final String color;

    StockAction(String description, String color) {
        this.description = description;
        this.color = color;
    }

    public String getDescription() {
        return description;
    }

    public String getColor() {
        return color;
    }
}
