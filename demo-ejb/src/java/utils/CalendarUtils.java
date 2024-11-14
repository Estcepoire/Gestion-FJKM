/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import com.google.gson.Gson;
import evenement.Evenement;
import evenement.dto.EvenementDTO;
import java.util.Arrays;
import java.util.List;
import java.util.Random;
import java.util.Vector;

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
          
          // Colors
          public static String[] getColors(){
                    return new String[]{
                                        "#40E0D0", // Turquoise
                                        "#228B22", // Forest Green
                                        "#FF6347", // Tomato Red
                                        "#DDA0DD", // Plum
                                        "#FF00FF", // Fuchsia
                                        "#E6E6FA", // Lavender
                                        "#9DFFAC", // Seafoam Green
                                        "#FF00FF", // Magenta
                                        "#DE3163", // Cherry Red
                                        "#C8A2C8", // Lilac
                                        "#4B0082", // Indigo
                                        "#FFDAB9", // Peach
                                        "#E0B0FF", // Mauve
                                        "#FF2400", // Scarlet
                                        "#6B8E23", // Olive Drab
                                        "#FA8072", // Salmon
                                        "#DC143C", // Crimson
                                        "#40E0D0", // Turquoise
                                        "#007FFF", // Azure
                                        "#808000", // Olive
                                        "#FF7F50", // Coral
                                        "#DE5D83", // Blush Pink
                                        "#F0E68C", // Khaki
                    };
          }
          
          public static List<String> getColorsAsList(){
                    String[] colors = getColors();
                   Vector<String> nColors = new Vector<>();
                   nColors.addAll(Arrays.asList(colors));
                   return nColors;
          }
          
          public static String getRandomColors( List<String> colors ){
                    if( colors == null ) return "#40E0D0";
                    Random random = new Random();
                    int index = random.nextInt(colors.size());
                    String color = colors.get(index);
                    colors.remove(index);
                    return color;
          }
          
          public static String getColors( List<String> colors, int index ){
                    if( colors == null ) return "#40E0D0";
                    String color = colors.get(index);
                    colors.remove(index);
                    return color;
          }
          
}
