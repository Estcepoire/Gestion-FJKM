package evenement.participation;

/**
 *
 * @author sarobidy
 */
public class ParticipationLib extends Participation {
          
          String nomComplet;

          public String getNomComplet() {
                    return nomComplet;
          }

          public void setNomComplet(String nomComplet) {
                    this.nomComplet = nomComplet;
          }
          
          public ParticipationLib(){
                    this.setNomTable("v_participation_croyant");
          }
          
}
