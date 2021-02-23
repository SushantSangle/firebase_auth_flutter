import 'package:firebase_auth_flutter/common_components/application_drawer.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LicenseView extends StatelessWidget{
  LicenseView({Key key}): super(key: key);

  @override
  build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('License'),
      ),
      body: Container(
        child: WebView(
          initialUrl: 'https://mit-license.org/',
        )
      ),
    );
  }
}