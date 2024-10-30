<%@page import="java.lang.reflect.Field"%>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>
<%@page import="bean.*"%>
<%@page import="user.UserEJB"%>
<%@page import="caisse.*"%>

<%  
    try {
        EtatStock etatstock = new EtatStock();
        etatstock.setNomTable("V_ETATCAISSEVIDE"); 

        String listeCrt[] = {"id", "idcaisse","idtypecaisselib","daty"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id","idcaisseLib","idtypecaisselib","debit", "credit","montantDernierReport", "reste"} ;
        String somDefaut[] = null;
        PageRecherche pr = new PageRecherche(etatstock, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        
        
        UserEJB u = (user.UserEJB) session.getValue("u");
        pr.setUtilisateur(u);
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("idcaisse").setLibelle("Caisse");
        pr.getFormu().getChamp("idtypecaisselib").setLibelle("Type Caisse");
        pr.getFormu().getChamp("daty1").setLibelle("Date min");
        pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
        pr.getFormu().getChamp("daty2").setLibelle("Date max");
        pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());

        pr.setApres("caisse/etatcaisse.jsp");
        String daty1,daty2;
        daty1 = request.getParameter("daty1");
        daty2 = request.getParameter("daty2");
        if(daty1 == null || daty1.compareToIgnoreCase("") == 0) daty1 = Utilitaire.dateDuJour();
        if(daty2 == null || daty2.compareToIgnoreCase("") == 0) daty2 = Utilitaire.dateDuJour();

        etatstock.setIdCaisse(request.getParameter("idmagasin"));
        etatstock.setDatyMin(daty1);
        etatstock.setDatyMax(daty2);
        EtatStock[] stock = etatstock.caculEtatCaisse();
        pr.creerObjetPage(libEntete, somDefaut);
        String[] libEnteteAffiche = {"id","Caisse","type de Caisse","Debit","Credit","report","reste"} ;
        pr.setTableau(new TableauRecherche(stock, libEntete));

%>
        <script>
            console.log(<%= pr.getTableau().getHtml() %>);
        </script>
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Etat de stock</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getLien()%>?but=caisse/etatcaisse.jsp" method="post" name="incident" id="incident">
                    <%
                        out.println(pr.getFormu().getHtmlEnsemble());
                    %>
                </form>
                <%  
                    out.println(pr.getTableauRecap().getHtml());
                    out.println(pr.getTableau().getHtml());
                    out.println(pr.getBasPage());
                %>
            </section>
        </div>
<%  
    } catch(Exception ex) {
        ex.printStackTrace();
    }
%>
