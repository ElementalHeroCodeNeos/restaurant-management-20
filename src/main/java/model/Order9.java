package model;

import java.util.ArrayList;
import java.util.Date;

public class Order9 {
    private int id;
    private Date createdTime;
    private String status;
    private Table9 table;
    private TableReservation9 reservation;
    private ArrayList<OrderedDish9> orderedDishes;
    private ArrayList<OrderedCombo9> orderedCombos;

    public Order9() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Table9 getTable() {
        return table;
    }

    public void setTable(Table9 table) {
        this.table = table;
    }

    public TableReservation9 getReservation() {
        return reservation;
    }

    public void setReservation(TableReservation9 reservation) {
        this.reservation = reservation;
    }

    public ArrayList<OrderedDish9> getOrderedDishes() {
        return orderedDishes;
    }

    public void setOrderedDishes(ArrayList<OrderedDish9> orderedDishes) {
        this.orderedDishes = orderedDishes;
    }

    public ArrayList<OrderedCombo9> getOrderedCombos() {
        return orderedCombos;
    }

    public void setOrderedCombos(ArrayList<OrderedCombo9> orderedCombos) {
        this.orderedCombos = orderedCombos;
    }
}
