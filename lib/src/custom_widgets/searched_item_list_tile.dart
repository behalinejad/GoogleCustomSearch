import 'package:flutter/material.dart';
import 'package:life_bonder_entrance_test/src/models/search_response.dart';

class SearchedItemListTile extends StatelessWidget {
  const SearchedItemListTile({Key key, @required this.searchResponse}) : super(key: key);
  final SearchResponse searchResponse;



  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.arrow_forward_ios),
        title: Text(searchResponse.title.toString()),
      ),
    );
  }
}
