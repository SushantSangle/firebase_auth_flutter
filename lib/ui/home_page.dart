import 'package:flutter/material.dart';
import 'package:firebase_auth_flutter/common_components/application_drawer.dart';

class HomePage extends StatelessWidget {
  HomePage(): super();

  @override
  build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        semanticLabel: 'App Drawer',
        child: AppDrawer(),
      ),
      appBar: AppBar(
        title: Text('Home page'),
        elevation: 0,
      ),
    );
  }

}