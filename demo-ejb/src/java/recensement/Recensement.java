/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package recensement;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author sarobidy
 */
public class Recensement extends ClassMAPTable {
          
          String idReportCroyant;
          String designation;
          int annee;
          int nombre;
          
          public Recensement(){
                    this.setNomTable("reportCroyant");
          }

          public String getIdReportCroyant() {
                    return idReportCroyant;
          }

          public void setIdReportCroyant(String idReportCroyant) {
                    this.idReportCroyant = idReportCroyant;
          }

          public String getDesignation() {
                    return designation;
          }

          public void setDesignation(String designation) {
                    this.designation = designation;
          }

          public int getAnnee() {
                    return annee;
          }

          public void setAnnee(int annee) {
                    this.annee = annee;
          }

          public int getNombre() {
                    return nombre;
          }

          public void setNombre(int nombre) {
                    this.nombre = nombre;
          }

          @Override
          public void construirePK(Connection c) throws Exception {
                    this.preparePk("REC", "get_seq_reportcroyant");
                    this.setIdReportCroyant(this.makePK(c));
          }

          @Override
          public String getTuppleID() {
                    return this.getIdReportCroyant();
          }

          @Override
          public String getAttributIDName() {
                   return "idReportCroyant";
          }

          @Override
          public ClassMAPTable createObject(String u, Connection c) throws Exception {
                    // Prevenir la création de plusieurs recensement pour une année
                    Recensement r = new Recensement();
                    r.setAnnee(this.getAnnee());
                    Recensement[] rs = (Recensement[]) CGenUtil.rechercher(r, null, null, c, "");
                    if( rs.length > 0 ) {
                              this.setIdReportCroyant(rs[0].getTuppleID());
                              this.updateToTableWithHisto(u, c);
                              return this;
                    }
                    return super.createObject(u, c); 
          }
          
          public void checkIfRecensementExiste( String anneeMin, Connection c ) throws Exception{
                   Recensement[] rs = (Recensement[]) CGenUtil.rechercher(this, null, null, c, " and annee <= " + anneeMin);
                   if( rs.length == 0 ){
                             c.setAutoCommit(false);
                             this.recensementAutomatique(Integer.parseInt(anneeMin), c);
                             c.commit();
                   }
                   
          }
          
          public void recensementAutomatique( int annee, Connection c ) throws Exception{
                    
                    // Ahoana no anaovana azy
                    // Isaina daholo ny isan'ny velona sy ny maty rehetra tao
                    // Atramin'io annee io
                   
                    String query = "with effectif_annee as(\n" +
                                                  "	select \n" +
                                                  "		coalesce(niditra.annee, maty.annee) as annee ,\n" +
                                                  "		coalesce(niditra.nombreAdmis, 0) as nombreAdmis,\n" +
                                                  "		coalesce( maty.nombreMaty, 0 ) as nombreMaty,\n" +
                                                  "		coalesce ( niditra.nombreAdmis, 0 ) - coalesce ( maty.nombreMaty, 0 ) as effectif\n" +
                                                  "		\n" +
                                                  "	from \n" +
                                                  "		(\n" +
                                                  "			select \n" +
                                                  "				extract ( year from m.dateadmission ) as annee, count(*) as nombreAdmis\n" +
                                                  "			from \n" +
                                                  "				mpivavaka m\n" +
                                                  "			where \n" +
                                                  "				 extract( year from dateadmission) <= " + annee + " \n" +
                                                  "			group by annee\n" +
                                                  "	) as niditra\n" +
                                                  "	left join (\n" +
                                                  "			\n" +
                                                  "		select \n" +
                                                  "			extract ( year from datedeces ) as annee, count(*) as nombreMaty\n" +
                                                  "		from\n" +
                                                  "			mpivavaka m \n" +
                                                  "		where \n" +
                                                  "			extract( year from datedeces) <= " + annee + "  \n" +
                                                  "		group by \n" +
                                                  "			annee\n" +
                                                  "	) as maty on niditra.annee = maty.annee\n" +
                                                  "\n" +
                                                  "), calendar as (\n" +
                                                  "	select \n" +
                                                  "		generate_series( " + annee + " , " + annee + ") as an\n" +
                                                  ")\n" +
                                                  "select \n" +
                                                  "	c.an as annee,\n" +
                                                  "		CAST( SUM(coalesce ( e.effectif, 0 )) OVER (ORDER BY c.an ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as integer ) AS nombre\n" +
                                                  "from \n" +
                                                  "	calendar c\n" +
                                                  "left join\n" +
                                                  "	effectif_annee e on c.an = e.annee\n" +
                                                  "group by \n" +
                                                  "	 e.effectif, c.an\n" +
                                                  "	order by annee desc\n" +
                                                  "limit 1";
                    
                    Recensement[] rs = (Recensement[]) CGenUtil.rechercher(new Recensement(), query, c);
                    rs[0].setDesignation("Recensement du " + annee);
                    rs[0].setAnnee(annee);
                    rs[0].createObject( "301" , c);
                    
          }
          
          
          
          
          
}
