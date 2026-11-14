<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList, dao.DishDAO9, model.Dish9" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    // Bước 5: SearchDish9.jsp submit gọi chính nó xử lí (form GET, tham số txtDishName)
    String txtDishName = request.getParameter("txtDishName");
    if (txtDishName != null && !txtDishName.trim().isEmpty()) {
        // Bước 6: SearchDish9.jsp gọi lớp DishDAO9 tìm các món có tên chứa từ khóa
        DishDAO9 dishDAO = new DishDAO9();
        ArrayList<Dish9> listDish = dishDAO.getDishByName(txtDishName.trim());
        request.setAttribute("listDish", listDish);
    }
%>
<c:set var="key" value="${fn:trim(param.txtDishName)}"/>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tìm kiếm thông tin món ăn</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
               value="<c:out value='${param.txtDishName}'/>" autofocus>
        <button type="submit" id="btnSearch" class="btn">Tìm kiếm</button>
    </form>

    <c:choose>
        <c:when test="${param.txtDishName ne null and empty key}">
            <p class="error">Vui lòng nhập tên món ăn</p>
        </c:when>
        <c:when test="${not empty key and empty listDish}">
            <p class="error">Không tìm thấy món ăn phù hợp</p>
        </c:when>
    </c:choose>

    <%-- Bước 12: SearchDish9.jsp hiển thị danh sách món ăn tìm được --%>
    <table id="tblDish" class="data">
        <tr>
            <th>TT</th>
            <th>Tên món ăn</th>
            <th>Hình ảnh</th>
            <th>Đơn giá</th>
        </tr>
        <c:forEach var="d" items="${listDish}" varStatus="st">
            <tr>
                <td>${st.count}</td>
                <%-- Bước 13: khách hàng click chọn 1 món ăn --%>
                <%-- Bước 14: SearchDish9.jsp gọi trang DishDetail9.jsp --%>
                <td><a class="chooseDish" href="DishDetail9.jsp?id=${d.id}"><c:out value="${d.name}"/></a></td>
                <td class="img-cell">
                    <c:if test="${not empty d.image}">
                        <img src="<c:out value='${d.image}'/>" alt="<c:out value='${d.name}'/>">
                    </c:if>
                </td>
                <td><fmt:formatNumber value="${d.price}" maxFractionDigits="0"/></td>
            </tr>
        </c:forEach>
    </table>
    </div>

    <form method="get" action="CustomerHome9.jsp" class="back-row">
        <button type="submit" id="btnBack" class="btn">Quay lại</button>
    </form>
</div>
</body>
</html>
