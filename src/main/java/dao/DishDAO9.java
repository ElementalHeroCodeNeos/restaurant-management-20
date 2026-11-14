package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Dish9;
import model.DishCategory9;

public class DishDAO9 extends DAO9 {
    public DishDAO9() {
        super();
    }

    /**
     * Tìm các món ăn có tên chứa từ khóa (không tìm combo).
     * @param key từ khóa tên món
     * @return danh sách món tìm được, null nếu không có
     */
    // Bước 7: DishDAO9 gọi hàm getDishByName()
    public ArrayList<Dish9> getDishByName(String key) {
        ArrayList<Dish9> kq = null;
        String sql = "SELECT * FROM tblDish9 WHERE name LIKE ? ORDER BY id";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + key + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if (kq == null) kq = new ArrayList<Dish9>();
                // Bước 8: getDishByName() gọi lớp Dish9 để đóng gói thông tin
                // Bước 9: Dish9 đóng gói thông tin thực thể
                Dish9 d = new Dish9();
                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setPrice(rs.getDouble("price"));
                d.setDescription(rs.getString("description"));
                d.setImage(rs.getString("image"));
                // Bước 10: Dish9 trả kết quả về cho getDishByName()
                kq.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();
            kq = null;
        }
        // Bước 11: getDishByName() trả kết quả cho SearchDish9.jsp
        return kq;
    }

    /**
     * Lấy thông tin chi tiết một món ăn kèm danh mục.
     * @param id mã món ăn
     * @return món ăn, null nếu không có
     */
    // Bước 16: DishDAO9 gọi hàm getDishDetail()
    public Dish9 getDishDetail(int id) {
        Dish9 kq = null;
        String sql = "SELECT d.*, c.id AS categoryId, c.name AS categoryName, "
                + "c.description AS categoryDescription FROM tblDish9 d "
                + "JOIN tblDishCategory9 c ON c.id = d.tblDishCategory9id "
                + "WHERE d.id = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Bước 17: getDishDetail() gọi lớp Dish9 để đóng gói thông tin
                // Bước 18: Dish9 đóng gói thông tin thực thể
                kq = new Dish9();
                kq.setId(rs.getInt("id"));
                kq.setName(rs.getString("name"));
                kq.setPrice(rs.getDouble("price"));
                kq.setDescription(rs.getString("description"));
                kq.setImage(rs.getString("image"));
                DishCategory9 dc = new DishCategory9();
                dc.setId(rs.getInt("categoryId"));
                dc.setName(rs.getString("categoryName"));
                dc.setDescription(rs.getString("categoryDescription"));
                kq.setCategory(dc);
                // Bước 19: Dish9 trả kết quả về cho getDishDetail()
            }
        } catch (Exception e) {
            e.printStackTrace();
            kq = null;
        }
        // Bước 20: getDishDetail() trả kết quả cho DishDetail9.jsp
        return kq;
    }
}
