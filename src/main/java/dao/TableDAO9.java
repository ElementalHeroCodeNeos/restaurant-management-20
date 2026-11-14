package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Table9;

public class TableDAO9 extends DAO9 {
    public TableDAO9() {
        super();
    }

    /**
     * Tìm các bàn có tên chứa từ khóa và đang có đơn hàng "Đang phục vụ".
     * @param key từ khóa tên bàn
     * @return danh sách bàn tìm được, null nếu không có
     */
    // Bước 7: TableDAO9 gọi hàm getServingTableByName()
    public ArrayList<Table9> getServingTableByName(String key) {
        ArrayList<Table9> kq = null;
        String sql = "SELECT * FROM tblTable9 t WHERE t.name LIKE ? "
                + "AND EXISTS (SELECT 1 FROM tblOrder9 o "
                + "WHERE o.tblTable9id = t.id AND o.status = 'Đang phục vụ') "
                + "ORDER BY t.id";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + key + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if (kq == null) kq = new ArrayList<Table9>();
                // Bước 8: getServingTableByName() gọi lớp Table9 để đóng gói thông tin
                // Bước 9: Table9 đóng gói thông tin thực thể
                Table9 t = new Table9();
                t.setId(rs.getInt("id"));
                t.setName(rs.getString("name"));
                t.setCapacity(rs.getInt("capacity"));
                // Bước 10: Table9 trả kết quả về cho getServingTableByName()
                kq.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
            kq = null;
        }
        // Bước 11: getServingTableByName() trả kết quả cho SearchTable9.jsp
        return kq;
    }
}
