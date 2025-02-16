<%-- 
    Document   : typedocument-fiche
    Created on : Nov 18, 2024, 11:58:59 AM
    Author     : sarobidy
--%>
<%@page import="affichage.PageConsulte"%>
<%@page import="user.UserEJB"%>
<%@page import="document.TypeDocument"%>

<%
          TypeDocument type = new TypeDocument();
          UserEJB u = ( UserEJB ) session.getAttribute("u");
          
          PageConsulte pc = new PageConsulte(type, request, u);
          type = (TypeDocument) pc.getBase();
          
          pc.setTitre(" Fiche : " + type.getVal());
          
          pc.getChampByName("id").setLibelle("Identifiant");
          pc.getChampByName("val").setLibelle("Type de Document");
          pc.getChampByName("desce").setLibelle("D&eacute;scription");
          
          pc.setLien( (String) session.getValue("lien")  );
          String pageModif = "administrateur/documents/typedocument-update.jsp",
        classe = "document.TypeDocument";
          
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-6">
            <div class="box box-success  bg-white p-3">
                <div class="box-title">
                    <h3 class="text-center">
                         <%= pc.getTitre() %>
                    </h3>
                </div>
                <div class="box-body">
                        <%= pc.getHtml()%>
                </div>
                <div class="box-footer">
                    <div class="col-md-12 d-flex justify-content-end">
                            <a class="btn btn-warning pull-left"  href="<%= pc.getLien() + "?but="+ pageModif +"&" + type.getAttributIDName() + "=" + type.getTuppleID() %>" style="margin-right: 10px">
                                    Modifier
                            </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>