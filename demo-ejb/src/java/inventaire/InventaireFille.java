package inventaire;

import java.sql.Connection;
import java.sql.Date;

import bean.CGenUtil;
import bean.ClassFille;
import bean.ClassMAPTable;
import stock.EtatStock;

public class InventaireFille extends ClassFille {
    String id;
    String idMere;
    String explication;
    double quantitetheorique;
    double quantite;
    String idproduit;
    String idMagasin;

    public String getIdMagasin() {
        return idMagasin;
    }

    public void setIdMagasin(String idMagasin) {
        this.idMagasin = idMagasin;
    }

    public InventaireFille() throws Exception {
        setLiaisonMere("idMere");
        setNomClasseMere("inventaire.Inventaire");
        this.setNomTable("InventaireFille");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getExplication() {
        return explication;
    }

    public void setExplication(String explication) {
        this.explication = explication;
    }

    public double getQuantitetheorique() {
        return quantitetheorique;
    }

    public void setQuantitetheorique(double quantitetheorique) {
        this.quantitetheorique = quantitetheorique;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    public String getIdproduit() {
        return idproduit;
    }

    public void setIdproduit(String idproduit) {
        this.idproduit = idproduit;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    public String getIdMere() {
        return idMere;
    }

    public void setIdMere(String idMere) {
        this.idMere = idMere;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("INVENTAIRE", "getseqinventairefille");
        this.setId(makePK(c));
    }

    public Inventaire getInventaireMere(Connection c) throws Exception {
        Inventaire inventaire = new Inventaire();
        inventaire.setId(this.getIdMere());
        Inventaire[] inventaires = (Inventaire[]) CGenUtil.rechercher(inventaire, null, null, c, "");
        if (inventaires.length <= 0) {
            throw new Exception("inventaire non trouver");
        }
        return inventaires[0];
    }

    protected void controlerDuplicationInventaire(Connection c) throws Exception {
        Inventaire inventaire = getInventaireMere(c);
        InventaireFille inventairefille = new InventaireFille();
        inventairefille.setNomTable("inventaire_fille_cpl");
        inventairefille.setIdproduit(this.getIdproduit());
        inventairefille.setIdMagasin(inventaire.getIdMagasin());
        InventaireFille[] invfcpl = (InventaireFille[]) CGenUtil.rechercher(inventairefille, null, null, c,
                " AND daty = TO_DATE('" + inventaire.getDaty() + "', 'YYYY-MM-DD') ");
        if (invfcpl.length > 0) {
            throw new Exception("Une inventaire pour ce produit a deja ete validee pour la meme date");
        }
    }

    protected void calculateQuantiteTheorique(Connection c) throws Exception {
        Inventaire inventaireMere = getInventaireMere(c);
        Date daty = inventaireMere.getDaty();
        EtatStock etatStock = new EtatStock();
        String query = etatStock.generateQueryCore(daty, daty) + " and inv.idproduit ='" + this.getIdproduit()
                + "' and inv.idmagasin='" + inventaireMere.getIdMagasin() + "' ";
        EtatStock[] listetat = (EtatStock[]) CGenUtil.rechercher(etatStock, query, c);
        double mt = 0;
        if (listetat.length == 1) {
            mt = listetat[0].getReste();
        }
        this.setQuantitetheorique(mt);
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        this.controlerDuplicationInventaire(c);
        this.calculateQuantiteTheorique(c);
        return super.createObject(u, c);
    }

}
