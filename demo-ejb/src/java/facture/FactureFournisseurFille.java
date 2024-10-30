package facture;

import bean.ClassFille;

public class FactureFournisseurFille extends ClassFille {

    String id;

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    

}
