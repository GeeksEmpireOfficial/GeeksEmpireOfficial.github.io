class Endpoints {

  final String _consumerKey = "ck_e469d717bd778da4fb9ec24881ee589d9b202662";
  final String _consumerSecret = "cs_ac53c1b36d1a85e36a362855d83af93f0d377686";

  /// Cool Gadget; 5408
  String productsByTag(String tagId, {String productsPerPage = "13"}) {

    return "https://geeksempire.co/wp-json/wc/v3/products?"
        "consumer_key=$_consumerKey"
        "&consumer_secret=$_consumerSecret"
        "&per_page=$productsPerPage"
        "&tag=$tagId";
  }

  String productsById(int productId) {

    // /#/StorefrontCategories?productId=15873
    return "https://geeksempire.co/wp-json/wc/v3/products/"
        "$productId" "?"
        "consumer_key=$_consumerKey"
        "&consumer_secret=$_consumerSecret";
  }

  String postsById(int postId) {

    // /#/MagazineCategories?postId=15200
    return "https://geeksempire.co/wp-json/wp/v2/posts/"
        "$postId";
  }

  String categoriesById(int categoryId) {

    // /#/MagazineCategories?postId=15200
    return "https://geeksempire.co/wp-json/wp/v2/categories/"
        "$categoryId";
  }

  String searchUrl(String categoryName) {

    return "https://geeksempire.co/?s=$categoryName";
  }

  String productCategoryUrl(String categorySlug) {

    return "https://geeksempire.co/products/$categorySlug";
  }

  String postCategoryUrl(String categorySlug) {

    return "https://geeksempire.co/category/$categorySlug";
  }

  String postsSearch(String searchQuery) {

    return "https://geeksempire.co/wp-json/wp/v2/search"
        "?search=$searchQuery"
        "&per_page=99&orderby=date&subtype=post";
  }

  String productsSearch(String searchQuery) {

    return "https://geeksempire.co/wp-json/wc/v3/products?consumer_key=ck_e469d717bd778da4fb9ec24881ee589d9b202662&consumer_secret=cs_ac53c1b36d1a85e36a362855d83af93f0d377686"
        "&search=$searchQuery"
        "&per_page=99&orderby=date&order=desc";
  }

}