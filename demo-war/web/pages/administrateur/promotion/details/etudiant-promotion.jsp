<%-- 
    Document   : etudiant-promotion
    Created on : Oct 13, 2024, 2:50:13 PM
    Author     : sarobidy
--%>

<%@page import="user.UserEJB"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="croyance.fandraisana.Mpandray"%>
<%@page import="croyance.promotion.Promotion"%>
<%
        try{
        
          
        Promotion p = (Promotion) request.getAttribute("promotion");
        Mpandray[] etudiants = p.getMpianatra();
        Mpandray m = new Mpandray();
        m.setNomTable("v_mpandray_lib");
        PageRecherche pr = new PageRecherche( m, request , new String[0], new String[0], 3);
        pr.setUtilisateur((UserEJB) session.getValue("u"));
        String[] entetes = {"nomComplet", "numeroMpandray"};
        pr.setTitre( "Liste des Etudiants" );
        pr.creerObjetPage(etudiants, entetes);

%>

<div class="content-wrapper">
    <section class="content">
        <h1><%= pr.getTitre() %></h1>
        <%= pr.getTableau().getHtmlVaovao()%>
    </section>
</div>
    
<%
          }catch(Exception e){
          e.printStackTrace();
}
%>