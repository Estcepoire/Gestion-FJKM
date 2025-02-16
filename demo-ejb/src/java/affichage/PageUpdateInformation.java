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
public class PageUpdateInformation extends PageUpdateMultiple {
          
          FormulaireChamp formulaire;
          
          public PageUpdateInformation(ClassMAPTable o, ClassMAPTable fle, ClassMAPTable[] fille, HttpServletRequest req, UserEJB u, int nombreLigne) throws Exception {
                    super(o, fle, fille, req, u, nombreLigne);
          }
          
          public void preparerData() throws Exception{
//                              this.getDataFille()
                              // Inona no andeha atao ato
                              // Mila manao recherche kely
                              InformationAnnexeChamp[] infos = (InformationAnnexeChamp[])  this.getDataFille();
                              this.setFormulaire(new FormulaireChamp());
                              this.getFormulaire().setChamps(infos);
          }

          public FormulaireChamp getFormulaire() {
                    return formulaire;
          }

          public void setFormulaire(FormulaireChamp formulaire) {
                    this.formulaire = formulaire;
          }
          
          
          
          
}
