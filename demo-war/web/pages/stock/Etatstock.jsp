<%@page import="java.lang.reflect.Field"%>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>
<%@page import="bean.*"%>
<%@page import="user.UserEJB"%>

<%  
    try {
        EtatdeStock etatstock = new EtatdeStockDate();
        etatstock.setNomTable("V_EtatStockvide"); 
        String listeCrt[] = {"id", "designation","idmagasin","idunite","idtypeproduit","daty"};
        String listeInt[] = {"daty"};
        String libEntete[] = {"id","designation","idtypeproduitlib","idunitelib","idmagasinlib", "dateDernierinventaire","entree", "sortie", "reste"} ;
        String somDefaut[] = null;
        PageRecherche pr = new PageRecherche(etatstock, request, listeCrt, listeInt, 3, libEntete);
        
        UserEJB u = (user.UserEJB) session.getValue("u");
        pr.setUtilisateur(u);
        pr.setLien((String) session.getValue("lien"));

        pr.getFormu().getChamp("idmagasin").setLibelle("Magasin");
        pr.getFormu().getChamp("idunite").setLibelle("Unite");
        pr.getFormu().getChamp("idtypeproduit").setLibelle("Type produit");

        pr.getFormu().getChamp("daty1").setLibelle("Date min");
        pr.getFormu().getChamp("daty1").setDefaut(Utilitaire.dateDuJour());
        pr.getFormu().getChamp("daty2").setLibelle("Date max");
        pr.getFormu().getChamp("daty2").setDefaut(Utilitaire.dateDuJour());

        pr.setApres("stock/etatstock.jsp");
        String daty1,daty2;
        daty1 = request.getParameter("daty1");
        daty2 = request.getParameter("daty2");
        if(daty1 == null || daty1.compareToIgnoreCase("") == 0) daty1 = Utilitaire.dateDuJour();
        if(daty2 == null || daty2.compareToIgnoreCase("") == 0) daty2 = Utilitaire.dateDuJour();
        
        etatstock.setId(request.getParameter("id"));
        etatstock.setIdmagasin(request.getParameter("idmagasin"));
        etatstock.setDatyMin(daty1);
        etatstock.setDatyMax(daty2);
        EtatdeStock[] stock = etatstock.caculEtatStock();
        pr.creerObjetPage(libEntete, somDefaut);
        String[] libEnteteAffiche = {"id","designation","type de produit","unite","magasin", "report","entree", "sortie", "reste"} ;
        pr.setTableau(new TableauRecherche(stock, libEnteteAffiche));

%>
        <script>
            console.log(<%= pr.getTableau().getHtml() %>);
        </script>
        <div class="content-wrapper">
            <section class="content-header">
                <h1>Etat de stock</h1>
            </section>
            <section class="content">
                <form action="<%=pr.getLien()%>?but=stock/etatstock.jsp" method="post" name="incident" id="incident">
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
