<%@ include file="../checkSaleStaff.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="dao.InvoiceDAO9, model.Invoice9" %>
<%
    // Chỉ nhận POST
    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.sendRedirect("SaleStaffHome9.jsp");
        return;
    }
    // Receive invoice info: hóa đơn tạm trong session
    Invoice9 invoice = (Invoice9) session.getAttribute("invoice");

    // Bước 39: doConfirmPayment9.jsp gọi lớp InvoiceDAO9 yêu cầu lưu hóa đơn
    InvoiceDAO9 invoiceDAO = new InvoiceDAO9();
    if (invoice != null && invoiceDAO.saveInvoice(invoice)) {
        // Bước 42: doConfirmPayment9.jsp gọi trang InvoiceInfo9.jsp
        response.sendRedirect("InvoiceInfo9.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lỗi thanh toán</title>
</head>
<body>
<script type="text/javascript">
    alert("Lỗi thanh toán!");
    history.back();
</script>
</body>
</html>
