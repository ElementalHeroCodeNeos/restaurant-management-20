<%@ include file="../checkSaleStaff.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.util.ArrayList, dao.TableDAO9, model.Table9, model.SaleStaff9" %>
<%
    // Receive sale staff info: saleStaff lấy từ session (đã lưu khi đăng nhập)
    SaleStaff9 saleStaff = (SaleStaff9) session.getAttribute("saleStaff");

    // Bước 5: SearchTable9.jsp submit gọi chính nó xử lí (form GET, tham số txtTableName)
    String txtTableName = request.getParameter("txtTableName");
    String key = (txtTableName == null) ? null : txtTableName.trim();
    ArrayList<Table9> listTable = null;
    if (key != null && !key.isEmpty()) {
        // Bước 6: SearchTable9.jsp gọi lớp TableDAO9 tìm các bàn có tên chứa từ khóa và đang phục vụ
        TableDAO9 tableDAO = new TableDAO9();
        listTable = tableDAO.getServingTableByName(key);
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm bàn thanh toán</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="box">
    <h2>Tìm kiếm bàn thanh toán</h2>
    <div class="staff-name">
        <label id="lblStaffName"><%= saleStaff.getFullName() %></label>
    </div>

    <%-- Bước 3: SearchTable9.jsp hiển thị cho nhân viên bán hàng --%>
    <%-- Bước 4: nhân viên bán hàng nhập tên bàn và click Tìm kiếm --%>
    <div class="search-area">
    <form method="get" action="SearchTable9.jsp" class="search-row">
        <label for="txtTableName">Tên bàn</label>
        <input type="text" name="txtTableName" id="txtTableName"
               value="<%= txtTableName == null ? "" : txtTableName %>" autofocus>
        <button type="submit" id="btnSearch" class="btn">Tìm kiếm</button>
    </form>

    <% if (key != null && key.isEmpty()) { %>
        <p class="error">Vui lòng nhập tên bàn</p>
    <% } else if (key != null && listTable == null) { %>
        <p class="error">Không tìm thấy bàn đang phục vụ phù hợp</p>
    <% } %>

    <%-- Bước 12: SearchTable9.jsp hiển thị danh sách bàn tìm được --%>
    <table id="tblTable" class="data">
        <tr>
            <th>TT</th>
            <th>Tên bàn</th>
            <th>Sức chứa</th>
        </tr>
        <% if (listTable != null) for (int i = 0; i < listTable.size(); i++) {
               Table9 t = listTable.get(i); %>
            <tr>
                <td><%= i + 1 %></td>
                <%-- Bước 13: nhân viên click chọn 1 bàn --%>
                <%-- Bước 14: SearchTable9.jsp gọi trang ConfirmPayment9.jsp --%>
                <td><a class="chooseTable" href="ConfirmPayment9.jsp?id=<%= t.getId() %>"><%= t.getName() %></a></td>
                <td><%= t.getCapacity() %></td>
            </tr>
        <% } %>
    </table>
    </div>

    <form method="get" action="SaleStaffHome9.jsp" class="back-row">
        <button type="submit" id="btnBack" class="btn">Quay lại</button>
    </form>
</div>
</body>
</html>
