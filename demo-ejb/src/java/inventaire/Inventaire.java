package inventaire;

import java.sql.Connection;
import java.sql.Date;

import bean.CGenUtil;
import bean.ClassMere;

public class Inventaire extends ClassMere {

    String id;
    Date daty;
    String designation;
    String idMagasin;
    String remarque;

    public Inventaire() throws Exception {
        this.setNomTable("Inventaire");
        setNomClasseFille("inventaire.InventaireFille");
        setLiaisonFille("idMere");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getIdMagasin() {
        return idMagasin;
    }

    public void setIdMagasin(String idMagasin) {
        this.idMagasin = idMagasin;
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

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("INVENTAIRE", "getseqinventaire");
        this.setId(makePK(c));
    }

    public InventaireFille generateInventaireFilleZero() throws Exception {
        InventaireFille invF = new InventaireFille();
        invF.setQuantite(0);
        invF.setQuantitetheorique(0);
        invF.setIdMere(this.getId());
        invF.setExplication("inventaire 0");
        return invF;
    }

}
