package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.Customer9;
import model.MembershipCard9;

public class CustomerDAO9 extends DAO9 {
    public CustomerDAO9() {
        super();
    }

    /**
     * Tìm khách hàng theo số điện thoại, kèm thẻ thành viên (nếu có).
     * @param phone số điện thoại khách hàng
     * @return khách hàng tìm được, null nếu không có
     */
    // Bước 31: CustomerDAO9 gọi hàm getCustomerByPhone()
    public Customer9 getCustomerByPhone(String phone) {
        Customer9 kq = null;
        String sql = "SELECT c.*, m.id AS cardId, m.cardCode, m.createdDate, m.points "
                + "FROM tblCustomer9 c LEFT JOIN tblMembershipCard9 m ON m.tblCustomer9id = c.id "
                + "WHERE c.phone = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Bước 32: getCustomerByPhone() gọi lớp Customer9 để đóng gói thông tin
                // Bước 33: Customer9 đóng gói thông tin thực thể
                kq = new Customer9();
                kq.setId(rs.getInt("id"));
                kq.setFullName(rs.getString("fullName"));
                kq.setPhone(rs.getString("phone"));
                //the thanh vien (khach co the khong co the)
                if (rs.getObject("cardId") != null) {
                    MembershipCard9 card = new MembershipCard9();
                    card.setId(rs.getInt("cardId"));
                    card.setCardCode(rs.getString("cardCode"));
                    card.setCreatedDate(rs.getDate("createdDate"));
                    card.setPoints(rs.getInt("points"));
                    kq.setCard(card);
                }
                // Bước 34: Customer9 trả kết quả về cho getCustomerByPhone()
            }
        } catch (Exception e) {
            e.printStackTrace();
            kq = null;
        }
        // Bước 35: getCustomerByPhone() trả kết quả cho ConfirmPayment9.jsp
        return kq;
    }
}
