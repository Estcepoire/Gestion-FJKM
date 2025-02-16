/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package statistique;

import bean.CGenUtil;
import com.google.gson.annotations.Expose;
import java.sql.Connection;
import recensement.Recensement;

/**
 *
 * @author sarobidy
 */
public class EvolutionCroyant extends Recensement {
          @Expose
          int nombreNouveaux;
          @Expose
          int nombreMoins;
          double pourcentageAugmentation;

          public int getNombreNouveaux() {
                    return nombreNouveaux;
          }

          public void setNombreNouveaux(int nombreNouveaux) {
                    this.nombreNouveaux = nombreNouveaux;
          }

          public int getNombreMoins() {
                    return nombreMoins;
          }

          public void setNombreMoins(int nombreMoins) {
                    this.nombreMoins = nombreMoins;
          }

          public double getPourcentageAugmentation() {
                    return pourcentageAugmentation;
          }

          public void setPourcentageAugmentation(double pourcentageAugmentation) {
                    this.pourcentageAugmentation = pourcentageAugmentation;
          }
          
          public EvolutionCroyant getCurrentStatus(int annee, Connection connection) throws Exception{
                    String query = "with dernierRecensement as(\n" +
"	select \n" +
"		r.annee, r.nombre \n" +
"	from \n" +
"		reportcroyant r\n" +
"	where \n" +
"		r.annee <= " + annee + "\n" +
"	order by annee desc\n" +
"	limit 1\n" +
"),\n" +
"effectif_annee as(\n" +
"	select \n" +
"	coalesce(niditra.annee, maty.annee) as annee ,\n" +
" 		coalesce(niditra.nombreAdmis, 0) as nombreAdmis,\n" +
" 		coalesce( maty.nombreMaty, 0 ) as nombreMaty,\n" +
" 		coalesce ( niditra.nombreAdmis, 0 ) - coalesce ( maty.nombreMaty, 0 ) as effectif\n" +
" 		\n" +
" 	from \n" +
" 		(\n" +
" 			select \n" +
" 				extract ( year from m.dateadmission ) as annee, count(*) as nombreAdmis\n" +
" 			from \n" +
" 				mpivavaka m\n" +
" 			where \n" +
" 				extract( year from dateadmission ) > (select annee from dernierRecensement) and  extract( year from dateadmission) <= extract( year from now()) \n" +
" 			group by annee\n" +
" 	) as niditra\n" +
" 	left join (\n" +
" 			\n" +
" 		select \n" +
" 			extract ( year from datedeces ) as annee, count(*) as nombreMaty\n" +
" 		from\n" +
" 			mpivavaka m \n" +
" 		where \n" +
" 			etat < 0 and extract( year from datedeces ) > (select annee from dernierRecensement)  and  extract( year from datedeces) <= extract( year from now()) \n" +
" 		group by \n" +
" 			annee\n" +
" 	) as maty on niditra.annee = maty.annee\n" +
" \n" +
" ), calendar as (\n" +
" 	select \n" +
" 		generate_series( (select annee from dernierRecensement) ,  extract( year from now() )) as an\n" +
" ), effectif as (\n" +
" 	select \n" +
"	 	c.an as annee,\n" +
"	 	cast( ( select nombre from dernierRecensement ) \n" +
"	 		+ SUM(coalesce ( e.effectif, 0 )) OVER (ORDER BY c.an ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as integer ) AS nombre,\n" +
"	 	coalesce (e.nombreAdmis, 0)::integer as nombreNouveaux,\n" +
"	 	coalesce (e.nombreMaty, 0)::integer as nombreMoins\n" +
"	 from \n" +
"	 	calendar c\n" +
"	 left join\n" +
"	 	effectif_annee e on c.an = e.annee\n" +
"	 group by \n" +
"	 	c.an, e.effectif, e.nombreAdmis, e.nombreMaty \n"+
") select e.* from effectif e where e.annee = " + annee + "\n";
                    this.setNomTable("v_evolution_cr_vide");
                    EvolutionCroyant[] evolution = (EvolutionCroyant[]) CGenUtil.rechercher(this, query, connection);
                    return evolution[0];
          }
          
          public EvolutionCroyant[] generateQueryBetweenMinMax( String anneeMin, String anneeMax, Connection c ) throws Exception {
                   
                    this.checkIfRecensementExiste( anneeMin, c );
                    this.setNomTable("v_evolution_cr_vide");
                    String query = "with dernierRecensement as(\n" +
                                                  "	select \n" +
                                                  "		r.annee, r.nombre \n" +
                                                  "	from \n" +
                                                  "		reportcroyant r\n" +
                                                  "	where \n" +
                                                  "		r.annee <= " + anneeMin + " \n" +
                                                  "	order by annee desc\n" +
                                                  "	limit 1\n" +
                                                  "),\n" +
                                                  "effectif_annee as(\n" +
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
                                                  "				 extract( year from dateadmission ) > ( select annee from dernierRecensement ) and  extract( year from dateadmission) <= " + anneeMax + " \n" +
                                                  "			group by annee\n" +
                                                  "	) as niditra\n" +
                                                  "	left join (\n" +
                                                  "			\n" +
                                                  "		select \n" +
                                                  "			extract ( year from datedeces ) as annee, count(*) as nombreMaty\n" +
                                                  "		from\n" +
                                                  "			mpivavaka m \n" +
                                                  "		where \n" +
                                                  "			etat < 0 and extract( year from datedeces ) > ( select annee from dernierRecensement )  and  extract( year from datedeces) <= " + anneeMax + " \n" +
                                                  "		group by \n" +
                                                  "			annee\n" +
                                                  "	) as maty on niditra.annee = maty.annee\n" +
                                                  "\n" +
                                                  "), calendar as (\n" +
                                                  "	select \n" +
                                                  "		generate_series( (select annee from dernierRecensement)  ,   " + anneeMax + ") as an\n" +
                                                  ")\n" +
                                                  "select \n" +
                                                  "	c.an as annee,\n" +
                                                  " CAST(	( select nombre from dernierRecensement ) \n" +
                                                  "		+ SUM(coalesce ( e.effectif, 0 )) OVER (ORDER BY c.an ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as integer ) AS nombre\n" +
                                                  "from \n" +
                                                  "	calendar c\n" +
                                                  "left join\n" +
                                                  "	effectif_annee e on c.an = e.annee\n" +
                                                  " where	c.an >= " + anneeMin + " and c.an <= " + anneeMax + "\n" +
                                                  "group by \n" +
                                                  "	c.an, e.effectif";
                    
                    EvolutionCroyant[] evolutions = ( EvolutionCroyant[] ) CGenUtil.rechercher(this, query, c);
                    return evolutions;
          }
          
          // Okey requete maka ny isan'ny mpandray hatrany no ho atao
          
          public EvolutionCroyant[] getMpandrayEvolution( String anneeMin, String anneeMax, Connection connection ) throws Exception{
                    String query = "with calendar as (\n" +
"	 		select \n" +
"	 			generate_series( " + anneeMin + ",  " + anneeMax + " ) as annee\n" +
"	 	),\n" +
"	 	count_mpandray as (\n" +
"	 		select \n" +
"		 		extract ( year from m.datenandraisana ) as annee, count(*) as nombre\n" +
"		 	from \n" +
"		 		mpandray m\n" +
"		 	group by \n" +
"		 		extract ( year from m.datenandraisana )\n" +
"	 \n" +
"	 	)\n" +
"	 	select \n" +
"	 		c.annee,\n" +
"	 		coalesce ( cm.nombre, 0 ) as nombre\n" +
"	 	from \n" +
"	 		calendar c\n" +
"	 	left join\n" +
"	 		count_mpandray cm on c.annee = cm.annee\n" +
"	 	order by c.annee";
                  this.setNomTable("v_evolution_cr_vide");
                  EvolutionCroyant[] evs = (EvolutionCroyant[]) CGenUtil.rechercher(this, query, connection);
                  return evs;
          }
          
          
}
