import 'package:firebase_auth_flutter/ui/LoginPage.dart';
import 'package:firebase_auth_flutter/util/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_flutter/ui/home_page.dart';
import 'package:firebase_auth_flutter/ui/details_page.dart';
import 'package:firebase_auth_flutter/ui/lisense_view.dart';

class AppDrawer extends StatelessWidget {

  static const drawerMap = {
    'details' : 2,
    'home' : 1,
    'license' : 0,
  };

  AppDrawer([pageChangeFunction]);

  @override
  Widget build(BuildContext context) => Drawer(
    semanticLabel: 'Application Drawer',
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.blue[600],
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage('assets/user.png'),
                            radius: 30,
                          ),
                        ]
                    ),
                  ),
                  Text(
                    FirebaseHelper.currentUser.displayName ?? '',
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    FirebaseHelper.currentUser.email ?? '',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              )
          ),
        ),
        Expanded(
            flex : 12,
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      drawerEntry(
                        context,
                        title: 'Home',
                        icon: Icons.home,
                        pageConstructor:  HomePage(),
                      ),
                      drawerEntry(
                        context,
                        title: 'License',
                        icon: Icons.description,
                        pageConstructor: LicenseView(),
                      ),
                      drawerEntry(
                        context,title:'Personal info',
                        icon:Icons.person,
                        pageConstructor: DetailsPage(),
                      ),
                    ],
                  )
              ),
            )
        ),
      ],
    ),
  );


  Widget drawerEntry(BuildContext context,{String title, IconData icon, pageConstructor,onPressed}) =>
    TextButton(
        onPressed: onPressed ?? () {
        return Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => pageConstructor,
          ),
        );
      },
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Theme.of(context).textTheme.headline6.color,
              size: Theme.of(context).textTheme.headline6.height,
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ]
      ),
    );
}
