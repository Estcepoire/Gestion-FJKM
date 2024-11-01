/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import com.google.gson.Gson;
import evenement.Evenement;
import evenement.dto.EvenementDTO;

/**
 *
 * @author sarobidy
 */
public class CalendarUtils {
          
          // Fonction voalohany
          // Mamadika an'ilay evenement ho lasa json
          // Ilay date atao avy any anaty base
          
          static EvenementDTO[] formatEvenement(Evenement[] events){
                    EvenementDTO[] retours = new EvenementDTO[events.length];
                    for( int i = 0; i < retours.length ; i++){
                              retours[i] = new EvenementDTO();
                              retours[i].setTitle(events[i].getDescription());
                              String start = events[i].getDateDebutEvenement().toString() + ( ( events[i].getHeureDebut() != null ) ? "T" + events[i].getHeureDebut().toString() : "" );
                              String end = events[i].getDateFinEvenement().toString() + ( ( events[i].getHeureFin()!= null ) ? "T" + events[i].getHeureFin().toString() : "" );
                              retours[i].setStart(start);
                              retours[i].setEnd( end );
                    }
                    return retours;
          }
          
          public static String getEventsJSON( Evenement[] events ){
                    EvenementDTO[] validFormats = formatEvenement(events);
                    Gson gson = new Gson();
                    return gson.toJson(validFormats);
          }
          
          public static String getEventsJSON( Evenement[] events, String urlRedirection ){
                    EvenementDTO[] validFormats = formatEvenement(events);
                    for(int i = 0; i < events.length ; i++) {
                              EvenementDTO e = validFormats[i];
                              String newUrl = urlRedirection + "&idEvenement=" + events[i].getTuppleID();
                              e.setUrl(newUrl);
                    }
                    Gson gson = new Gson();
                    return gson.toJson(validFormats);
          }
          
}
