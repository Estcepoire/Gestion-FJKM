package annexe;

import java.sql.Connection;

import bean.ClassEtat;

public class Produit extends ClassEtat {
    String id, idUnite, idTypeProduit;
    String val, desce;
    double prixUnitaire;

    String unitelib, typeProduitlib;

    public String getUnitelib() {
        return unitelib;
    }

    public void setUnitelib(String unitelib) {
        this.unitelib = unitelib;
    }

    public String getTypeProduitlib() {
        return typeProduitlib;
    }

    public void setTypeProduitlib(String typeProduitlib) {
        this.typeProduitlib = typeProduitlib;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdUnite() {
        return idUnite;
    }

    public void setIdUnite(String idUnite) {
        this.idUnite = idUnite;
    }

    public String getIdTypeProduit() {
        return idTypeProduit;
    }

    public void setIdTypeProduit(String idTypeProduit) {
        this.idTypeProduit = idTypeProduit;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }

    public String getDesce() {
        return desce;
    }

    public void setDesce(String desce) {
        this.desce = desce;
    }

    public double getPrixUnitaire() {
        return prixUnitaire;
    }

    public void setPrixUnitaire(double prixUnitaire) {
        this.prixUnitaire = prixUnitaire;
    }

    public Produit() {
        this.setNomTable("PRODUIT");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("PROD", "GET_SEQPRODUIT");
        this.setId(makePK(c));
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
    public String[] getMotCles() {
        String[] motCles = { "id", "val" };
        return motCles;
    }

    @Override
    public String[] getValMotCles() {
        String[] valMotCles = { "val" };
        return valMotCles;
    }
}
