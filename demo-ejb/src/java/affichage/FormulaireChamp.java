/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package affichage;

/**
 *
 * @author sarobidy
 */
public class FormulaireChamp extends Formulaire {
          
          // Inona no atao ato
          // mila avadika zavatra hafa ny make html
          InformationAnnexeChamp[] champs;

          public InformationAnnexeChamp[] getChamps() {
                    return champs;
          }

          public void setChamps(InformationAnnexeChamp[] champs) {
                    this.champs = champs;
          }
          
          public String createHTML(){
                    String div = "<div class='row'>";
                    div += "<div class='col-md-12'>";
                    div += "<div class='box'>";
                    div += "<div class='box box-primary'>";
                    div += "<div class='box-body'>";
                    div += "<h3 class='text-center'>" + this.getTitre() + "</h3>";
                    div += "<table class='table table-bordered'>";
                    div += "<thead>";
                    div += "<th style='background-color:#bed1dd'> </th>";
                    div += "<th style='background-color:#bed1dd'>Libellé</th>";
                    div += "<th style='background-color:#bed1dd'>Valeur</th>";
                    div += "</thead>";
                    div += "<tbody class='informations'>";
                    int length = this.getChamps().length;
                    
                    for( int i  = 0; i < length ; i++ ){
                              this.getChamps()[i].setName("valeur_"+i);
                              String tr = "<tr>";
                              String td= "";
                              td += "<td align='center'> ";
                              td += "<input name='id' value='%d' type='checkbox'  id='checkbox%d'/>";
                              td = String.format(td, i, i);
                              td += "</td> ";
                              td += "<td> ";
                              td += " <label class='form-label'> ";
                              td += this.getChamps()[i].getVal();
                              td += " </label> ";
                              td += "<input type='hidden' name='idInfoAnnexe_" + i +"' value='" + this.getChamps()[i].getTuppleID() +"' />";
                              td += "</td>";
                              td += "<td>";
                              td += this.getChamps()[i].getHtml();
                              td += "</td>";
                              tr = tr + td;
                              tr = tr + "</tr>";
                              div = div + tr;
                    }
                    div += "</tbody>";
                    div += "</table>";
                    div += "</div>";
                    div += "<div class='box-footer'>";
                    div += "<div class='col-md-12'>";
                    div += "<button type='button' class='btn btn-dark' id=\"prevButton\">Prev</button>\n" +
"                        <button type='button' class='btn btn-dark' id=\"nextButton\">Next</button>";
                    div += "</div>";
                    div += "</div>";
                    div += "</div>";
                    
                    return div;
          }
          
          public String createHTMLUpdate(){
                    String div = "<div class='row'>";
                    div += "<div class='col-md-12'>";
                    div += "<div class='box'>";
                    div += "<div class='box box-primary'>";
                    div += "<div class='box-body'>";
                    div += "<h3 class='text-center'> " + this.getTitre() + " </h3>";
                    div += "<table class='table table-bordered'>";
                    div += "<thead>";
                    div += "<th style='background-color:#bed1dd'> </th>";
                    div += "<th style='background-color:#bed1dd'>Libellé</th>";
                    div += "<th style='background-color:#bed1dd'>Valeur</th>";
                    div += "</thead>";
                    div += "<tbody class='informations'>";
                    int length = this.getChamps().length;
                    
                    for( int i  = 0; i < length ; i++ ){
                              this.getChamps()[i].setName("valeur_"+i);
                              String tr = "<tr>";
                              String td= "";
                              td += "<td align='center'> ";
                              td += "<input name='id' value='%d' type='checkbox'  id='checkbox%d'/>";
                              td = String.format(td, i, i);
                              td += "</td> ";
                              td += "<td> ";
                              td += " <label class='form-label'> ";
                              td += this.getChamps()[i].getVal();
                              td += " </label> ";
                              td += "<input type='hidden' name='idInfoAnnexe_" + i +"' value='" + this.getChamps()[i].getTuppleID() +"' />";
                              td += "<input type='hidden' name='idInfoMpivavaka_" + i +"' value='" + this.getChamps()[i].getIdInfoMpivavaka()+"' />";
                              td += "</td>";
                              td += "<td>";
                              td += this.getChamps()[i].getHtml();
                              td += "</td>";
                              tr = tr + td;
                              tr = tr + "</tr>";
                              div = div + tr;
                    }
                    div += "</tbody>";
                    div += "</table>";
                    div += "</div>";
                    div += "<div class='box-footer'>";
                    div += "<div class='col-md-12'>";
                    div += "<button type='button' class='btn btn-dark' id=\"prevButton\">Prev</button>\n" +
"                        <button type='button' class='btn btn-dark' id=\"nextButton\">Next</button>";
                    div += "</div>";
                    div += "</div>";
                    return div;
          }
          
}
