
package evenement;

/**
 *
 * @author sarobidy
 */
public class EvenementLib extends Evenement {
          String status;
          
          public EvenementLib(){
                    this.setNomTable("v_evenement_etat");
          }

          public String getStatus() {
                    return status;
          }

          public void setStatus(String status) {
                    this.status = status;
          }
          
}
