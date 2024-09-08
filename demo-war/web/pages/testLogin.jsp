
<%@page import="bean.TypeObjet"%>
<%@page import="mg.cnaps.configuration.Configuration"%>
<%@page import="user.*"%>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.CGenUtil" %>
<%@ page import="lc.Direction" %>
<%@ page import="java.net.InetAddress" %>
<%@ page import="utilitaire.Utilitaire" %>
<%
    UserEJB u = null;
    String username = null;
    String pwd = null;
    String interim = null;
    String service = null;
    historique.MapUtilisateur ut = null;
    String lien;
    String queryString;
    String ip = null;
    String host = null;
    String mot_vide = "";
    String mot_avec_espace = "mot espace";
    String mot = "mot";
    String mot_null = null;
    Configuration[] configo = null;
    String escale=null;
    String queryURL=null;

%>

<%    try {
        queryURL = request.getQueryString();
        username = request.getParameter("identifiant");
        pwd = request.getParameter("passe");
        escale = request.getParameter("escale");
        interim = request.getParameter("interim");
        service = request.getParameter("service");
        u = UserEJBClient.lookupUserEJBBeanLocal();
        u.testLogin(username, pwd, interim, service);
        session.setMaxInactiveInterval(216000);
        session.setAttribute("u", u);
        ut = u.getUser();
        
        session.setAttribute("entmenu", "_all-skins");
        session.setAttribute("langue", "fr");
        lien = "module.jsp";
        if(session.getAttribute("pageName") != null){
            String pageName = session.getValue("pageName").toString();
            if(!pageName.equals("")){
               lien = pageName; 
            }
        }        
        queryString = "but="+u.findHomePageServices(u.getUser().getIdrole());
        if(queryURL != null && !queryURL.equals("")){
            queryString=queryURL.contains("but=")?queryURL:queryString+"&"+queryURL;
            queryString=queryString.replaceAll("()error.*?(?=&|$)","");
        }
        
        session.setAttribute("dir","%");
        session.setAttribute("lien", lien);
        String menu = "admin.jsp";
        session.setAttribute("menu", menu);
        out.println("<script language='JavaScript'> document.location.replace('" + lien + "?" + queryString + "');</script>");

    } catch (Exception e) {

        e.printStackTrace();
%>
<script type="text/javascript">
    document.location.replace('<%=request.getContextPath()%>/index.jsp?error=<%=e.getMessage()%>&<%= queryURL %>');
</script>
<%
        return;
    }
%>



<script language='JavaScript'> document.location.replace('<%=lien%>?"<%=queryString%>');</script>
