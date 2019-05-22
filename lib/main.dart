import 'package:flutter/material.dart';
import 'package:ureca_restaurant_reviews_flutter/pages/home-page.dart';
import 'package:ureca_restaurant_reviews_flutter/util/routes.dart';

void main() {
  runApp(
    MaterialApp(
        home: HomePage(),
        routes: Routes.routes,
        theme: ThemeData(
          // Define the default Brightness and Colors
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],

          // Define the default Font Family
          fontFamily: 'Montserrat',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        )),
  );
}
