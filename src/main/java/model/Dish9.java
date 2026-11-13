package model;

public class Dish9 {
    private int id;
    private String name;
    private double price;
    private String description;
    private String image;
    private DishCategory9 category;

    public Dish9() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public DishCategory9 getCategory() {
        return category;
    }

    public void setCategory(DishCategory9 category) {
        this.category = category;
    }
}
