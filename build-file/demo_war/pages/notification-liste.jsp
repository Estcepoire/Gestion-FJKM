<%@page import="notification.NotificationLibelle"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="historique.MapUtilisateur"%>
<%@page import="user.UserEJB"%>
<%@page import="bean.TypeObjet"%>
<%@page import="bean.CGenUtil"%>
<%@page import="affichage.PageRecherche"%>

<% 
    NotificationLibelle notif = new NotificationLibelle();  
    notif.setNomTable("notification");
            
    String listeCrt[] = {"id"};
    String listeInt[] = null;
    String libEntete[] = {"id","daty","objet"};
    PageRecherche pr = new PageRecherche(notif, request, listeCrt, listeInt, 3 , libEntete, 3);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));

//    pr.getFormu().getChamp("daty1").setLibelle("Date min");
//    pr.getFormu().getChamp("daty2").setLibelle("Date max");

    pr.setApres("notification-liste.jsp");

    pr.creerObjetPage(libEntete);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Notifications</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=notification-liste.jsp" method="post" name="notification" id="notification">
            <%
                 out.println(pr.getFormu().getHtmlEnsembleNew());
            %>
		   
        </form>
            <%  
               out.println(pr.getTableauRecap().getHtmlRecap());
            %>
        <br>
        <%
            String libEnteteAffiche[] = {"id", "date","objet"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtmlAvecOrdre());
            out.println(pr.getPagination());

        %>
    </section>
</div>
