package stock;

import java.sql.Date;
import bean.ClassMAPTable;
import utilitaire.Utilitaire;

public class EtatStock extends ClassMAPTable {
    String id;
    
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
                    "	NVL(inv.QUANTITE,0) QUANTITE, " +
                    "	NVL(mvt.ENTREE,0) ENTREE,  " +
                    "	NVL(mvt.SORTIE,0) SORTIE,  " +
                    "	NVL(mvt.ENTREE,0)+NVL(inv.QUANTITE,0)-NVL(mvt.SORTIE,0) reste, " +
                    "	p.IDUNITE, " +
                    "	u.desce AS idunitelib, " +
                    "   CAST(NVL(p.PUVENTE ,0) AS NUMBER(30,2)) PUVENTE, " +
                    "	mag.IDPOINT, " +
                    "	mag.IDTYPEMAGASIN "+
                    "FROM  " +
                    "	INVENTAIRE_FILLE_CPL inv, " +
                    "	( " +
                    "       SELECT  " +
                    "			inv.IDPRODUIT , " +
                    "                   inv.IDMAGASIN, "+
                    "			MAX(inv.DATY) maxDateInventaire " +
                    "		FROM  " +
                    "			INVENTAIRE_FILLE_CPL inv  " +
                    "		WHERE  " +
                    "			inv.ETAT = 11  " +
                    "			AND inv.DATY <= '"+Utilitaire.datetostring(dateMin)+"' " +
                    "		GROUP BY inv.IDPRODUIT,inv.IDMAGASIN " +
                    "	) invm, " +
                    "	( " +
                    "		SELECT  " +
                    "			m.IDPRODUIT , " +
                    "                   dinv.IDMAGASIN, "+
                    "			SUM(nvl(m.ENTREE,0)) ENTREE ,  " +
                    "			SUM(nvl(m.SORTIE ,0)) SORTIE  " +
                    "		FROM  " +
                    "			MVTSTOCKFILLELIB m , " +
                    "			( " +
                    "			SELECT  " +
                    "				inv.IDPRODUIT , " +
                    "                           inv.IDMAGASIN,"+
                    "				MAX(inv.DATY) maxDateInventaire " +
                    "			FROM  " +
                    "				INVENTAIRE_FILLE_CPL inv  " +
                    "			WHERE  " +
                    "				inv.ETAT = 11  " +
                    "				AND inv.DATY <= '"+Utilitaire.datetostring(dateMin)+"' " +
                    "			GROUP BY inv.IDPRODUIT,inv.IDMAGASIN " +
                    "			) dinv " +
                    "		WHERE  " +
                    "			m.IDPRODUIT = dinv.IDPRODUIT(+) " +
                    "                   AND m.IDMAGASIN = dinv.IDMAGASIN(+)"+
                    "			AND m.DATY > dinv.maxDateInventaire " +
                    "			AND m.DATY <= '"+Utilitaire.datetostring(dateMax)+"' " +
                    "		GROUP BY m.IDPRODUIT,dinv.IDMAGASIN " +
                    "	) mvt, " +
                    "	produit p, " +
                    "	type_produit tp, " +
                    "	magasin mag, " +
                    "	unite u " +
                    "WHERE  " +
                    "	inv.DATY = invm.maxDateInventaire " +
                    "	AND inv.IDMAGASIN = invm.IDMAGASIN " +
                    "	AND inv.IDPRODUIT = invm.IDPRODUIT " +
                    "	AND inv.IDPRODUIT = mvt.IDPRODUIT(+) " +
                    "	AND inv.IDMAGASIN = mvt.IDMAGASIN(+) " +
                    "	AND inv.IDPRODUIT = p.ID(+) " +
                    "	AND p.IDTYPEPRODUIT = tp.ID " +
                    "	AND inv.idmagasin = mag.ID " +
                    "	AND p.IDUNITE = u.ID(+) "+
                    "   AND inv.ETAT = 11 ";
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
    
}
