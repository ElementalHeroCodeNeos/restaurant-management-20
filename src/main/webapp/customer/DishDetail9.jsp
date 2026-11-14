<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="dao.DishDAO9, model.Dish9" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    request.setAttribute("dish", dish);
%>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xem chi tiết món ăn</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="box">
    <h2>Xem chi tiết món ăn</h2>

    <%-- Bước 21: DishDetail9.jsp hiển thị thông tin chi tiết món ăn --%>
    <c:choose>
        <c:when test="${empty dish}">
            <p class="error center">Không tìm thấy món ăn</p>
        </c:when>
        <c:otherwise>
            <table class="detail">
                <tr>
                    <td>Tên:</td>
                    <td><label id="lblName"><c:out value="${dish.name}"/></label></td>
                </tr>
                <tr>
                    <td>Đơn giá:</td>
                    <td><label id="lblPrice"><fmt:formatNumber value="${dish.price}" maxFractionDigits="0"/></label></td>
                </tr>
                <tr>
                    <td>Mô tả:</td>
                    <td><label id="lblDescription"><c:out value="${dish.description}"/></label></td>
                </tr>
                <tr>
                    <td>Danh mục:</td>
                    <td><label id="lblCategory"><c:out value="${dish.category.name}"/></label></td>
                </tr>
                <tr>
                    <td>Hình ảnh:</td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td><img id="imgDish" src="<c:out value='${dish.image}'/>" alt="<c:out value='${dish.name}'/>"></td>
                </tr>
            </table>
        </c:otherwise>
    </c:choose>

    <%-- Quay lại SearchDish9.jsp?txtDishName=… (giữ từ khóa và kết quả) --%>
    <div class="back-row">
        <button type="button" id="btnBack" class="btn" onclick="history.back()">Quay lại</button>
    </div>
</div>
</body>
</html>
