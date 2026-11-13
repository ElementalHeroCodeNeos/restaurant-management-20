package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.mindrot.jbcrypt.BCrypt;

import model.Member9;
import model.Staff9;

public class MemberDAO9 extends DAO9 {
    public MemberDAO9() {
        super();
    }

    /**
     * Kiểm tra đăng nhập: lấy thành viên theo username rồi so mật khẩu bằng BCrypt.
     * Đúng thì đóng gói thông tin thành viên (và chức vụ nếu là nhân viên) vào chính m.
     * @param m thành viên có username, password người dùng nhập
     * @return true nếu đăng nhập đúng
     */
    public boolean checkLogin(Member9 m) {
        boolean kq = false;
        if (m.getUsername() == null || m.getPassword() == null)
            return false;
        String sql = "SELECT m.*, s.position FROM tblMember9 m "
                + "LEFT JOIN tblStaff9 s ON s.tblMember9id = m.id "
                + "WHERE m.username = ?";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, m.getUsername());
            ResultSet rs = ps.executeQuery();
            if (rs.next() && BCrypt.checkpw(m.getPassword(), rs.getString("password"))) {
                m.setId(rs.getInt("id"));
                m.setFullName(rs.getString("fullName"));
                m.setBirthday(rs.getDate("birthday"));
                m.setAddress(rs.getString("address"));
                m.setEmail(rs.getString("email"));
                m.setPhone(rs.getString("phone"));
                if (m instanceof Staff9)
                    ((Staff9) m).setPosition(rs.getString("position"));
                kq = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            kq = false;
        }
        return kq;
    }
}
