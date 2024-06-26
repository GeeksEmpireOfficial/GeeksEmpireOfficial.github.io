class SearchFilter {

  final _uselessWords = "sex,fuck,blowjob,cum";

  final _keywordsMap = {
    'lego': 'brick',
    'security': 'vpn',
  };

  Future<String> prepareSearchQuery(String searchQuery) async {

    String preparedSearchQuery = searchQuery.replaceAll(".", " ");
    preparedSearchQuery = searchQuery.replaceAll("-", " ");
    preparedSearchQuery = searchQuery.replaceAll("_", " ");
    preparedSearchQuery = searchQuery.replaceAll("?", " ");
    preparedSearchQuery = searchQuery.replaceAll("!", " ");

    return preparedSearchQuery;
  }

  Future<bool> searchQueryFilter(String searchQuery) async {

    bool allowQuery = false;

    allowQuery = (searchQuery.length >= 3);

    allowQuery = !(searchQuery.contains("\\"));
    allowQuery = !(searchQuery.contains("/"));
    allowQuery = !(searchQuery.contains("/"));
    allowQuery = !(searchQuery.contains(_uselessWords));

    return allowQuery;
  }

}