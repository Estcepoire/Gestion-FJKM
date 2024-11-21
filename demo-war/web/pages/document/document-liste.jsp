<%-- 
    Document   : document-liste
    Created on : Nov 19, 2024, 9:07:43 PM
    Author     : sarobidy
--%>

<%@page import="document.TypeDocument"%>
<%@page import="affichage.Liste"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="document.Document"%>
<%
    
    Document doc = new Document();
    doc.setNomTable("v_document_lib");
    String[] crt = {"numeroDocument", "dateAjout", "idTypeDocument" ,"libelle"};
    String[] ints = {"dateAjout"};
    String[] entetes = {"numeroDocument", "libelle", "dateAjout", "typeDocument"};
    PageRecherche pr = new PageRecherche(doc, request, crt, ints, 3, entetes, entetes.length);
    pr.setUtilisateur((UserEJB) session.getAttribute("u"));
    pr.setLien((String) session.getAttribute("lien"));
    
    pr.getFormu().getChamp("numeroDocument").setLibelle("Num&eacute;ro");
    pr.getFormu().getChamp("dateAjout1").setLibelle("Date d&apos;ajout min");
    pr.getFormu().getChamp("dateAjout2").setLibelle("Date d&apos;ajout max");
    pr.getFormu().getChamp("libelle").setLibelle("D&eacute;scription");
    
    Liste[] list = { new Liste( "idTypeDocument", new TypeDocument(), "val", "id" ) };
    
    pr.getFormu().changerEnChamp(list);
    
    pr.getFormu().getChamp("idTypeDocument").setLibelle("Type de Document");
    
    
    String[] colSom = null;
    pr.creerObjetPage(entetes, colSom);
    String[] libelles = {"Num&eacute;ro", "D&eacute;scription", "Date d&apos;ajout", "Type de document"};
    pr.getTableau().setLibelleAffiche(libelles);
    
    String[] colLiens = {"numeroDocument"};
    String[] liens = { pr.getLien() + "?but=document/document-fiche.jsp" };
    String[] attributs = {"id" };
    String[] vals = { "id" };
    
    pr.getTableau().setColonneLien(colLiens);
    pr.getTableau().setLien(liens);
    pr.getTableau().setAttLien(attributs);
    pr.getTableau().setValeurLien(vals);
    
    pr.setTitre("Liste des documents");

%>

<div class="content-wrapper">
    <section class="content-header">
        <%= pr.getTitre() %>
    </section>
    <section class="content">
        <form action="<%= pr.getLien() %>?but=document/document-liste.jsp" method="POST">
            <%= pr.getFormu().getHtmlEnsembleVaovao() %>
        </form>
        <br />
        <%= pr.getTableau().getHtmlVaovao() %>
        <br />
        <%= pr.getBasPage() %>
    </section>
</div>