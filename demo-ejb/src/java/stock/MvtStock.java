package stock;

import java.sql.Connection;
import java.sql.Date;
import bean.*;

public class MvtStock extends ClassMere {
    String id, designation, idMagasin, idTypeMvStock;
    Date daty;

    public MvtStock() throws Exception {
        this.setNomTable("MvtStock");
        this.setLiaisonFille("idMere");
        this.setNomClasseFille("stock.MvtStockFille");
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

    public String getIdMagasin() {
        return idMagasin;
    }

    public void setIdMagasin(String idMagasin) {
        this.idMagasin = idMagasin;
    }

    public String getIdTypeMvStock() {
        return idTypeMvStock;
    }

    public void setIdTypeMvStock(String idTypeMvStock) {
        this.idTypeMvStock = idTypeMvStock;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("MVTSTOCK", "GET_SEQMVTSTOCK");
        this.setId(makePK(c));
    }

}
