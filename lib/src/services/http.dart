import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:life_bonder_entrance_test/src/models/search_response.dart';

class Http {
  final googleApiUrl = 'https://www.googleapis.com/customsearch/v1';
  final key = 'AIzaSyDXii4OHYi3i_Z8HKkFYSCc_X41gxXm2nM';
  final cx = '5cc0950c68fcbc55c';
  final headers = {'Content-Type': 'application/json'};
  final parameters = {
    'key': 'AIzaSyDXii4OHYi3i_Z8HKkFYSCc_X41gxXm2nM',
    'cx': '5cc0950c68fcbc55c',
  };

  Stream<List<SearchResponse>> makeSearchGetRequest(String searchText) async* {
    try {
      http.Response response = await http
          .get('$googleApiUrl?key=$key&cx=$cx&q=$searchText', headers: headers);
      Map<String, dynamic> map = json.decode(response.body);
      List<SearchResponse> result = List<SearchResponse>.from(json
          .decode(response.body)['items']
          .map((json) => SearchResponse.fromJson(json)));
      if (result.isNotEmpty) {
        yield result;
      } else {
        yield null;
      }
    } on Exception catch (e) {
      throw e;
    }
  }
}
