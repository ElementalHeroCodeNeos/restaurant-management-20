package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Combo9;
import model.Dish9;
import model.Order9;
import model.OrderedCombo9;
import model.OrderedDish9;
import model.Table9;

public class OrderDAO9 extends DAO9 {
    public OrderDAO9() {
        super();
    }

    /**
     * Lấy đơn hàng "Đang phục vụ" của bàn, kèm danh sách món và combo đã gọi.
     * Đồng thời điền tên, sức chứa vào chính bàn t và gắn t vào đơn hàng.
     * @param t bàn đã chọn (cần có id)
     * @return đơn hàng đang phục vụ, null nếu không có
     */
    // Bước 19: OrderDAO9 gọi hàm getOrderOfTable()
    public Order9 getOrderOfTable(Table9 t) {
        Order9 kq = null;
        String sqlOrder = "SELECT o.*, t.name AS tableName, t.capacity FROM tblOrder9 o "
                + "JOIN tblTable9 t ON t.id = o.tblTable9id "
                + "WHERE o.tblTable9id = ? AND o.status = 'Đang phục vụ'";
        String sqlDish = "SELECT od.id, od.quantity, od.price, d.id AS dishId, d.name, "
                + "d.price AS dishPrice, d.description, d.image FROM tblOrderedDish9 od "
                + "JOIN tblDish9 d ON d.id = od.tblDish9id WHERE od.tblOrder9id = ? ORDER BY od.id";
        String sqlCombo = "SELECT oc.id, oc.quantity, oc.price, c.id AS comboId, c.name, "
                + "c.price AS comboPrice, c.description, c.image FROM tblOrderedCombo9 oc "
                + "JOIN tblCombo9 c ON c.id = oc.tblCombo9id WHERE oc.tblOrder9id = ? ORDER BY oc.id";
        try (PreparedStatement ps = con.prepareStatement(sqlOrder)) {
            ps.setInt(1, t.getId());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Bước 20: getOrderOfTable() gọi lớp Order9 để đóng gói thông tin
                // Bước 21: Order9 đóng gói thông tin thực thể
                //ban: điền tiếp tên, sức chứa vào chính bàn t được truyền vào
                t.setName(rs.getString("tableName"));
                t.setCapacity(rs.getInt("capacity"));
                kq = new Order9();
                kq.setId(rs.getInt("id"));
                kq.setCreatedTime(rs.getTimestamp("createdTime"));
                kq.setStatus(rs.getString("status"));
                kq.setTable(t);

                //cac mon da goi
                ArrayList<OrderedDish9> listOD = new ArrayList<OrderedDish9>();
                try (PreparedStatement psDish = con.prepareStatement(sqlDish)) {
                    psDish.setInt(1, kq.getId());
                    ResultSet rsDish = psDish.executeQuery();
                    while (rsDish.next()) {
                        OrderedDish9 od = new OrderedDish9();
                        od.setId(rsDish.getInt("id"));
                        od.setQuantity(rsDish.getInt("quantity"));
                        od.setPrice(rsDish.getDouble("price"));
                        od.setAmount(od.getQuantity() * od.getPrice());
                        //mon an
                        Dish9 d = new Dish9();
                        d.setId(rsDish.getInt("dishId"));
                        d.setName(rsDish.getString("name"));
                        d.setPrice(rsDish.getDouble("dishPrice"));
                        d.setDescription(rsDish.getString("description"));
                        d.setImage(rsDish.getString("image"));
                        od.setDish(d);
                        listOD.add(od);
                    }
                }
                kq.setOrderedDishes(listOD);

                //cac combo da goi
                ArrayList<OrderedCombo9> listOC = new ArrayList<OrderedCombo9>();
                try (PreparedStatement psCombo = con.prepareStatement(sqlCombo)) {
                    psCombo.setInt(1, kq.getId());
                    ResultSet rsCombo = psCombo.executeQuery();
                    while (rsCombo.next()) {
                        OrderedCombo9 oc = new OrderedCombo9();
                        oc.setId(rsCombo.getInt("id"));
                        oc.setQuantity(rsCombo.getInt("quantity"));
                        oc.setPrice(rsCombo.getDouble("price"));
                        oc.setAmount(oc.getQuantity() * oc.getPrice());
                        //combo
                        Combo9 c = new Combo9();
                        c.setId(rsCombo.getInt("comboId"));
                        c.setName(rsCombo.getString("name"));
                        c.setPrice(rsCombo.getDouble("comboPrice"));
                        c.setDescription(rsCombo.getString("description"));
                        c.setImage(rsCombo.getString("image"));
                        oc.setCombo(c);
                        listOC.add(oc);
                    }
                }
                kq.setOrderedCombos(listOC);
                // Bước 22: Order9 trả kết quả về cho getOrderOfTable()
            }
        } catch (Exception e) {
            e.printStackTrace();
            kq = null;
        }
        // Bước 23: getOrderOfTable() trả kết quả cho ConfirmPayment9.jsp
        return kq;
    }
}
