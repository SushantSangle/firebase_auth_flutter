import 'package:flutter/material.dart';
import 'package:firebase_auth_flutter/ui/LoadingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: App(),
    );
  }
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return LoadingPage();
  }
}
