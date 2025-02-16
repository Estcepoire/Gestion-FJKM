package caisse;

import bean.*;

public class Suivie extends ClassMAPTable {

    String id;
    int mois;
    int annee;
    double totalentrees;
    double totalsorties;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getMois() {
        return mois;
    }

    public void setMois(int mois) {
        this.mois = mois;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    public double getTotalentrees() {
        return totalentrees;
    }

    public void setTotalentrees(double totalentrees) {
        this.totalentrees = totalentrees;
    }

    public double getTotalsorties() {
        return totalsorties;
    }

    public void setTotalsorties(double totalsorties) {
        this.totalsorties = totalsorties;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    public Suivie() {
        super.setNomTable("vue_suivie_caisse_par_mois");
    }

}
