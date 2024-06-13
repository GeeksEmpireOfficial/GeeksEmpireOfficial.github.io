class Endpoints {

  final String _consumerKey = "ck_e469d717bd778da4fb9ec24881ee589d9b202662";
  final String _consumerSecret = "cs_ac53c1b36d1a85e36a362855d83af93f0d377686";

  /*
   * Cool Gadget; 5408
   */
  String productsByTag(String tagId, {String productsPerPage = "13"}) {

    return "https://geeksempire.co/wp-json/wc/v3/products?"
        "consumer_key=$_consumerKey"
        "&consumer_secret=$_consumerSecret"
        "&per_page=$productsPerPage"
        "&tag=$tagId";
  }

  String productsById(int productId) {

    // /#/Categories?productId=15873
    return "https://geeksempire.co/wp-json/wc/v3/products/"
        "$productId" "?"
        "consumer_key=$_consumerKey"
        "&consumer_secret=$_consumerSecret";
  }

}