import 'package:flutter/material.dart';
import 'package:firebase_auth_flutter/ui/LoadingPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
      FocusScopeNode node = FocusScope.of(context);
      if(!node.hasPrimaryFocus)
        FocusManager.instance.primaryFocus.unfocus();
    },
    child:MaterialApp(
      title: 'Flutter Firebase auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: App(),
    ),
    );
  }
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  LoadingPage();

  }
}
