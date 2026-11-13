<%@ page pageEncoding="UTF-8" import="model.SaleStaff9" %>
<%
    // Include ở đầu mọi trang trong saleStaff/: chưa đăng nhập hoặc không phải nhân viên bán hàng thì về Login9.jsp
    Object checkedStaff = session.getAttribute("saleStaff");
    if (!(checkedStaff instanceof SaleStaff9)
            || !"Nhân viên bán hàng".equals(((SaleStaff9) checkedStaff).getPosition())) {
        response.sendRedirect(request.getContextPath() + "/Login9.jsp");
        return;
    }
%>
