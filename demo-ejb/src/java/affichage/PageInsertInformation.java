/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package affichage;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import javax.servlet.http.HttpServletRequest;
import user.UserEJB;
import utilitaire.UtilDB;

/**
 *
 * @author sarobidy
 */
public class PageInsertInformation extends PageInsertMultiple {
          
          FormulaireChamp formulaire;
          
          public PageInsertInformation(ClassMAPTable bse, ClassMAPTable fle, HttpServletRequest req, int nbLine, UserEJB u) throws Exception {
                    super(bse, fle, req, nbLine, u);
          }
          
          public void preparerData() throws Exception{
                    try(Connection connection = new UtilDB().GetConn()){
                              // Inona no andeha atao ato
                              // Mila manao recherche kely
                              InformationAnnexeChamp[] infos = (InformationAnnexeChamp[]) CGenUtil.rechercher(new InformationAnnexeChamp(), null, null, connection, "");
                              this.setFormulaire(new FormulaireChamp());
                              this.getFormulaire().setChamps(infos);
                    }
          }
          
          // Okey inona no ataoko manaraka
          // Mila manamboatra formulaire hafa
          
          public FormulaireChamp getFormulaire() {
                    return formulaire;
          }

          public void setFormulaire(FormulaireChamp formulaire) {
                    this.formulaire = formulaire;
          }
          
}
