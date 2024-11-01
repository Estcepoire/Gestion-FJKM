package facture;

import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.ClassMere;
import caisse.MvtCaisse;
import stock.MvtStock;
import stock.MvtStockFille;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

import java.sql.Connection;
import java.sql.Date;

public class FactureFournisseur extends ClassMere {
    String id;
    String val;
    String desce;
    Date daty;
    String idTiers;
    String idlignecredit;

    String idtierslib;
    String idlignecreditlib;
    double montant;

    public String getIdtierslib() {
        return idtierslib;
    }

    public void setIdtierslib(String idtierslib) {
        this.idtierslib = idtierslib;
    }

    public String getIdlignecreditlib() {
        return idlignecreditlib;
    }

    public void setIdlignecreditlib(String idlignecreditlib) {
        this.idlignecreditlib = idlignecreditlib;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public FactureFournisseur() throws Exception {
        this.setNomTable("factureFournisseur");
        setNomClasseFille("facture.FactureFournisseurFille");
        setLiaisonFille("idMere");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getIdTiers() {
        return idTiers;
    }

    public void setIdTiers(String idTiers) {
        this.idTiers = idTiers;
    }

    public String getIdlignecredit() {
        return idlignecredit;
    }

    public void setIdlignecredit(String idlignecredit) {
        this.idlignecredit = idlignecredit;
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
        this.preparePk("FF", "GET_SEQfactureFournisseur");
        this.setId(makePK(c));
    }

    public String genererMvtCaisse(String u, Connection c, String idCaisse) throws Exception {
        boolean canClose = false;
        String idmvt;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                canClose = true;
            }
            MvtCaisse mvtCaisse = new MvtCaisse();
            if (this.getEtat() == 11) {
                mvtCaisse.setIdCaisse(idCaisse);
                mvtCaisse.setIdOrigine(this.getId());
                mvtCaisse.setIdTiers(this.getIdTiers());
                mvtCaisse.setDaty(Utilitaire.dateDuJourSql());
                mvtCaisse.setDesignation(" Payement Facture " + this.getId());
                mvtCaisse.setCredit(this.getMontant());
                mvtCaisse.setDebit(0);
                mvtCaisse = (MvtCaisse) mvtCaisse.createObject(u, c);
                idmvt = mvtCaisse.getId();
            } else {
                throw new Exception("La facture doit &ecirc;tre valid&eacute;e");
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (canClose) {
                c.close();
            }
        }
        return idmvt;
    }

    public FactureFournisseurFille[] getFilles(Connection c) throws Exception {
        FactureFournisseurFille fille = new FactureFournisseurFille();
        fille.setIdMere(this.getId());
        FactureFournisseurFille[] filles = (FactureFournisseurFille[]) CGenUtil.rechercher(fille, null, null, c, "");
        if (filles.length <= 0) {
            throw new Exception("Aucun d&eacute;tails");
        }
        return filles;
    }

    public MvtStock genererStock(String u, Connection c) throws Exception {
        MvtStock m = new MvtStock();
        m.setDesignation("facture" + this.getId());
        m.setIdMagasin("UNIT000001");
        m.setIdTypeMvStock("TYPMVT000001");
        m.setRemarque("facture" + this.getId());
        m.setIdOrigine(this.getId());
        m.setDaty(Utilitaire.dateDuJourSql());
        m = (MvtStock) m.createObject(u, c);
        return m;
    }

    public MvtStockFille[] genereFilles(String u, Connection c, String idMere) throws Exception {
        FactureFournisseurFille[] filles = this.getFilles(c);
        MvtStockFille[] mvtFilles = new MvtStockFille[filles.length];
        for (int i = 0; i < mvtFilles.length; i++) {
            mvtFilles[i] = new MvtStockFille();
            mvtFilles[i].setIdMere(idMere);
            mvtFilles[i].setDesignation("facture");
            mvtFilles[i].setRemarque(filles[i].getRemarque());
            mvtFilles[i].setIdProduit(filles[i].getIdProduit());
            mvtFilles[i].setPrixUnitaire(filles[i].getPrixunitaire());

            mvtFilles[i].setEntree(filles[i].getQuantite());
            System.out.println(mvtFilles[i].getEntree());
            mvtFilles[i].setSortie(0);
            mvtFilles[i].setQuantites(0);

            mvtFilles[i] = (MvtStockFille) mvtFilles[i].createObject(u, c);
        }
        return mvtFilles;
    }

    public String stocker(String u, Connection c) throws Exception {
        boolean canClose = false;
        MvtStock m = null;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                canClose = true;
            }
            m = this.genererStock(u, c);
            this.genereFilles(u, c, m.getId());
        } catch (Exception e) {
            throw e;
        } finally {
            if (canClose) {
                c.close();
            }
        }
        return m.getId();
    }
}
