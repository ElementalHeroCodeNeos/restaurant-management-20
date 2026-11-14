<%@ include file="../checkSaleStaff.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.util.Locale, java.text.NumberFormat, java.text.SimpleDateFormat,
            model.Invoice9, model.OrderedDish9, model.OrderedCombo9" %>
<%
    // Receive invoice info: hóa đơn đã lưu (giữ trong session)
    Invoice9 invoice = (Invoice9) session.getAttribute("invoice");

    NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
    SimpleDateFormat df = new SimpleDateFormat("HH:mm dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hóa đơn</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="box">
    <h2>Hóa đơn</h2>

    <%-- Bước 49: InvoiceInfo9.jsp hiển thị hóa đơn cho nhân viên bán hàng --%>
    <div class="info-area">
        <div class="line">Mã hóa đơn: <label id="lblInvoiceId"><%= String.format("HĐ%04d", invoice.getId()) %></label></div>
        <div class="line">Thời gian thanh toán: <label id="lblPaymentTime"><%= df.format(invoice.getPaymentTime()) %></label></div>
        <div class="line">Bàn: <label id="lblTableName"><%= invoice.getOrder().getTable().getName() %></label></div>
        <div class="line">Nhân viên bán hàng: <label id="lblSaleStaff"><%= invoice.getSaleStaff().getFullName() %></label></div>
        <% if (invoice.getCustomer() != null) { %>
            <div class="line">Khách hàng: <label id="lblCustomer"><%= invoice.getCustomer().getFullName() + " - "
                    + invoice.getCustomer().getPhone() %></label></div>
        <% } %>

        <div class="line">Danh sách các món đã gọi:</div>
        <table id="tblOrderedItem" class="data">
            <tr>
                <th>TT</th>
                <th>Tên món/ combo</th>
                <th>Đơn giá</th>
                <th>Số lượng</th>
                <th>Thành tiền</th>
            </tr>
            <% int tt = 0;
               for (OrderedDish9 od : invoice.getOrder().getOrderedDishes()) { tt++; %>
                <tr>
                    <td><%= tt %></td>
                    <td><%= od.getDish().getName() %></td>
                    <td><%= nf.format(od.getPrice()) %></td>
                    <td><%= od.getQuantity() %></td>
                    <td><%= nf.format(od.getAmount()) %></td>
                </tr>
            <% }
               for (OrderedCombo9 oc : invoice.getOrder().getOrderedCombos()) { tt++; %>
                <tr>
                    <td><%= tt %></td>
                    <td><%= oc.getCombo().getName() %></td>
                    <td><%= nf.format(oc.getPrice()) %></td>
                    <td><%= oc.getQuantity() %></td>
                    <td><%= nf.format(oc.getAmount()) %></td>
                </tr>
            <% } %>
        </table>

        <div class="line total">Tổng tiền: <label id="lblTotalAmount"><%= nf.format(invoice.getTotalAmount()) %></label></div>

        <div class="actions-row">
            <%-- Bước 50: nhân viên click In hóa đơn --%>
            <%-- Bước 51: InvoiceInfo9.jsp in hóa đơn (các nút bị ẩn khi in) --%>
            <button type="submit" id="btnPrint" class="btn" onclick="window.print()">In hóa đơn</button>
            <%-- Bước 52: nhân viên click Hoàn thành --%>
            <%-- Bước 53: InvoiceInfo9.jsp gọi trang SaleStaffHome9.jsp (trang đó xóa hóa đơn tạm khỏi session) --%>
            <form method="get" action="SaleStaffHome9.jsp">
                <button type="submit" id="btnComplete" class="btn">Hoàn thành</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
