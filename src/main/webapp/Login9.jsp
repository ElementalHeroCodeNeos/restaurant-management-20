<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="box" id="loginBox">
    <h2>Đăng nhập</h2>
    <form method="post" action="doLogin9.jsp">
        <table class="form">
            <tr>
                <td><label for="txtUsername">Tên đăng nhập</label></td>
                <td><input type="text" name="txtUsername" id="txtUsername" autofocus></td>
            </tr>
            <tr>
                <td><label for="txtPassword">Mật khẩu</label></td>
                <td><input type="password" name="txtPassword" id="txtPassword"></td>
            </tr>
        </table>
        <label id="lblError" class="error">
            <c:choose>
                <c:when test="${param.err == 'empty'}">Vui lòng nhập tên đăng nhập và mật khẩu</c:when>
                <c:when test="${param.err == 'fail'}">Sai tên đăng nhập hoặc mật khẩu</c:when>
            </c:choose>
        </label>
        <div class="actions">
            <button type="submit" name="btnLogin" id="btnLogin" class="btn">Đăng nhập</button>
        </div>
    </form>
</div>
</body>
</html>
