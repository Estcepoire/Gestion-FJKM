package stock;

import java.sql.Date;
import bean.ClassMAPTable;
import utilitaire.Utilitaire;

public class EtatStock extends ClassMAPTable {
    String id;
    double reste;
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String generateQueryCore(Date dateMin, Date dateMax) {
        String query =  " SELECT  " +
                    "	inv.IDPRODUIT AS ID, " +
                    "	p.desce AS idproduitLib, " +
                    "	p.IDTYPEPRODUIT, " +
                    "	tp.desce AS idtypeproduitlib, " +
                    "	inv.idmagasin, " +
                    "	mag.desce AS idmagasinlib, " +
                    "	inv.DATY dateDernierinventaire, " +
                    "	COALESCE(inv.QUANTITE, 0) QUANTITE, " +
                    "	COALESCE(mvt.ENTREE, 0) ENTREE,  " +
                    "	COALESCE(mvt.SORTIE, 0) SORTIE,  " +
                    "	COALESCE(mvt.ENTREE, 0) + COALESCE(inv.QUANTITE, 0) - COALESCE(mvt.SORTIE, 0) reste, " +
                    "	p.IDUNITE, " +
                    "	u.desce AS idunitelib, " +
                    "   COALESCE(CAST(p.PUVENTE AS NUMERIC(30, 2)), 0) PUVENTE, " +
                    "	mag.IDPOINT, " +
                    "	mag.IDTYPEMAGASIN " +
                    "FROM  " +
                    "	INVENTAIRE_FILLE_CPL inv " +
                    "	JOIN (" +
                    "       SELECT inv.IDPRODUIT, inv.IDMAGASIN, MAX(inv.DATY) maxDateInventaire " +
                    "		FROM INVENTAIRE_FILLE_CPL inv " +
                    "		WHERE inv.ETAT = 11 " +
                    "		AND inv.DATY <= '" + Utilitaire.datetostring(dateMin) + "' " +
                    "		GROUP BY inv.IDPRODUIT, inv.IDMAGASIN " +
                    "	) invm ON inv.DATY = invm.maxDateInventaire " +
                    "	JOIN (" +
                    "		SELECT m.IDPRODUIT, dinv.IDMAGASIN, " +
                    "			SUM(COALESCE(m.ENTREE, 0)) ENTREE, " +
                    "			SUM(COALESCE(m.SORTIE, 0)) SORTIE " +
                    "		FROM MVTSTOCKFILLELIB m " +
                    "		JOIN (" +
                    "			SELECT inv.IDPRODUIT, inv.IDMAGASIN, MAX(inv.DATY) maxDateInventaire " +
                    "			FROM INVENTAIRE_FILLE_CPL inv " +
                    "			WHERE inv.ETAT = 11 " +
                    "			AND inv.DATY <= '" + Utilitaire.datetostring(dateMin) + "' " +
                    "			GROUP BY inv.IDPRODUIT, inv.IDMAGASIN " +
                    "		) dinv ON m.IDPRODUIT = dinv.IDPRODUIT AND m.IDMAGASIN = dinv.IDMAGASIN " +
                    "		WHERE m.DATY > dinv.maxDateInventaire " +
                    "		AND m.DATY <= '" + Utilitaire.datetostring(dateMax) + "' " +
                    "		GROUP BY m.IDPRODUIT, dinv.IDMAGASIN " +
                    "	) mvt ON inv.IDPRODUIT = mvt.IDPRODUIT AND inv.IDMAGASIN = mvt.IDMAGASIN " +
                    "	JOIN produit p ON inv.IDPRODUIT = p.ID " +
                    "	JOIN type_produit tp ON p.IDTYPEPRODUIT = tp.ID " +
                    "	JOIN magasin mag ON inv.idmagasin = mag.ID " +
                    "	LEFT JOIN unite u ON p.IDUNITE = u.ID " +
                    "WHERE inv.ETAT = 11 ";
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
    public static void main(String[] args) {
        
    }

    public double getReste() {
        return reste;
    }

    public void setReste(double reste) {
        this.reste = reste;
    }
    
}
