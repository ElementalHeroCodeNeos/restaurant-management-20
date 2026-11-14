package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.Date;

import model.Invoice9;

public class InvoiceDAO9 extends DAO9 {
    public InvoiceDAO9() {
        super();
    }

    /**
     * Lưu hóa đơn trong một transaction: thêm hóa đơn, cập nhật đơn hàng sang
     * "Đã thanh toán", cộng điểm cho khách có thẻ thành viên.
     * Gán thời gian thanh toán và id sinh ra vào chính hóa đơn i.
     * @param i hóa đơn tạm (đơn hàng, nhân viên, khách hàng có thể null, tổng tiền)
     * @return true nếu lưu thành công
     */
    // Bước 43: InvoiceDAO9 gọi hàm saveInvoice()
    public boolean saveInvoice(Invoice9 i) {
        boolean kq = false;
        String sqlThem = "INSERT INTO tblInvoice9(paymentTime, tblOrder9id, tblSaleStaff9id, tblCustomer9id) "
                + "VALUES(?,?,?,?)";
        String sqlSua = "UPDATE tblOrder9 SET status = 'Đã thanh toán' WHERE id = ?";
        String sqlDiem = "UPDATE tblMembershipCard9 SET points = points + ? WHERE id = ?";
        try {
            con.setAutoCommit(false);
            Date paymentTime = new Date();
            int id = 0;
            //them hoa don
            try (PreparedStatement psThem = con.prepareStatement(sqlThem, Statement.RETURN_GENERATED_KEYS)) {
                psThem.setTimestamp(1, new Timestamp(paymentTime.getTime()));
                psThem.setInt(2, i.getOrder().getId());
                psThem.setInt(3, i.getSaleStaff().getId());
                if (i.getCustomer() != null)
                    psThem.setInt(4, i.getCustomer().getId());
                else
                    psThem.setNull(4, Types.INTEGER);
                psThem.executeUpdate();
                ResultSet rs = psThem.getGeneratedKeys();
                if (rs.next()) id = rs.getInt(1);
            }
            //cap nhat don hang sang "Da thanh toan"
            try (PreparedStatement psSua = con.prepareStatement(sqlSua)) {
                psSua.setInt(1, i.getOrder().getId());
                psSua.executeUpdate();
            }
            //cong diem neu khach co the thanh vien: moi 10.000d = 1 diem
            int diem = 0;
            if (i.getCustomer() != null && i.getCustomer().getCard() != null) {
                diem = (int) (i.getTotalAmount() / 10000);
                try (PreparedStatement psDiem = con.prepareStatement(sqlDiem)) {
                    psDiem.setInt(1, diem);
                    psDiem.setInt(2, i.getCustomer().getCard().getId());
                    psDiem.executeUpdate();
                }
            }
            con.commit();

            //luu thanh cong: cap nhat lai doi tuong
            // Bước 44: saveInvoice() gọi lớp Invoice9 để cập nhật mã hóa đơn và thời gian thanh toán
            // Bước 45: Invoice9 gọi hàm setId(), setPaymentTime()
            i.setId(id);
            i.setPaymentTime(paymentTime);
            // Bước 46: Invoice9 trả kết quả về cho saveInvoice()
            i.getOrder().setStatus("Đã thanh toán");
            if (diem > 0)
                i.getCustomer().getCard().setPoints(i.getCustomer().getCard().getPoints() + diem);
            kq = true;
        } catch (Exception e) {
            try {
                con.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            kq = false;
        } finally {
            try {
                con.setAutoCommit(true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        // Bước 47: InvoiceDAO9 trả kết quả về cho doConfirmPayment9.jsp
        return kq;
    }
}
