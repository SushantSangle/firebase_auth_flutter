import 'package:firebase_auth_flutter/util/loading_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      child: ChangeNotifierProvider<LoadingNotifier>(
        create: (context) => LoadingNotifier(),
        child: Consumer<LoadingNotifier>(
          builder: (context,notifier,child) => Stack(
            children: [
               WebView(
                initialUrl: 'https://mit-license.org/',
                 onWebViewCreated: (controller) {
                  notifier.loadingState = true;
                  notifier.notifyListeners();
                 },
                 onPageFinished: (str) {
                  notifier.loadingState = false;
                  notifier.notifyListeners();
                 },
              ),
              notifier.loadingState ? Center(
                child: CircularProgressIndicator(
                  backgroundColor : Colors.white,
                )
              ) : Container(),
            ],
          ),
        ),
      )
  );
}