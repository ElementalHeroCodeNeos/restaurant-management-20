package model;

import java.util.ArrayList;
import java.util.Date;

public class ImportInvoice9 {
    private int id;
    private Date importDate;
    private double totalAmount;
    private Supplier9 supplier;
    private WarehouseStaff9 warehouseStaff;
    private ArrayList<ImportedIngredient9> importedIngredients;

    public ImportInvoice9() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getImportDate() {
        return importDate;
    }

    public void setImportDate(Date importDate) {
        this.importDate = importDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Supplier9 getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier9 supplier) {
        this.supplier = supplier;
    }

    public WarehouseStaff9 getWarehouseStaff() {
        return warehouseStaff;
    }

    public void setWarehouseStaff(WarehouseStaff9 warehouseStaff) {
        this.warehouseStaff = warehouseStaff;
    }

    public ArrayList<ImportedIngredient9> getImportedIngredients() {
        return importedIngredients;
    }

    public void setImportedIngredients(ArrayList<ImportedIngredient9> importedIngredients) {
        this.importedIngredients = importedIngredients;
    }
}
