import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:life_bonder_entrance_test/src/models/search_response.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchedItemListTile extends StatelessWidget {
  const SearchedItemListTile({Key key, @required this.searchResponse}) : super(key: key);
  final SearchResponse searchResponse;



  @override
  Widget build(BuildContext context) {
    try {
      return Card(
        child: ListTile(
          leading: Icon(Icons.arrow_forward_ios),
          title: Text(searchResponse.title.toString(),style: TextStyle(fontWeight: FontWeight.w700),),
          subtitle:RichText(
            text: TextSpan(
              children:
              [
               // to access the Website of the each search results .
                TextSpan(
                  text: searchResponse.link,
                  style:  TextStyle(color: Colors.blue,fontSize: 12),
                  recognizer:  TapGestureRecognizer()
                    ..onTap = () { _launchURL(searchResponse.link);
                    },
                ),
              ],
            ),
          ), //Text(searchResponse.link.toString()),
        ),
      );
    } on Exception catch (e) {
      rethrow;
    }
  }

  _launchURL(String url)  async {

    try {
      if (await canLaunch(url)) {
        await launch(url,
          forceSafariVC: true,
        );
      }
    } on Exception catch (e) {
      throw e;
    }
  }
}
