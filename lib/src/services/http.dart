import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:life_bonder_entrance_test/src/models/search_response.dart';

class Http {
  final googleApiUrl = 'https://www.googleapis.com/customsearch/v1';
  final key = ' AIzaSyDpfWK3bL0Qkfbo7MY5iXoAyzW_ESGfRjU';
  final cx = 'e543eb235b9fc8963';
  final headers = {'Content-Type': 'application/json'};
  final parameters = {
    'key': 'AIzaSyDXii4OHYi3i_Z8HKkFYSCc_X41gxXm2nM',
    'cx': '5cc0950c68fcbc55c',
  };

  Stream<List<SearchResponse>> makeSearchGetRequest(String searchText,int start) async* {
    try {
      http.Response response = await http
          .get('$googleApiUrl?key=$key&cx=$cx&q=$searchText&start=$start', headers: headers);
     // Map<String, dynamic> map = json.decode(response.body);
      if(json.decode(response.body)['items'] != null) {
        List<SearchResponse> result = List<SearchResponse>.from(
            json.decode(response.body)['items']
                .map((json) => SearchResponse.fromJson(json)));

      if (result.isNotEmpty) {
        yield result;
      } else {
        yield null;
      }
      }else {
        yield null;
      }
    } on Exception catch (e) {
      throw e;
    }
  }
}
