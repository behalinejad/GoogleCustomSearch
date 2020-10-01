import 'dart:async';
import 'package:life_bonder_entrance_test/src/models/search_response.dart';
import 'package:life_bonder_entrance_test/src/services/http.dart';

class SearchBloc {

  final StreamController<bool> _isSearchingController =StreamController<bool>();
  Stream<bool> get isSearchingStream => _isSearchingController.stream;

  void dispose (){
    _isSearchingController.close();
  }
 void setIsSearching (bool isSearching) => _isSearchingController.add(isSearching);


  Stream<List<SearchResponse>> getSearchResult(String searchText,int start) {
    //Start is a int that Shows the item Number to start loading in googleCustomSearchApi and use for pagination
    try {
      Http http = Http();
      return http.makeSearchGetRequest(searchText,start);
    } on Exception catch (e) {
      throw e;
    }
  }
}
