<%@page import="utilitaire.Utilitaire"%>
<%
    String queryString = request.getQueryString();
    String but = "pages/testLogin.jsp";
    if(queryString != null && !queryString.equals("")){
        but += "?" + queryString;
    }
%>
<!DOCTYPE html>
  <html>
    <head>
      <meta charset="UTF-8">
      <title>Identification</title>
      <!-- Tell the browser to be responsive to screen width -->
      <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
      <!-- Bootstrap 3.3.4 -->
      <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
      <!-- Font Awesome Icons -->
      <link href="${pageContext.request.contextPath}/dist/js/font-awesome-4.4.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
      <!-- Theme style -->
      <link href="${pageContext.request.contextPath}/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
      <link href="${pageContext.request.contextPath}/dist/css/stylecustom.css" rel="stylesheet" type="text/css" />
      <!-- iCheck -->
      <link href="${pageContext.request.contextPath}/plugins/iCheck/square/blue.css" rel="stylesheet" type="text/css" />

      <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
      <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
      <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
      <style>
        .img_logo_45 {
          border-bottom: solid #00a65a 3px;
          width: 158px;
          height: 158px;
          margin-bottom: 20px;
        }
        .login-box-body {
          margin-top: 20%;
        }
        .login-logo{
            width : 150px !important;
            height : 150px !important;
        }
        img{
            width : 150px !important;
        }
      </style>
    </head>
    <body class="login-page">
      <div class="login-box loginBody">
        <div class="login-box-body">
           <%-- <p class="login-box-msg"><b>Identification</b></p> --%>
          <center><div class="login-logo">
              <a href="index.jsp"> <img src="${pageContext.request.contextPath}/assets/img/lo.jpg"/></a>
          </div></center>
          <form action="<%=but%>" method="post">
            <div class="input-group">
              <span class="input-group-addon"><i class="fa fa-user"></i></span>
              <input type="text" name="identifiant" class="form-control" placeholder="Utilisateur" autofocus="autofocus"/>
            </div><br/>
            <div class="input-group">
              <span class="input-group-addon"><i class="fa fa-lock"></i></span>
              <input type="password" name="passe" class="form-control" placeholder="Mot de passe" />
            </div><br/>
            <div class="row">
              <div class="col-xs-7">
                  <p style="font-size: 10px"><b>Version du : <%@include file="dateBuild.txt" %></b></p>
              </div><!-- /.cosl -->
              <div class="col-xs-5">
                <button type="submit" class="btn btn-success btn-block btn-flat">Se connecter</button>
              </div><!-- /.col -->
            </div>
          </form>
        </div><!-- /.login-box-body -->
      </div><!-- /.login-box -->

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