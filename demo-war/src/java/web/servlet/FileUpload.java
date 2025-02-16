/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package web.servlet;

import affichage.PageUpload;
import document.Document;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.rmi.ServerException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import user.UserEJB;
import utils.ConstanteFJKM;

/**
 *
 * @author sarobidy
 */
@WebServlet(name = "FileUpload", urlPatterns = {"/upload"})
@MultipartConfig( 
          maxFileSize = 1024 * 1024 * 300,
          maxRequestSize = 1024 * 1024 * 300
)
public class FileUpload extends HttpServlet {
          
          /**
           * Processes requests for both HTTP
           * <code>GET</code> and <code>POST</code> methods.
           *
           * @param request servlet request
           * @param response servlet response
           * @throws ServletException if a servlet-specific
           * error occurs
           * @throws IOException if an I/O error occurs
           */
          protected void processRequest(HttpServletRequest request, HttpServletResponse response)
              throws ServletException, IOException {
                    response.setContentType("text/html;charset=UTF-8");
                    try ( PrintWriter out = response.getWriter()) {
                              /* TODO output your page here. You may use following sample code. */
                              out.println("<!DOCTYPE html>");
                              out.println("<html>");
                              out.println("<head>");
                              out.println("<title>Servlet FileUpload</title>");                              
                              out.println("</head>");
                              out.println("<body>");
                              out.println("<h1>Servlet FileUpload at " + request.getContextPath() + "</h1>");
                              out.println("</body>");
                              out.println("</html>");
                    }
          }

          // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
          /**
           * Handles the HTTP <code>GET</code> method.
           *
           * @param request servlet request
           * @param response servlet response
           * @throws ServletException if a servlet-specific
           * error occurs
           * @throws IOException if an I/O error occurs
           */
          @Override
          protected void doGet(HttpServletRequest request, HttpServletResponse response)
              throws ServletException, IOException {
                    // Ato no mandeha ny donwload
                    String id = request.getParameter("id");
                    try{
                              Document document = new Document().getDocument(id);
                              response.setContentType(document.getMimeType());
                              File f = new File( ConstanteFJKM.downloadPath + document.getChemin() );
                              response.setHeader("Content-Disposition", "attachment; filename=\"" + f.getName() + "\"");
                              FileInputStream fis = new FileInputStream(f);
                              int in;
                              OutputStream os = response.getOutputStream();
                              while( (in = fis.read()) != -1 ){
                                        os.write(in);
                              }
                              os.flush();
                              fis.close();
                              os.close();
                    }catch(Exception e){
                              e.printStackTrace();
                              throw new ServletException(e);
                    }
          }

          /**
           * Handles the HTTP <code>POST</code> method.
           *
           * @param request servlet request
           * @param response servlet response
           * @throws ServletException if a servlet-specific
           * error occurs
           * @throws IOException if an I/O error occurs
           */
          @Override
          protected void doPost(HttpServletRequest request, HttpServletResponse response)
              throws ServletException, IOException {
                    PrintWriter out = (PrintWriter) response.getWriter();
                    try{
                              DiskFileItemFactory factory = new DiskFileItemFactory();
                              ServletFileUpload upload = new ServletFileUpload(factory);
                              List<FileItem> fileItems = upload.parseRequest(request);
                              DiskFileItem[] items = new DiskFileItem[fileItems.size()];
                              items = fileItems.toArray(items);
                              PageUpload p = new PageUpload(items);
                              Document doc = (Document) p.getObjectAvecValeur();
                              FileItem fi = p.getFileItems().get(0); // maka ny fichiers ilaiko
                              File file = new File(  fi.getName() );
                              File fnew = new File( ConstanteFJKM.downloadPath + ConstanteFJKM.downloadFolder + file.getName() );
                              fi.write(fnew);
                              doc.setChemin( ConstanteFJKM.downloadFolder + file.getName() );
                              doc.setTaille( fi.getSize() );
                              doc.setExtension( FilenameUtils.getExtension(file.getName()) );
                              doc.setMimeType( Files.probeContentType(fnew.toPath()) );
                              UserEJB u = (UserEJB) request.getSession(true).getValue("u");
                              String lien = (String) request.getSession(true).getValue("lien");
                              String bute = p.getValeur("bute");
                              u.createObject(doc);
                              response.sendRedirect("/fjkm/pages/" + lien + "?but=" + bute + "&id=" + doc.getTuppleID());
                    }catch(Exception e){
                              e.printStackTrace();
                              out.println("<script language='JavaScript'> alert('" + e.getMessage() + "');history.back(); </script>");
                    }
                    
          }

          /**
           * Returns a short description of the servlet.
           *
           * @return a String containing servlet description
           */
          @Override
          public String getServletInfo() {
                    return "Short description";
          }// </editor-fold>

}
