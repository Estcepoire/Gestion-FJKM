/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package evenement.participation;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author sarobidy
 */
public class Participation extends ClassMAPTable {
          String idParticipation;
          String idEvenement;
          String idMpivavaka;
          
          public Participation(){
                    this.setNomTable("participant_evenement");
          }

          public String getIdParticipation() {
                    return idParticipation;
          }

          public void setIdParticipation(String idParticipation) {
                    this.idParticipation = idParticipation;
          }

          public String getIdEvenement() {
                    return idEvenement;
          }

          public void setIdEvenement(String idEvenement) {
                    this.idEvenement = idEvenement;
          }

          public String getIdMpivavaka() {
                    return idMpivavaka;
          }

          public void setIdMpivavaka(String idMpivavaka) {
                    this.idMpivavaka = idMpivavaka;
          }
          

          @Override
          public void construirePK(Connection c) throws Exception {
                    this.preparePk("PRT", "get_seq_participation");
                    this.setIdParticipation(this.makePK(c));
          }

          @Override
          public String getTuppleID() {
                    return this.getIdParticipation();
          }

          @Override
          public String getAttributIDName() {
                    return "idParticipation";
          }

          @Override
          public ClassMAPTable createObject(String u, Connection c) throws Exception {
                    Participation p = new Participation();
                    p.setIdEvenement(this.getIdEvenement());
                    p.setIdMpivavaka(this.getIdMpivavaka());
                    Participation[] results = ( (Participation[]) CGenUtil.rechercher( p, null, null, c, "" ) );
                    if( results != null && results.length > 0 ) return results[0];
                    return super.createObject(u, c);
          }
          
          
          
          
          
}
