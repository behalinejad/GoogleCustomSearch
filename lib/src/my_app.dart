import 'package:flutter/material.dart';
import 'package:life_bonder_entrance_test/src/ui/home_page.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Life Bonder Entrance Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //Moving to Home Page which is Google Custom Search Service
      home: HomePage.create(context),
    );
  }
}
