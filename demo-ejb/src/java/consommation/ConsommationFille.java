package consommation;

import java.sql.Connection;

import bean.ClassFille;

public class ConsommationFille extends ClassFille {

    String id;
    String idMere;
    String idProduit;
    double quantite;
    String remarque;

    String val;

    String idProduitLib;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    public ConsommationFille() throws Exception {
        this.setNomTable("Consommationfille");
        setLiaisonMere("idMere");
        setNomClasseMere("consommation.Consommation");

    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("CONSOFILLE", "GET_SEQMVTSTOCK");
        this.setId(makePK(c));
    }

    public String getIdProduitLib() {
        return idProduitLib;
    }

    public void setIdProduitLib(String idProduitLib) {
        this.idProduitLib = idProduitLib;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

}
