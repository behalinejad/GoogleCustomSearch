import 'package:flutter/material.dart';
import 'package:life_bonder_entrance_test/src/blocs/search_bloc.dart';
import 'package:life_bonder_entrance_test/src/custom_widgets/platform_alert_dialog.dart';
import 'package:life_bonder_entrance_test/src/custom_widgets/search_button.dart';
import 'package:life_bonder_entrance_test/src/custom_widgets/searched_item_list_tile.dart';
import 'package:life_bonder_entrance_test/src/models/search_response.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  // This Create Method is to ensure that HomePage should always be run under SearchBloc Provider package
  static Widget create(BuildContext context) {
    return Provider<SearchBloc>(
      builder: (_) => SearchBloc(),
      dispose: (context,bloc) => bloc.dispose(),
      child: HomePage(),
    );
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchText = TextEditingController();
  bool isSearching; // the controller for searching process
  List<SearchResponse> _currentSearchResponseList = List<SearchResponse>();
  int _currentSearchResponseRow = 1;
  SearchBloc searchBloc = SearchBloc();

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
    final bloc = Provider.of<SearchBloc>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Google Custom Search'),
      ),
      body: StreamBuilder(
        stream: bloc.isSearchingStream,
        initialData: false,
        builder: (context, snapshot) {
          return _buildHomeBody(context); //Body of the Scaffold for State Management using Bloc
        },
      ),
    );
  }

  Widget _buildListView(List<SearchResponse> searchResponseList) {
    final bloc = Provider.of<SearchBloc>(context);
    try {
      return NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (!isSearching &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            // start loading data again

            _currentSearchResponseRow += 10;
            isSearching = true;
            bloc.setIsSearching(isSearching);
            _streamBuilder();
          }
          return true;
        },
        child: Expanded(
          child: Column(
            children: [
              _currentSearchResponseList.length > 0
                  ? Text(
                'Search Results Counts : ${_currentSearchResponseList.length} ',
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: Colors.indigo),
              )
                  : Container(),
              // The Text is used to Show record Counts while Pagination happens
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: searchResponseList.length,
                  itemBuilder: (context, index) {
                    return SearchedItemListTile(
                        searchResponse: searchResponseList[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } on Exception catch (e) {
      PlatformAlertDialog(
        title: 'Error in search',
        content: 'oops . Something went Wrong',
        defaultActionText: ' Ok ',
      ).show(context);
      return Text('You need to try again');
    }
  }

  Widget _streamBuilder() {
    try {
      return StreamBuilder(
          stream: searchBloc.getSearchResult(
              _searchText.text, _currentSearchResponseRow),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              isSearching = false;
              if (snapshot.connectionState == ConnectionState.done) {
                // Check The Stream tunnel for unwanted data
                _currentSearchResponseList.addAll(snapshot.data);

              }

              if (snapshot.data.isNotEmpty) {
                return _buildListView(_currentSearchResponseList);
              }

              else {
                if (snapshot.data.isEmpty &&
                    _currentSearchResponseList.length > 0)
                  return _buildListView(_currentSearchResponseList);
                else {
                  return Center(
                    child: Text('Ohh . I\'m sorry . No result found '),
                  );
                }
              }
            } else if (snapshot.hasError) {
              isSearching = false;
              // Check if search not found or response items reached to its end ;
              return _currentSearchResponseRow < 2
                  ? Center(
                      child: Text('Ohh . I\'m sorry . No result found '),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _currentSearchResponseList.length,
                        itemBuilder: (context, index) {
                          return SearchedItemListTile(
                              searchResponse:
                                  _currentSearchResponseList[index]);
                        },
                      ),
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
    } on Exception catch (e) {
      PlatformAlertDialog(
        title: 'Error in search',
        content: 'oops . Something went Wrong',
        defaultActionText: ' Ok ',
      ).show(context);

    }
  }

  Widget _buildHomeBody(BuildContext context) {
    final bloc = Provider.of<SearchBloc>(context);
    return Container(
        //Container for SearchTextField And SearchButton
        child: Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(bottom: 10, right: 20, left: 20, top: 30),
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
                    bloc.setIsSearching(isSearching);
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
    ));
  }
}
