package model;

import java.util.Date;

public class Invoice9 {
    private int id;
    private Date paymentTime;
    private double totalAmount;
    private Order9 order;
    private SaleStaff9 saleStaff;
    private Customer9 customer;

    public Invoice9() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(Date paymentTime) {
        this.paymentTime = paymentTime;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Order9 getOrder() {
        return order;
    }

    public void setOrder(Order9 order) {
        this.order = order;
    }

    public SaleStaff9 getSaleStaff() {
        return saleStaff;
    }

    public void setSaleStaff(SaleStaff9 saleStaff) {
        this.saleStaff = saleStaff;
    }

    public Customer9 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer9 customer) {
        this.customer = customer;
    }
}
