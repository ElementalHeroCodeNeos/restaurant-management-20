<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.util.ArrayList, java.util.Locale, java.text.NumberFormat, dao.DishDAO9, model.Dish9" %>
<%
    // Bước 5: SearchDish9.jsp submit gọi chính nó xử lí (form GET, tham số txtDishName)
    String txtDishName = request.getParameter("txtDishName");
    String key = (txtDishName == null) ? null : txtDishName.trim();
    ArrayList<Dish9> listDish = null;
    if (key != null && !key.isEmpty()) {
        // Bước 6: SearchDish9.jsp gọi lớp DishDAO9 tìm các món có tên chứa từ khóa
        DishDAO9 dishDAO = new DishDAO9();
        listDish = dishDAO.getDishByName(key);
    }
    NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm thông tin món ăn</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="box">
    <h2>Tìm kiếm thông tin món ăn</h2>

    <%-- Bước 3: SearchDish9.jsp hiển thị cho khách hàng --%>
    <%-- Bước 4: khách hàng nhập tên món ăn và click Tìm kiếm --%>
    <div class="search-area">
    <form method="get" action="SearchDish9.jsp" class="search-row">
        <label for="txtDishName">Tên món</label>
        <input type="text" name="txtDishName" id="txtDishName"
               value="<%= txtDishName == null ? "" : txtDishName %>" autofocus>
        <button type="submit" id="btnSearch" class="btn">Tìm kiếm</button>
    </form>

    <% if (key != null && key.isEmpty()) { %>
        <p class="error">Vui lòng nhập tên món ăn</p>
    <% } else if (key != null && listDish == null) { %>
        <p class="error">Không tìm thấy món ăn phù hợp</p>
    <% } %>

    <%-- Bước 12: SearchDish9.jsp hiển thị danh sách món ăn tìm được --%>
    <table id="tblDish" class="data">
        <tr>
            <th>TT</th>
            <th>Tên món ăn</th>
            <th>Hình ảnh</th>
            <th>Đơn giá</th>
        </tr>
        <% if (listDish != null) for (int i = 0; i < listDish.size(); i++) {
               Dish9 d = listDish.get(i); %>
            <tr>
                <td><%= i + 1 %></td>
                <%-- Bước 13: khách hàng click chọn 1 món ăn --%>
                <%-- Bước 14: SearchDish9.jsp gọi trang DishDetail9.jsp --%>
                <td><a class="chooseDish" href="DishDetail9.jsp?id=<%= d.getId() %>"><%= d.getName() %></a></td>
                <td class="img-cell">
                    <% if (d.getImage() != null) { %>
                        <img src="<%= d.getImage() %>" alt="<%= d.getName() %>">
                    <% } %>
                </td>
                <td><%= nf.format(d.getPrice()) %></td>
            </tr>
        <% } %>
    </table>
    </div>

    <form method="get" action="CustomerHome9.jsp" class="back-row">
        <button type="submit" id="btnBack" class="btn">Quay lại</button>
    </form>
</div>
</body>
</html>
