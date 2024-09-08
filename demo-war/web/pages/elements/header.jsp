<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.Locale"%>
<%@page import="javax.ejb.ConcurrentAccessTimeoutException"%>
<%@page import="bean.CGenUtil"%>
<%@page import="mg.cnaps.messagecommunication.Message"%>
<%@page import="historique.MapUtilisateur"%>
<%@page import="mg.cnaps.utilisateur.CNAPSUser"%>
<%@page import="menu.MenuDynamique"%>
<%@page import="java.util.ArrayList"%>
<%@page import="user.UserEJB"%>

<%@page import="user.UserEJB"%>
<%@ page import="bean.Constante" %>
<%
    HttpSession sess = request.getSession();
    String lang = "fr";
%>  
<%
    String lien = (String) session.getValue("lien");
    int inboxNotif = 2;
    try {
        UserEJB ue = (UserEJB) session.getValue("u");
        MapUtilisateur u = ue.getUser();
        String receiver = u.getTeluser();
        MapUtilisateur map = ue.getUser();
        String awhere = " and receiver='" + receiver + "' ";
        String home_page=ue.getHome_page();
        MapUtilisateur[] u2 = (MapUtilisateur[]) (CGenUtil.rechercher(new MapUtilisateur(), null, null, ""));

        if(sess.getAttribute("lang")!=null){
            lang = String.valueOf(sess.getAttribute("lang"));
        }
        ResourceBundle RB = ResourceBundle.getBundle("text", new Locale(lang));

          if(request.getParameter("currentMenu")!=null && request.getParameter("currentMenu")!=""){
              session.setAttribute("currentMenu", request.getParameter("currentMenu"));
          }
          String  currentMenu =(String) request.getSession().getAttribute("currentMenu");  ;
          CNAPSUser cnapsUser = ue.getCnapsUser();
          ArrayList<ArrayList<MenuDynamique>> arbre =null;
          if(session.getAttribute("MENU")==null){
              arbre = MenuDynamique.getElementMenu(request, ue.getUser(), cnapsUser);
              session.setAttribute("MENU", arbre);
          }else{
              arbre = (ArrayList<ArrayList<MenuDynamique>>) session.getAttribute("MENU");
          }
          MenuDynamique[] tabMenu = null;
          if(request.getServletContext().getAttribute("tabMenu")!=null){
              tabMenu=(MenuDynamique[])request.getServletContext().getAttribute("tabMenu");
          }
%>
<script>
    function verifEditerTef(et, name){
    if (et < 11){
    alert('Impossible d\'editer Tef. ' + name + ' non visï¿½ ');
    } else{
    document.tef.submit();
    }
    }
    function verifLivraisonBC(et){
    if (et < 11){
    alert('Impossible d effectuer la livraison du bon de commande');
    } else{
    document.tef.submit();
    }
    }
    function CocherToutCheckBox(ref, name) {
    var form = ref;
    while (form.parentNode && form.nodeName.toLowerCase() != 'form') {
    form = form.parentNode;
    }

    var elements = form.getElementsByTagName('input');
    for (var i = 0; i < elements.length; i++) {
        if (elements[i].type == 'checkbox' && elements[i].name == name) {
            elements[i].checked = ref.checked;
        }
    }
    }
    
</script>
<style type="text/css">
  
    .breadcrumb {
        padding-left: 20px;
    }
    
</style>
                            
                            
                            
                            
    <div class="header d-flex justify-content-between p-3">
        <div class="d-flex">
            <div class=" logo-container d-flex align-items-end ">
                <img src="${pageContext.request.contextPath}/assets/img/logo.png" alt="logo " srcset=" ">
            </div>
            <%=MenuDynamique.renderMenuHorizontal(arbre,currentMenu,tabMenu,RB) %>
        </div>
        <div class="col-2 header-menu d-flex align-items-center justify-content-end ">
            <a href="<%= lien%>?but=notification-liste.jsp">
                <img src="${pageContext.request.contextPath}/assets/img/Notification.png" alt=" " srcset=" " class="notification ">
            </a>
            <div class="d-flex align-items-center user-div ">
                <a class="btn-utilisateur">
                    <img src="${pageContext.request.contextPath}/assets/img/Male User.png " alt=" " srcset=" ">
                </a>
                <span><%=map.getLoginuser()%></span>
                <div class="utilisateur-block inactive">
                    <div class="form-group">
                        <button class="btn btn-light"><a href="<%= lien%>?but=deconnexion.jsp">Déconnexion</a></button>
                    </select>
                    </div>
                </div>
            </div>
        </div>
    </div>
                            
                            
                            
                            
                    
            <div class="modal fade" id="modalSendMessage" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="message-chat-title"></h4>
                        </div>
                        <div class="modal-body clearfix">
                            <div class="message-chat-content clearfix" id="message-chat-content">

                            </div>
                            <br/>
                            <form>
                                <textarea id="messagefrom" onkeypress="keypressedsendMessage(this, 1)" class="form-control" rows="3" placeholder="Votre message ici" ></textarea>
                                <br/><br/>
                                <input type="button" class="btn btn-primary pull-right" style="margin-left: 5px;" onclick="keypressedsendMessage(this, 2)" value="Envoyer"/>
                                <input type="reset" class="btn btn-danger pull-right" value="Annuler"/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="modalSendMessageTo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="min-height: 200px">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <ul  > <%
                                for (MapUtilisateur utilisateur : u2) {%>
                            <li class="fa fa-envelope-o "> 
                                    <a href="module.jsp?but=notification/message-envoi.jsp&to=<%=utilisateur.getTeluser()%>"> <%=utilisateur.getNomuser()%></a> 
                          
                            </li><br/>
                            <%}
                            %>
                            </ul>
                        </div>
                        
                    </div>
                </div>
            </div>

            <%
                } catch (ConcurrentAccessTimeoutException e) {
                    out.println("<script language='JavaScript'> document.location.replace('/cnaps-war/');</script>");
                }
            %>
