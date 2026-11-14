<%@ include file="../checkSaleStaff.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.util.Locale, java.text.NumberFormat, java.text.SimpleDateFormat, dao.OrderDAO9, dao.CustomerDAO9,
            model.Table9, model.Order9, model.OrderedDish9, model.OrderedCombo9, model.Invoice9, model.SaleStaff9,
            model.Customer9" %>
<%
    // Receive table info: nhân viên đang đăng nhập (session) và bàn đã chọn (id trên URL)
    SaleStaff9 saleStaff = (SaleStaff9) session.getAttribute("saleStaff");
    Invoice9 invoice = null;
    Table9 table = null;
    String txtPhone = null;
    String err = null;

    String id = request.getParameter("id");
    if (id != null) {
        // Lần gọi đầu từ SearchTable9.jsp (id đại diện cho bàn được chọn)
        // Bước 15: ConfirmPayment9.jsp gọi lớp Table9 để đóng gói thông tin bàn đã chọn
        // Bước 16: Table9 đóng gói thông tin bàn đã chọn
        table = new Table9();
        table.setId(Integer.parseInt(id));
        // Bước 17: Table9 trả kết quả về cho ConfirmPayment9.jsp

        // Bước 18: ConfirmPayment9.jsp gọi lớp OrderDAO9 lấy đơn hàng đang phục vụ của bàn đã chọn
        OrderDAO9 orderDAO = new OrderDAO9();
        Order9 order = orderDAO.getOrderOfTable(table);

        // Bước 24: ConfirmPayment9.jsp gọi lớp Invoice9 để tạo hóa đơn tạm
        double totalAmount = 0;
        for (OrderedDish9 od : order.getOrderedDishes()) totalAmount += od.getAmount();
        for (OrderedCombo9 oc : order.getOrderedCombos()) totalAmount += oc.getAmount();
        // Bước 25: Invoice9 đóng gói đơn hàng, nhân viên bán hàng đang đăng nhập và tổng tiền
        invoice = new Invoice9();
        invoice.setOrder(order);
        invoice.setSaleStaff(saleStaff);
        invoice.setTotalAmount(totalAmount);
        // Bước 26: Invoice9 trả kết quả về cho ConfirmPayment9.jsp (giữ hóa đơn tạm trong session)
        session.setAttribute("invoice", invoice);
    } else {
        // Bước 29: ConfirmPayment9.jsp submit gọi chính nó xử lí (Tìm khách hàng)
        // dùng lại hóa đơn tạm trong session, không gọi lại OrderDAO9
        invoice = (Invoice9) session.getAttribute("invoice");
        table = invoice.getOrder().getTable();

        txtPhone = request.getParameter("txtPhone");
        String phone = (txtPhone == null) ? "" : txtPhone.trim();
        if (phone.isEmpty()) {
            err = "Vui lòng nhập số điện thoại";
        } else {
            // Bước 30: ConfirmPayment9.jsp gọi lớp CustomerDAO9 tìm khách hàng theo số điện thoại
            CustomerDAO9 customerDAO = new CustomerDAO9();
            Customer9 customer = customerDAO.getCustomerByPhone(phone);
            if (customer != null) {
                // Bước 36: ConfirmPayment9.jsp gọi lớp Invoice9 yêu cầu gắn khách hàng vào hóa đơn
                // Bước 37: Invoice9 gọi hàm setCustomer()
                invoice.setCustomer(customer);
                // Bước 38: Invoice9 trả đối tượng về cho ConfirmPayment9.jsp
            } else {
                // không tìm thấy: giữ nguyên khách đã gắn trước đó (nếu có)
                err = "Không tìm thấy khách hàng";
            }
        }
    }

    NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
    SimpleDateFormat df = new SimpleDateFormat("HH:mm dd/MM/yyyy");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác nhận thanh toán</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="box">
    <h2>Xác nhận thanh toán</h2>

    <%-- Bước 27: ConfirmPayment9.jsp hiển thị hóa đơn cho nhân viên bán hàng --%>
    <%-- Bước 39: ConfirmPayment9.jsp hiển thị hóa đơn kèm thông tin khách hàng --%>
    <div class="info-area">
        <div class="line">Bàn: <label id="lblTableName"><%= table.getName() %></label></div>
        <div class="line">Thời gian tạo đơn: <label id="lblCreatedTime"><%= df.format(invoice.getOrder().getCreatedTime()) %></label></div>
        <div class="line">Nhân viên bán hàng: <label id="lblSaleStaff"><%= saleStaff.getFullName() %></label></div>
        <div class="line">Khách hàng: <label id="lblCustomer"><%= invoice.getCustomer() == null ? ""
                : invoice.getCustomer().getFullName() + " - " + invoice.getCustomer().getPhone() %></label></div>

        <%-- Bước 28: nhân viên nhập số điện thoại khách hàng và click Tìm khách hàng --%>
        <form method="post" action="ConfirmPayment9.jsp" class="phone-row">
            <label for="txtPhone">Số điện thoại</label>
            <input type="text" name="txtPhone" id="txtPhone" value="<%= txtPhone == null ? "" : txtPhone %>">
            <button type="submit" id="btnSearchCustomer" class="btn">Tìm khách hàng</button>
        </form>
        <% if (err != null) { %>
            <p class="error"><%= err %></p>
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
            <%-- Bước 40: nhân viên click Xác nhận --%>
            <%-- Bước 41: ConfirmPayment9.jsp gọi trang doConfirmPayment9.jsp --%>
            <form method="post" action="doConfirmPayment9.jsp">
                <button type="submit" id="btnConfirm" class="btn">Xác nhận</button>
            </form>
            <form method="get" action="SearchTable9.jsp">
                <button type="submit" id="btnBack" class="btn">Quay lại</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
