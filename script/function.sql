CREATE OR REPLACE FUNCTION generate_query_core(dateMin DATE, dateMax DATE)
RETURNS TEXT AS $$
BEGIN
    RETURN
    'SELECT
        inv.idmodeledispo AS ID,
        inv.idmagasin,
        inv.idmodeledispo,
        mag.desce AS idmagasinlib,
        inv.DATY dateDernierinventaire,
        COALESCE(inv.QUANTITE, 0) QUANTITE,
        COALESCE(mvt.ENTREE, 0) ENTREE,
        COALESCE(mvt.SORTIE, 0) SORTIE,
        COALESCE(mvt.ENTREE, 0) + COALESCE(inv.QUANTITE, 0) - COALESCE(mvt.SORTIE, 0) reste,
        mag.IDPOINT,
        mag.IDTYPEMAGASIN
    FROM
        INVENTAIRE_FILLE_CPL inv,
        (
            SELECT
                inv.idmodeledispo,
                inv.IDMAGASIN,
                MAX(inv.DATY) maxDateInventaire
            FROM
                INVENTAIRE_FILLE_CPL inv
            WHERE
                inv.ETAT = 11
                AND inv.DATY <= ''' || dateMin || '''
            GROUP BY
                inv.idmodeledispo, inv.IDMAGASIN
        ) invm,
        (
            SELECT
                m.idmodeledispo,
                dinv.IDMAGASIN,
                SUM(COALESCE(m.ENTREE, 0)) ENTREE,
                SUM(COALESCE(m.SORTIE, 0)) SORTIE
            FROM
                MVTSTOCKFILLELIB m,
                (
                    SELECT
                        inv.idmodeledispo,
                        inv.IDMAGASIN,
                        MAX(inv.DATY) maxDateInventaire
                    FROM
                        INVENTAIRE_FILLE_CPL inv
                    WHERE
                        inv.ETAT = 11
                        AND inv.DATY <= ''' || dateMin || '''
                    GROUP BY
                        inv.idmodeledispo, inv.IDMAGASIN
                ) dinv
            WHERE
                m.idmodeledispo = dinv.idmodeledispo
                AND m.IDMAGASIN = dinv.IDMAGASIN
                AND m.DATY > dinv.maxDateInventaire
                AND m.DATY <= ''' || dateMax || '''
            GROUP BY
                m.idmodeledispo, dinv.IDMAGASIN
        ) mvt,
        magasin mag
    WHERE
        inv.DATY = invm.maxDateInventaire
        AND inv.IDMAGASIN = invm.IDMAGASIN
        AND inv.idmodeledispo = invm.idmodeledispo
        AND inv.idmodeledispo = mvt.idmodeledispo
        AND inv.IDMAGASIN = mvt.IDMAGASIN
        AND inv.idmagasin = mag.ID
        AND inv.ETAT = 11';
END;
$$ LANGUAGE plpgsql;


-- to call 

SELECT generate_query_core('2024-01-01', '2024-12-31');
