import 'package:flutter/material.dart';
import 'package:life_bonder_entrance_test/src/blocs/search_bloc.dart';
import 'package:life_bonder_entrance_test/src/custom_widgets/platform_alert_dialog.dart';
import 'package:life_bonder_entrance_test/src/custom_widgets/search_button.dart';
import 'package:life_bonder_entrance_test/src/custom_widgets/searched_item_list_tile.dart';
import 'package:life_bonder_entrance_test/src/models/search_response.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchText = TextEditingController();
  bool isSearching;
  List<SearchResponse> _currentSearchResponseList = List<SearchResponse>();
  int _currentSearchResponseRow = 1;

  @override
  void initState() {
    isSearching = false;
    super.initState();
  }

  @override
  void dispose() {
    _searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Google custom search'),
      ),
      body: Container(
          //Container for SearchTextField And SearchButton
          child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(bottom: 30, right: 20, left: 20, top: 30),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    width: 1,
                    color: Colors.blueGrey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10, top: 5, left: 5, right: 5),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'I\'m here to search .Lets go',
                          icon: Image.asset(
                            "lib/assets/google.png",
                            fit: BoxFit.cover,
                            width: 30,
                            height: 30,
                          ),
                        ),
                        controller: _searchText,
                        minLines: 1,
                        maxLines: 10,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CustomButton(
                    onPressed: () {
                      // Search button has pushed  and the StreamBuilder for listView are going to be called
                      _currentSearchResponseList.clear();
                      _currentSearchResponseRow = 1; // reset controller for  search page and pagination
                      isSearching = true;
                      setState(() {

                      });
                      /*if (_searchText.text != null) if (_searchText.text.trim().length > 0) {
                        // Search button has pushed  and the StreamBuilder for listView are going to be called

                        setState(() {

                        });
                      }*/
                    },
                    icon: Icons.search,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          !isSearching ? Container() : _streamBuilder(),
        ],
      )),
    );
  }

  Widget _buildListView(List<SearchResponse> searchResponseList) {
    try {
      return NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (!isSearching && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            // start loading data again

            _currentSearchResponseRow += 10;
            setState(() {
              isSearching = true;
            });

            _streamBuilder();
          }
          return true;
        },
        child: Expanded(
          child: ListView.builder(
            itemCount: searchResponseList.length,
            itemBuilder: (context, index) {
              return SearchedItemListTile(
                  searchResponse: searchResponseList[index]);
            },
          ),
        ),
      );
    } on Exception catch (e) {
      PlatformAlertDialog(
        title: 'error in search',
        content: 'oops . Somthing went Wrong',
        defaultActionText: ' Ok ',
      ).show(context);
    }
  }

  Widget _streamBuilder() {
    return StreamBuilder(
        stream: SearchBloc.getSearchResult(
            _searchText.text, _currentSearchResponseRow),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            isSearching = false;
            if (snapshot.connectionState == ConnectionState.done) { // Check The Stream tunnel for unwanted data
              _currentSearchResponseList.addAll(snapshot.data);
            }
              return _buildListView(_currentSearchResponseList);


          } else if (snapshot.hasError) {
            isSearching = false;
            return Center(
              child: Text('Ohh . I\'m sorry . No result found '),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlue,
                strokeWidth: 5,
              ),
            );
          }
        });
  }


}
