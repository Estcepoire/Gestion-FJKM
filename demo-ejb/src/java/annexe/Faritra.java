/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package annexe;

import bean.CGenUtil;
import bean.ClassEtat;
import java.sql.Connection;

/**
 *
 * @author sarobidy
 */
public class Faritra extends ClassEtat {
          
          String idFaritra;
          String nomFaritra;
          int nombre;
          
          public Faritra(){
                    this.setNomTable("faritra");
          }

          public String getIdFaritra() {
                    return idFaritra;
          }

          public void setIdFaritra(String idFaritra) {
                    this.idFaritra = idFaritra;
          }

          public String getNomFaritra() {
                    return nomFaritra;
          }

          public void setNomFaritra(String nomFaritra) {
                    this.nomFaritra = nomFaritra;
          }

          @Override
          public String getTuppleID() {
                    return this.getIdFaritra();
          }

          @Override
          public String getAttributIDName() {
                    return "idFaritra";
          }

          @Override
          public void construirePK(Connection c) throws Exception {
                    this.preparePk("FRT",  "get_seqFaritra");
                    this.setIdFaritra( this.makePK(c) );
          }

          public int getNombre() {
                    return nombre;
          }

          public void setNombre(int nombre) {
                    this.nombre = nombre;
          }
          
          public Faritra[] getGeneralisationFaritra( Connection connection ) throws Exception{
                    this.setNomTable("v_count_mp_frt");
                    return (Faritra[]) CGenUtil.rechercher(this, null, null, connection, "");
          }
          
}
