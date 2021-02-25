import 'package:firebase_auth_flutter/common_components/application_drawer.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LicenseView extends StatelessWidget{
  LicenseView({Key key}): super(key: key);

  @override
  build(BuildContext context) {
    return Scaffold(
      body: body(context, null, null),
    );
  }
  body(context, height, width) => Container(
      child: WebView(
        initialUrl: 'https://mit-license.org/',
      )
  );
}