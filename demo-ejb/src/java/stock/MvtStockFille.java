package stock;

import java.sql.Connection;
import bean.ClassFille;

public class MvtStockFille extends ClassFille {
    String id, idMere, idProduit;
    String val, designation, remarque;
    double entree, sortie, quantites, prixUnitaire;

    public MvtStockFille() throws Exception {
        this.setNomTable("MvtStockFille");
        this.setLiaisonMere("idMere");
        setNomClasseMere("stock.MvtStock");
    }

    public String getIdProduit() {
        return idProduit;
    }

    public void setIdProduit(String idProduit) {
        this.idProduit = idProduit;
    }

    public String getVal() {
        return val;
    }

    public void setVal(String val) {
        this.val = val;
    }


    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public double getEntree() {
        return entree;
    }

    public void setEntree(double entree) {
        this.entree = entree;
    }

    public double getQuantites() {
        return quantites;
    }

    public void setQuantites(double quantites) {
        this.quantites = quantites;
    }

    public double getSortie() {
        return sortie;
    }

    public void setSortie(double sortie) {
        this.sortie = sortie;
    }


    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return this.getId();
    }

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

    public double getPrixUnitaire() {
        return prixUnitaire;
    }

    public void setPrixUnitaire(double prixUnitaire) {
        this.prixUnitaire = prixUnitaire;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("MVTSTOCKFILLE", "GET_SEQMVTSTOCK");
        this.setId(makePK(c));
    }
}
