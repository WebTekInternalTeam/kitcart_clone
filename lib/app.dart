import 'package:flutter/material.dart';
import 'package:kitcart/web_view.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //Change link here
      home: WebViewContainer('', ''),
    );
  }
}