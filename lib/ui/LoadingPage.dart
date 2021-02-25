import 'package:firebase_auth_flutter/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'package:firebase_auth_flutter/util/firebase_helper.dart';

import 'main_page_view.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: FirebaseHelper.appFuture,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print(snapshot.toString());
          return actualLoader(context, false);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return actualLoader(context,true);
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget actualLoader(BuildContext context, bool connectionState){
    return StreamBuilder(
        stream: FirebaseHelper.userChanges,
        builder: (context,snapshot) {
          if(snapshot.hasError){
            return LoginPage(false);
          }else{
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              case ConnectionState.none:
              case ConnectionState.done:
              case ConnectionState.active:
                if(snapshot.data == null){
                  return LoginPage(connectionState);
                }else{
                  return MainPageView();
                }
                break;
            }
          }
          return null;
        }
    );
  }
}