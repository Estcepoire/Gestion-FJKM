/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import fichiers.Lecture;
import java.util.ArrayList;

/**
 *
 * @author sarobidy
 */
public class ConstanteFJKM {
          
          public static String MEMBRE = "mb";
          static String fichierLocalisation = "/home/mounts/GitHub/Gestion-FJKM/demo-war/web/default.txt";
          public static String downloadPath = "/home/mounts/GitHub/Gestion-FJKM";
          public static String downloadFolder = "/uploads/";
          
          public static String getDefaultLocalisation(){
                    return fichierLocalisation;
          }
          
          public static String[] getDefaultCoordinates() throws Exception{
                    ArrayList<String> contents = Lecture.lireFichier(getDefaultLocalisation());
                    // Lat, Long
                    String[] coords = {"-18.8768764", "48.0467218"};
                    if( contents.size() > 1 ){
                              String realCoord = contents.get(1);
                              coords = realCoord.split(",");
                              coords[0] = coords[0].trim();
                              coords[1] = coords[1].trim();
                    }
                    return coords;
          }
          
          public static String getName() throws Exception{
                    ArrayList<String> contents = Lecture.lireFichier(getDefaultLocalisation());
                    // Lat, Long
                   String name = "Fiangonana";
                    if( contents.size() > 1 ){
                              String realCoord = contents.get(0);
                              name = realCoord;
                    }
                    return name;
          }
          
}
