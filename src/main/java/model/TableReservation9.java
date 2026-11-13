package model;

import java.util.Date;

public class TableReservation9 {
    private int id;
    private Date arrivalTime;
    private String note;
    private String status;
    private Table9 table;
    private Customer9 customer;

    public TableReservation9() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(Date arrivalTime) {
        this.arrivalTime = arrivalTime;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
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

    public Customer9 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer9 customer) {
        this.customer = customer;
    }
}
