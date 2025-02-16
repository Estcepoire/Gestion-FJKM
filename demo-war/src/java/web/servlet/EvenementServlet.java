/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package web.servlet;

import evenement.Evenement;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.CalendarUtils;

/**
 *
 * @author sarobidy
 */

@WebServlet( name = "EvenementServlet", urlPatterns = {"/evenements"} )
public class EvenementServlet extends HttpServlet {

          @Override
          public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                    // Inona no alaina ato
                    // Recuperena ny date ato
                    String dateMin = req.getParameter("dateMin");
                    String dateMax = req.getParameter("dateMax");
                    Evenement evenement = new Evenement();
                    resp.setContentType("application/json");
                    PrintWriter out = resp.getWriter();
                    try{
                              String link = req.getParameter("redirection-link");
                              Evenement[] events = evenement.getEvenements(dateMin, dateMax);
                              String eventString = CalendarUtils.getEventsJSON(events, link);
                              out.println(eventString );
                    }catch(Exception e){
                              throw new ServletException(e);
                    }
                    
          }
          
          
          
}
