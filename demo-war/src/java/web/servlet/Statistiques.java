/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package web.servlet;

import com.google.gson.Gson;
import cotisation.DetailCotisationLib;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import statistique.EvolutionCroyant;
import statistique.StastitiqueWrapper;
import statistique.StatistiqueCotisation;
import statistique.chart.MultilineChart;
import utilitaire.UtilDB;

/**
 *
 * @author sarobidy
 */
@WebServlet(name = "Statistiques", urlPatterns = {"/statistiques"})
@MultipartConfig
public class Statistiques extends HttpServlet {
          

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
                    response.setContentType("application/json");
                    String dateMin = request.getParameter("dateMin");
                    String dateMax = request.getParameter("dateMax");
                    PrintWriter out = response.getWriter();
                    Gson gson = new Gson();
                    try( Connection connection = new UtilDB().GetConn() ){

                              String acte = request.getParameter("acte");
                              if( acte == null || acte.trim().equalsIgnoreCase("init") ){
                                        // Rehefa vao mi-load ny page
                                        int anneeMax = 2024;
                                        int anneeMin =anneeMax - 5;

                                        StastitiqueWrapper wrapper = new StastitiqueWrapper();
                                        wrapper.init(String.valueOf(anneeMin), String.valueOf(anneeMax), connection);
                                        out.println( gson.toJson(wrapper) );
                                        
                              }else if( acte.equalsIgnoreCase("evolutions") ){
                                         EvolutionCroyant[] evolutions = new EvolutionCroyant().generateQueryBetweenMinMax(dateMin, dateMax, connection);
                                        out.println( gson.toJson(evolutions) );
                              }else if( acte.equalsIgnoreCase("ev-mpandray") ){
                                        EvolutionCroyant[] evolutions = new EvolutionCroyant().getMpandrayEvolution(dateMin, dateMax, connection);
                                        out.println( gson.toJson(evolutions) );
                              }else if( acte.equalsIgnoreCase("paiement-an") ){
                                        String ans = request.getParameter("an");
                                        String moisAns = request.getParameter("mois");
                                        String moisFin = request.getParameter("mois2");
                                        DetailCotisationLib[] details = new StatistiqueCotisation().getPayementDetailsForYear(moisAns, moisFin, ans);
                                        out.println( gson.toJson(details) );
                              }else if( acte.equalsIgnoreCase("comparaison-an") ){
                                        String anMin = request.getParameter("dateMin");
                                        String anMax = request.getParameter("dateMax");
                                        String moisMin = request.getParameter("mois");
                                        String moisMax = request.getParameter("mois2");
                                        MultilineChart data= new StatistiqueCotisation().getDataComparatif(moisMin, moisMax, anMin, anMax);
                                        out.println(gson.toJson(data));
                                        // Inona le zavatra atao mila maka dataline
                                        
                              }
                              
                    }catch(Exception e){
                              throw new ServletException(e);
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
                    processRequest(request, response);
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
