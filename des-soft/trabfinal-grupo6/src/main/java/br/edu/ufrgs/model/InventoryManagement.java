package br.edu.ufrgs.model;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class InventoryManagement {
    /* Constants for inventory management */
    private static final int daysForPromotion = 3;
    private static final double limitTemperature = 8.0;
    private static final LocalDate dateActual = LocalDate.now();

     /* Checks if the item is at risk of thermal damage.
        * @param item The item to be checked
       * @return true if the item is at risk of thermal damage, false otherwise
    */
    public boolean isThermalRisk(ItemStock item){
        if(!item.getCategory().equals("Laticinios")){
            return false;
        }
        return item.getRecordedTemperature() > limitTemperature;
    }
    
    /* Checks if the item is expired.
     * @param item The item to be checked
     * @return true if the item is expired, false otherwise
     */
    public boolean isExpired(ItemStock item){
        return dateActual.isAfter(item.getExpirationDate());
    }
    
    /* Checks if the item is eligible for a discount.
     * @param item The item to be checked
     * @return true if the item is eligible for a discount, false otherwise
     */

    public boolean isDiscounted(ItemStock item){
        return ChronoUnit.DAYS.between(dateActual, item.getExpirationDate()) <= daysForPromotion;
    }
    
    /* Verifies the action to be taken for the item based on its condition.
     * @param item The item to be checked
     * @return The item with the appropriate stock action set
     */
    public ItemStock verifyAction(ItemStock item){
         StockAction acao = StockAction.NORMAL_SALE;
         if(isExpired(item)){
            acao = StockAction.PRODUCT_DISCARD;
         }else if(isDiscounted(item)){
            acao = StockAction.PRODUCT_PROMOTION;
         }else if(isThermalRisk(item)){
            acao = StockAction.THERMAL_RISK;
         }
         item.setStockAction(acao);
        return item;
    }
}