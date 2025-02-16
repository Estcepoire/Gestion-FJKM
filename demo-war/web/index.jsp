<%@page import="java.util.Locale"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="bean.CGenUtil"%>
<%@page import="utilitaire.Utilitaire"%>

<%@ page import="java.io.*" %>
  
<%
    String but = "";
    String queryString = "";
    try{
        queryString = request.getQueryString();
        but = "pages/testLogin.jsp";
        if(queryString != null && !queryString.equals("")){
            but += "?" + queryString;
        }
    }
    catch(Exception ex){ %>
        <script language="JavaScript">
        alert(<%=ex.getMessage()%>);
        document.location.replace("../index.jsp");
        </script>
   <% }
%>
<!DOCTYPE html>
  <html lang="FR">
    <head>
      <meta charset="UTF-8">
      <title>Identification</title>
      <!-- Tell the browser to be responsive to screen width -->
      <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
      <link href="${pageContext.request.contextPath}/assets/css/bootstrap.css" rel="stylesheet" type="text/css" />
      <link href="${pageContext.request.contextPath}/assets/css/apj-style.css" rel="stylesheet" type="text/css" />

      <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
      <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
      <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
    </head>
    <body class="login-page">
        <main>
    <div class="container">

      <section class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
        <div class="container">
          <div class="row justify-content-center">
            <div class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">
              <div class="d-flex justify-content-center py-4">
              </div><!-- End Logo -->
              <div class="card mb-3">
                <div class="card-body">
                  <div class="pt-4 pb-2">
                    <h5 class="card-title text-center pb-0 fs-4">Bienvenue</h5>
                    <p class="text-center small">Enter your username & password to login</p>
                  </div>
        <div class="d-flex flex-column align-items-start justify-content-center">
            <div class="login-logo d-flex align-items-center">
                <img src="${pageContext.request.contextPath}/assets/img/Logo_FJKM-removebg-preview.png" alt="" srcset="">
            </div>
            <form action="<%=but%>" method="post" class="col-lg-12 col-md-12">
                
                        <%if (request.getParameter("error")!=null && !request.getParameter("error").equals("")){%>
                            <div class="alert alert-danger" >
                                <%=request.getParameter("error") %>
                            </div>
                        <% } %>
                        <div class="form-group">
                          <label for="email" class="form-label">Identifiant</label>
                            <input type="text" name="identifiant" id="login-id" class="form-control" placeholder="Nom d'utilisateur" autofocus="autofocus">
                        </div>
                        <div class="form-group">
                            <label for="password" class="form-label">Mot de passe</label>
                            <input type="password" name="passe" id="login-id" class="form-control" placeholder="Mot de passe">
                        </div>
                        <br>
                        <div class="form-group">
                            <button class="btn btn-primary w-100" style="background-color: #170577; " type="submit">Login</button>
                        </div>
            </form>
        </div>
    </div>
    </div>
              </div>


            </div>
          </div>
        </div>

      </section>

    </div>
  </main><!-- End #main -->

      <!-- jQuery 2.1.4 -->
      <script src="${pageContext.request.contextPath}/plugins/jQuery/jQuery-2.1.4.min.js" type="text/javascript"></script>
      <!-- Bootstrap 3.3.2 JS -->
      <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
      <!-- iCheck -->
      <script src="${pageContext.request.contextPath}/plugins/iCheck/icheck.min.js" type="text/javascript"></script>
      <script>
        $(function () {
          $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional
          });
        });
      </script>
    </body>
  </html>