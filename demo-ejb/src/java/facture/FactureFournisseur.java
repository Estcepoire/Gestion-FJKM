package facture;

import bean.ClassMere;
import java.sql.Date;

public class FactureFournisseur extends ClassMere {
    String id;
    Date daty;

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return id;
    }

}
