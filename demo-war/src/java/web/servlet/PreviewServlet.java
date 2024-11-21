/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package web.servlet;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.FilenameUtils;
import utils.ConstanteFJKM;
import utils.FileUtility;

/**
 *
 * @author sarobidy
 */
@WebServlet(name = "PreviewServlet", urlPatterns = {"/preview"})
public class PreviewServlet extends HttpServlet {

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
                              out.println("<title>Servlet PreviewServlet</title>");                              
                              out.println("</head>");
                              out.println("<body>");
                              out.println("<h1>Servlet PreviewServlet at " + request.getContextPath() + "</h1>");
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
                    String filePath = request.getParameter("filePath");
                    try{
                              String realPath = ConstanteFJKM.downloadPath + filePath;
                              File f = new File(realPath);
                              Path path = f.toPath();
                              String mimeType = Files.probeContentType(path);
                              String extension = FilenameUtils.getExtension(f.getName());
                              boolean isDocument = FileUtility.isDocument(extension);
                              byte[] fileBytes;
                              if( isDocument ) {
                                        fileBytes = FileUtility.convertDocumentToBytes(extension, f);
                                        response.setContentType("application/pdf");
                                        response.setHeader("Content-Disposition", "inline;filename=\"preview.pdf\"");
                                        response.getOutputStream().write(fileBytes);
//                                        response.getOutputStream().flush();
                              }else if( FileUtility.isText(extension) ) {
                                        response.setContentType("text/plain");
                                        BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(f)));
                                        PrintWriter writer = response.getWriter();
                                        String line;
                                        while ((line = reader.readLine()) != null) {
                                            writer.println(line);
                                        }
//                                        response.getOutputStream().flush();
                              }else if( FileUtility.isMedia(extension) ){
                                        ByteArrayOutputStream bao = new ByteArrayOutputStream();
                                        int i;
                                        FileInputStream m = new FileInputStream(f);
                                        while( (i = m.read()) != -1 ){
                                                  bao.write(i);
                                        }
                                        fileBytes = bao.toByteArray();
                                        response.setContentType("application/octet-stream");
                                        response.setContentType(mimeType);
                                        response.setHeader("Content-Disposition", "inline;filename=\"" + f.getName() + "\"");
                                        response.getOutputStream().write(fileBytes);
                                        
                              }
                              
                    }catch(Exception e){
                              e.printStackTrace();
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
                    processRequest(request, response);
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
