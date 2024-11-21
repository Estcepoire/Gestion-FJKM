<%-- 
    Document   : document-preview
    Created on : Nov 20, 2024, 4:28:53 PM
    Author     : sarobidy
--%>

<%

    String filePath = request.getParameter("filePath");

%>

<div class="row">
    <iframe src="/fjkm/preview?filePath=<%= filePath %>" width="100%" height="500px" />
</div>