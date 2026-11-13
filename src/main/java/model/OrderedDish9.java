package model;

public class OrderedDish9 {
    private int id;
    private int quantity;
    private double price;
    private double amount;
    private Dish9 dish;

    public OrderedDish9() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Dish9 getDish() {
        return dish;
    }

    public void setDish(Dish9 dish) {
        this.dish = dish;
    }
}
