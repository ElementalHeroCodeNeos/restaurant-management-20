<%@ include file="../checkSaleStaff.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="model.SaleStaff9" %>
<%
    // Receive sale staff info: saleStaff lấy từ session (đã lưu khi đăng nhập)
    SaleStaff9 saleStaff = (SaleStaff9) session.getAttribute("saleStaff");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Giao diện chính của nhân viên bán hàng</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="box">
    <h2>Giao diện chính của nhân viên bán hàng</h2>
    <div class="staff-name">
        <label id="lblStaffName"><%= saleStaff.getFullName() %></label>
    </div>
    <div class="center">
        <%-- Bước 1: nhân viên bán hàng chọn chức năng Nhận thanh toán --%>
        <%-- Bước 2: SaleStaffHome9.jsp gọi trang SearchTable9.jsp --%>
        <a id="receivePayment" class="btn" href="SearchTable9.jsp">Nhận thanh toán</a>
    </div>
</div>
</body>
</html>
