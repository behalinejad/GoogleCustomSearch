import 'package:flutter/material.dart';
import 'package:life_bonder_entrance_test/src/custom_widgets/search_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchText = TextEditingController();

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
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 30, right: 20, left: 20, top: 30),
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
                      onPressed: () {},
                      icon: Icons.search,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
