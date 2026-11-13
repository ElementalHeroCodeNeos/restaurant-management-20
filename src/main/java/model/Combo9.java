package model;

import java.util.ArrayList;

public class Combo9 {
    private int id;
    private String name;
    private double price;
    private String description;
    private String image;
    private ArrayList<ComboDish9> comboDishes;

    public Combo9() {
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

    public ArrayList<ComboDish9> getComboDishes() {
        return comboDishes;
    }

    public void setComboDishes(ArrayList<ComboDish9> comboDishes) {
        this.comboDishes = comboDishes;
    }
}
