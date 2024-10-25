package stock;

import java.sql.Date;

import bean.CGenUtil;
import bean.ClassMAPTable;
import utilitaire.Utilitaire;

public class EtatStock extends ClassMAPTable {
    String id;
    String designation;
    String idmagasin;
    String idmagasinlib;
    String idunite;
    String idunitelib;
    String idtypeproduit;
    String idtypeproduitlib;
    Date dateDernierinventaire;
    double quantite;
    double entree;
    double sortie;
    double reste;

    Date daty;
    String datyMin;
    String datyMax;

    public String getDatyMin() {
        return datyMin;
    }

    public void setDatyMin(String datyMin) {
        this.datyMin = datyMin;
    }

    public String getDatyMax() {
        return datyMax;
    }

    public void setDatyMax(String datyMax) {
        this.datyMax = datyMax;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getIdmagasin() {
        return idmagasin;
    }

    public void setIdmagasin(String idmagasin) {
        this.idmagasin = idmagasin;
    }

    public String getIdmagasinlib() {
        return idmagasinlib;
    }

    public void setIdmagasinlib(String idmagasinlib) {
        this.idmagasinlib = idmagasinlib;
    }

    public String getIdunite() {
        return idunite;
    }

    public void setIdunite(String idunite) {
        this.idunite = idunite;
    }

    public String getIdunitelib() {
        return idunitelib;
    }

    public void setIdunitelib(String idunitelib) {
        this.idunitelib = idunitelib;
    }

    public String getIdtypeproduit() {
        return idtypeproduit;
    }

    public void setIdtypeproduit(String idtypeproduit) {
        this.idtypeproduit = idtypeproduit;
    }

    public String getIdtypeproduitlib() {
        return idtypeproduitlib;
    }

    public void setIdtypeproduitlib(String idtypeproduitlib) {
        this.idtypeproduitlib = idtypeproduitlib;
    }

    public Date getDateDernierinventaire() {
        return dateDernierinventaire;
    }

    public void setDateDernierinventaire(Date dateDernierinventaire) {
        this.dateDernierinventaire = dateDernierinventaire;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    public double getEntree() {
        return entree;
    }

    public void setEntree(double entree) {
        this.entree = entree;
    }

    public double getSortie() {
        return sortie;
    }

    public void setSortie(double sortie) {
        this.sortie = sortie;
    }

    public double getReste() {
        return reste;
    }

    public void setReste(double reste) {
        this.reste = reste;
    }

    public String generateQueryCore(Date dateMin, Date dateMax) {
        String query = "SELECT " +
                "inv.idproduit AS ID, " +
                "inv.designation, " +
                "inv.idmagasin, " +
                "mag.desce AS idmagasinlib, " +
                "inv.idunite, " +
                "inv.unitelib as idunitelib, " +
                "inv.idtypeproduit, " +
                "inv.idtypeproduitlib," +
                "inv.DATY AS dateDernierinventaire, " +
                "COALESCE(inv.QUANTITE, 0) AS QUANTITE, " +
                "COALESCE(mvt.ENTREE, 0) AS ENTREE, " +
                "COALESCE(mvt.SORTIE, 0) AS SORTIE, " +
                "COALESCE(mvt.ENTREE, 0) + COALESCE(inv.QUANTITE, 0) - COALESCE(mvt.SORTIE, 0) AS reste," +
                "CURRENT_DATE  as daty " +
                "FROM  " +
                "INVENTAIRE_FILLE_CPL inv " +
                "JOIN ( " +
                "SELECT  " +
                "inv.idproduit,  " +
                "inv.IDMAGASIN,  " +
                "MAX(inv.DATY) AS maxDateInventaire " +
                "FROM  " +
                "INVENTAIRE_FILLE_CPL inv " +
                "WHERE  " +
                "inv.ETAT = 11  " +
                "AND inv.DATY <= '" + Utilitaire.datetostring(dateMin) + "' " +
                "GROUP BY  " +
                "inv.idproduit, inv.IDMAGASIN " +
                ") invm ON inv.DATY = invm.maxDateInventaire  " +
                "AND inv.IDMAGASIN = invm.IDMAGASIN  " +
                "AND inv.idproduit = invm.idproduit " +
                "JOIN ( " +
                "SELECT  " +
                "m.idproduit ,  " +
                "dinv.IDMAGASIN,  " +
                "SUM(COALESCE(m.ENTREE, 0)) AS ENTREE,  " +
                "SUM(COALESCE(m.SORTIE, 0)) AS SORTIE " +
                "FROM  " +
                "MVTSTOCKFILLELIB m " +
                "JOIN ( " +
                "SELECT  " +
                "inv.idproduit,  " +
                "inv.IDMAGASIN,  " +
                "MAX(inv.DATY) AS maxDateInventaire " +
                "FROM  " +
                "INVENTAIRE_FILLE_CPL inv " +
                "WHERE  " +
                "inv.ETAT = 11  " +
                "AND inv.DATY <= '" + Utilitaire.datetostring(dateMin) + "' " +
                "GROUP BY  " +
                "inv.idproduit, inv.IDMAGASIN " +
                ") dinv ON m.idproduit = dinv.idproduit  " +
                "AND m.IDMAGASIN = dinv.IDMAGASIN " +
                "WHERE  " +
                "m.DATY > dinv.maxDateInventaire  " +
                "AND m.DATY <= '" + Utilitaire.datetostring(dateMax) + "'  " +
                "GROUP BY  " +
                "m.idproduit, dinv.IDMAGASIN " +
                ") mvt ON inv.idproduit = mvt.idproduit  " +
                "AND inv.IDMAGASIN = mvt.IDMAGASIN " +
                "JOIN  " +
                "magasin mag ON inv.idmagasin = mag.ID " +
                "WHERE  " +
                "inv.ETAT = 11 ";
        return query;
    }

    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public EtatStock[] caculEtatStock() throws Exception {
        String query = this.generateQueryCore(Utilitaire.stringDate(this.getDatyMin()),
                Utilitaire.stringDate(this.getDatyMin()));
        if (this.getIdmagasin() != null && this.getId() != null) {
            query = query + " and inv.idmagasin =' " + this.getIdmagasin() + "' and inv.idproduit ='" + this.getId()
                    + "'";
        }
        EtatStock[] etatStocks = (EtatStock[]) CGenUtil.rechercher(new EtatStock(), query);
        return etatStocks;
    }
    
}
