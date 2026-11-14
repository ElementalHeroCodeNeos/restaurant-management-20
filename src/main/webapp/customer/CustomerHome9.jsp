<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ website nhà hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="box">
    <h2>Trang chủ website nhà hàng</h2>
    <div class="center">
        <%-- Bước 1: khách hàng chọn chức năng Tìm kiếm thông tin món ăn --%>
        <%-- Bước 2: CustomerHome9.jsp gọi trang SearchDish9.jsp --%>
        <a id="searchDish" class="btn" href="SearchDish9.jsp">Tìm kiếm thông tin món ăn</a>
    </div>
</div>
</body>
</html>
