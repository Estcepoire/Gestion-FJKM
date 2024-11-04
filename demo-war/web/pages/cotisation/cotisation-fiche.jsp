<%-- 
    Document   : cotisation-fiche
    Created on : Nov 3, 2024, 12:48:08 PM
    Author     : sarobidy
--%>

<%@page import="affichage.Onglet"%>
<%@page import="bean.CGenUtil"%>
<%@page import="affichage.PageConsulte"%>
<%@page import="user.UserEJB"%>
<%@page import="cotisation.Cotisation"%>
<%
        Cotisation cotisation = new Cotisation();
        
        cotisation.setNomTable("v_paiement_cotisation_lib_montant");

        String id = request.getParameter(cotisation.getAttributIDName());
        String mois = request.getParameter("mois");
        String annee = request.getParameter("annee");
          
        UserEJB u = (UserEJB) session.getValue("u");
        String lien = (String) session.getValue("lien");
        
        String pageActuel = "cotisation/cotisation-fiche.jsp";

        PageConsulte pc = null;

        if(  id == null || id.isEmpty() ) {
          cotisation.setMois( Integer.valueOf(mois) );
          cotisation.setAnnee( Integer.valueOf(annee) );
          cotisation = ((Cotisation[]) CGenUtil.rechercher(cotisation, null, null, null, " and mois = " + mois + " and annee = " + annee))[0];
          pc = new PageConsulte();
          pc.setBase(cotisation);
          pc.setLien(lien);
          pc.makeChamp();
        }else{
          pc = new PageConsulte(cotisation, request, u);
          cotisation = (Cotisation) pc.getBase();
        }

        pc.setTitre("Fiche de Paiement d'une cotisation");
        pc.getChampByName("mois").setVisible(false);
        pc.getChampByName("moisLib").setLibelle("Mois");
        pc.getChampByName("designation").setLibelle("D&eacute;signation");
        pc.getChampByName("montant").setLibelle("Montant Actuelle");
        pc.getChampByName("idPaiementCotisation").setLibelle("Identifiant");
        
        Onglet onglet = new Onglet("detail-mois-annee");
        onglet.addPage("detail-mois-annee", "an/mois");
        
        String tab = request.getParameter("tab");
        String currentPage = onglet.getCurrentPage(tab);
        
        String pageModif = "";


%>


<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title">
                            <a href="#">
                                <i class="fa fa-arrow-circle-left"></i>
                            </a>
                            <%= pc.getTitre() %>
                        </h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <% if( cotisation.getEtat() > 0 && cotisation.getEtat() < 10 ) { %>
                            
                             <a class="btn btn-warning pull-left"  href="<%= lien + "?but=cotisation/apresOuverture.jsp&mois=" + mois + "&annee=" + annee %>" style="margin-right: 10px">
                                    Ouvrir
                            </a>
                           <% } %>
                            
                            <%
                                      if( cotisation.getEtat() == 10 ) { // etat de Cotisation ouverte %>
                                        <a class="btn btn-success pull-left"  href="<%= lien + "?but=cotisation/cotisation-ajout-paiement.jsp&idPaiementCotisation=" + cotisation.getIdPaiementCotisation() %>" style="margin-right: 10px">
                                                Ajouter Paiement
                                        </a>
                             
                             <%                
                                }
                            %>
                            
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
        <div class="row">
            <div class="col-md-12">
                <div class="nav-tabs-custom">
                    <ul class="nav nav-tabs">
                        <!-- a modifier -->
                        <li class="<%= onglet.isActive("detail-mois-annee") %>">
                            <a href="<%= lien %>?but=<%= pageActuel %>&idPaiementCotisation=<%= id %>&mois=<%=mois%>&annee=<%= annee %>&tab=an/mois"> Détails </a>
                        </li>
                    </ul>
                    <div class="tab-content">       
                        <jsp:include page="<%= currentPage %>" >
                                <jsp:param name="mois" value="<%= cotisation.getMois() %>" />
                                <jsp:param name="annee" value="<%= cotisation.getAnnee() %>" />
                        </jsp:include>
                    </div>
                </div>

            </div>
        </div>
</div>