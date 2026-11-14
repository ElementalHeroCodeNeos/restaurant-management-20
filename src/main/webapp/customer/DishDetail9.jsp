<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.util.Locale, java.text.NumberFormat, dao.DishDAO9, model.Dish9" %>
<%
    // Receive dish info: nhận id món đã chọn từ link chooseDish
    Dish9 dish = null;
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        // Bước 15: DishDetail9.jsp gọi lớp DishDAO9 lấy thông tin chi tiết món đã chọn
        DishDAO9 dishDAO = new DishDAO9();
        dish = dishDAO.getDishDetail(id);
    } catch (NumberFormatException e) {
        dish = null;
    }
    NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xem chi tiết món ăn</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="box">
    <h2>Xem chi tiết món ăn</h2>

    <%-- Bước 21: DishDetail9.jsp hiển thị thông tin chi tiết món ăn --%>
    <% if (dish == null) { %>
        <p class="error center">Không tìm thấy món ăn</p>
    <% } else { %>
        <table class="detail">
            <tr>
                <td>Tên:</td>
                <td><label id="lblName"><%= dish.getName() %></label></td>
            </tr>
            <tr>
                <td>Đơn giá:</td>
                <td><label id="lblPrice"><%= nf.format(dish.getPrice()) %></label></td>
            </tr>
            <tr>
                <td>Mô tả:</td>
                <td><label id="lblDescription"><%= dish.getDescription() == null ? "" : dish.getDescription() %></label></td>
            </tr>
            <tr>
                <td>Danh mục:</td>
                <td><label id="lblCategory"><%= dish.getCategory().getName() %></label></td>
            </tr>
            <tr>
                <td>Hình ảnh:</td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td><img id="imgDish" src="<%= dish.getImage() == null ? "" : dish.getImage() %>" alt="<%= dish.getName() %>"></td>
            </tr>
        </table>
    <% } %>

    <%-- Quay lại SearchDish9.jsp?txtDishName=… (giữ từ khóa và kết quả) --%>
    <div class="back-row">
        <button type="button" id="btnBack" class="btn" onclick="history.back()">Quay lại</button>
    </div>
</div>
</body>
</html>
