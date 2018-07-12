import 'package:flutter/material.dart';
import './pages/LoginPage.dart';
import 'package:fluro/fluro.dart';
import './pages/AnimationTest.dart';

void main() {

  String _title1='page One';
 String _title2='page Two';
  String _title3='page Three';
  runApp(new MaterialApp(
    home: new LoginPage(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/a': (BuildContext context) => new AnimatedListSample("$_title1"),
      '/b': (BuildContext context) => new AnimatedListSample("$_title2"),
      '/c': (BuildContext context) => new AnimatedListSample("$_title3"),
    },
  ));
}