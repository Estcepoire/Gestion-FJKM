/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package croyance.promotion;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import croyance.fandraisana.Mpandray;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author sarobidy
 */
public class Promotion extends ClassEtat {
          
          String idPromotion;
          String nomPromotion;
          int anneePromotion;
          Date dateSortie;
          
          Mpandray[] mpianatra;
          
          public Promotion(){
                    this.setNomTable("promotionmpandray");
          }

          public String getIdPromotion() {
                    return idPromotion;
          }

          public void setIdPromotion(String idPromotion) {
                    this.idPromotion = idPromotion;
          }

          public String getNomPromotion() {
                    return nomPromotion;
          }

          public void setNomPromotion(String nomPromotion) {
                    this.nomPromotion = nomPromotion;
          }

          public int getAnneePromotion() {
                    return anneePromotion;
          }

          public void setAnneePromotion(int anneePromotion) {
                    this.anneePromotion = anneePromotion;
          }

          public Date getDateSortie() {
                    return dateSortie;
          }

          public void setDateSortie(Date dateSortie) {
                    this.dateSortie = dateSortie;
          }

          public Mpandray[] getMpianatra() {
                    return mpianatra;
          }

          public void setMpianatra(Mpandray[] mpandrays) {
                    this.mpianatra = mpandrays;
          }
          
          @Override
          public void construirePK(Connection c) throws Exception {
                    this.preparePk("PROM", "get_seq_promotion");
                    this.setIdPromotion(this.makePK(c));
          }

          @Override
          public String getTuppleID() {
                    return this.getIdPromotion();
          }

          @Override
          public String getAttributIDName() {
                    return "idPromotion";
          }
          
          public void preparerData() throws Exception{
                    try( Connection c = new utilitaire.UtilDB().GetConn() ){
                              Promotion[] ps = (Promotion[]) CGenUtil.rechercher(this, null, null, c, "");
                              Promotion p = ps[0];
                              this.setAnneePromotion(p.getAnneePromotion());
                              this.setNomPromotion(p.getNomPromotion());
                              this.setDateSortie(p.getDateSortie());
                              this.setEtat(p.getEtat());
                              Mpandray mp = new Mpandray();
                              mp.setIdPromotion(this.getIdPromotion());
                              Mpandray[] etudiants = (Mpandray[]) CGenUtil.rechercher( mp, null, null, c, "" );
                              this.setMpianatra(etudiants);
                    }catch(Exception e){
                              e.printStackTrace();
                              throw e;
                    }
          }
          
          public void validatePupils( String refuser ) throws Exception{
                    // Ato anh mi-recuperer details
                    Connection connection = null;
                    try{
                              connection = new utilitaire.UtilDB().GetConn();
                              Promotion prom = ((Promotion[]) CGenUtil.rechercher(this, null, null, connection, ""))[0];
                              connection.setAutoCommit(false);
                              Mpandray m = new Mpandray();
                              m.setIdPromotion(this.getTuppleID());
                              Mpandray[] pupils = (Mpandray[]) CGenUtil.rechercher(m, null, null, connection, "");
                              for( Mpandray pupil : pupils ){
                                        pupil.setDateNandraisana(prom.getDateSortie());
                                        pupil.validerObject(refuser, connection);
                              }
                              connection.commit();
                    }catch(Exception e){
                              if( connection != null ) connection.rollback();
                              throw e;
                    }finally{
                              if( connection != null ) connection.close();
                    }
          }

          @Override
          public ClassMAPTable createObject(String u, Connection c) throws Exception {
                    Promotion[] promotions = (Promotion[]) CGenUtil.rechercher(this, null, null, c, "");
                    if( promotions.length > 0 ) return promotions[0];
                    return super.createObject(u, c);
          }
          
          
          
          
}
