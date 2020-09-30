import 'package:life_bonder_entrance_test/src/models/search_response.dart';
import 'package:life_bonder_entrance_test/src/services/http.dart';

class SearchBloc {

  static Stream<List<SearchResponse>> getSearchResult(String searchText) {
    try {
      Http http = Http();
      return http.makeSearchGetRequest(searchText);
    } on Exception catch (e) {
      throw e;
    }
  }



}
