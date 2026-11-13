<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="dao.MemberDAO9, model.SaleStaff9" %>
<%
    // Chỉ nhận POST
    if (!"POST".equalsIgnoreCase(request.getMethod())) {
        response.sendRedirect("Login9.jsp");
        return;
    }
    request.setCharacterEncoding("UTF-8");
    String username = request.getParameter("txtUsername");
    String password = request.getParameter("txtPassword");
    if (username == null || password == null || username.trim().isEmpty() || password.isEmpty()) {
        response.sendRedirect("Login9.jsp?err=empty");
        return;
    }

    SaleStaff9 saleStaff = new SaleStaff9();
    saleStaff.setUsername(username.trim());
    saleStaff.setPassword(password);
    MemberDAO9 dao = new MemberDAO9();
    if (dao.checkLogin(saleStaff) && "Nhân viên bán hàng".equals(saleStaff.getPosition())) {
        saleStaff.setPassword(null);          // không giữ mật khẩu trong session
        session.invalidate();                 // đổi session mới sau khi đăng nhập
        request.getSession(true).setAttribute("saleStaff", saleStaff);
        response.sendRedirect("saleStaff/SaleStaffHome9.jsp");
    } else {
        response.sendRedirect("Login9.jsp?err=fail");
    }
%>
