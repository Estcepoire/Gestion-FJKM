
package evenement;

/**
 *
 * @author sarobidy
 */
public class EvenementLib extends Evenement {
          String status;
          String latLong;
          String typeEvenement;
          
          public EvenementLib(){
                    this.setNomTable("v_evenement_lib");
          }

          public String getStatus() {
                    return status;
          }

          public void setStatus(String status) {
                    this.status = status;
          }

          public String getLatLong() {
                    return latLong;
          }

          public void setLatLong(String latLong) {
                    this.latLong = latLong;
          }

          public String getTypeEvenement() {
                    return typeEvenement;
          }

          public void setTypeEvenement(String typeEvenement) {
                    this.typeEvenement = typeEvenement;
          }
          
          
          
}
