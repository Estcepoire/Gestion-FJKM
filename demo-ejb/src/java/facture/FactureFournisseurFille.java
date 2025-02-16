package facture;

import java.sql.Connection;

import bean.ClassFille;

public class FactureFournisseurFille extends ClassFille {

    String id;
    String idMere;
    String idProduit;
    String remarque;
    double prixunitaire;
    double quantite;

    String idproduitlib;
    String idunitelib;

    

    public String getId() {
        return id;
    }

    public String getIdproduitlib() {
        return idproduitlib;
    }

    public void setIdproduitlib(String idproduitlib) {
        this.idproduitlib = idproduitlib;
    }

    public String getIdunitelib() {
        return idunitelib;
    }

    public void setIdunitelib(String idunitelib) {
        this.idunitelib = idunitelib;
    }

    public FactureFournisseurFille() throws Exception {
        this.setNomTable("factureFournisseurFille");
        setNomClasseMere("facture.FactureFournisseur");
        setLiaisonMere("idMere");
    }

    public String getIdMere() {
        return idMere;
    }

    public void setIdMere(String idMere) {
        this.idMere = idMere;
    }

    public String getIdProduit() {
        return idProduit;
    }

    public void setIdProduit(String idProduit) {
        this.idProduit = idProduit;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public double getPrixunitaire() {
        return prixunitaire;
    }

    public void setPrixunitaire(double prixunitaire) {
        this.prixunitaire = prixunitaire;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("FFFILLE", "GET_SEQfactureFournisseurFille");
        this.setId(makePK(c));
    }
    

}
