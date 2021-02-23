import 'package:firebase_auth_flutter/ui/LoginPage.dart';
import 'package:firebase_auth_flutter/util/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_flutter/ui/home_page.dart';
import 'package:firebase_auth_flutter/ui/details_page.dart';
import 'package:firebase_auth_flutter/ui/lisense_view.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Drawer(
    semanticLabel: 'Application Drawer',
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.blue[600],
              alignment: Alignment.bottomLeft,
              child: Text(
                'Firebase X Flutter',
                style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.white,
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.bold,
                ),
              )
          ),
        ),
        Expanded(
            flex : 12,
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.white,
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
                      Divider(thickness: 2),
                      drawerEntry(
                        context,
                        title: 'License',
                        icon: Icons.description,
                        pageConstructor: LicenseView(),
                      ),
                      Divider(thickness: 2),
                      drawerEntry(
                        context,title:'Personal info',
                        icon:Icons.person,
                        pageConstructor: DetailsPage(),
                      ),
                      Divider(thickness: 2),
                    ],
                  )
              ),
            )
        ),
        Divider(height: 2),
        Container(
          child: drawerEntry(
            context,
            title: 'Logout',
            icon: Icons.logout,
            onPressed: () async {
              await FirebaseHelper.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(true),
                ),
              );

            }
          ),
        )
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
            Icon(icon),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ]
      ),
    );

}
