import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:life_bonder_entrance_test/src/models/search_response.dart';

class Http {
  final googleApiUrl = 'https://www.googleapis.com/customsearch/v1';
  final key = 'AIzaSyDpfWK3bL0Qkfbo7MY5iXoAyzW_ESGfRjU'; //The Key for Google Custom Search request
  final cx = 'e543eb235b9fc8963';//The cx for Google Custom Search request
  final headers = {'Content-Type': 'application/json'};


  Stream<List<SearchResponse>> makeSearchGetRequest(
      String searchText, int start) async* {
    try {
      List<SearchResponse> emptySearchResponseList = List<
          SearchResponse>(); // to send an empty list while reaching to the end of the search

      http.Response response = await http.get(
          '$googleApiUrl?key=$key&cx=$cx&q=$searchText&start=$start',
          headers: headers);
      Map<String, dynamic> map = json.decode(response.body);
      if (map != null) {
        if (map['items'] != null) {
          List<SearchResponse> result = List<SearchResponse>.from(json
              .decode(response.body)['items'] // Items Contains Search Results
              .map((json) => SearchResponse.fromJson(json)));

          if (result.isNotEmpty) {
            yield result;
          } else {
            yield null;
          }
        } else {
          yield emptySearchResponseList; // The search has reached to the end or limitation GoogleApi for the Number Of Searches
        }
      } else {
        yield emptySearchResponseList;
      }
    } on Exception catch (e) {
      throw e;
    }
  }
}
