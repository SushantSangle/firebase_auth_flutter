import 'package:flutter/material.dart';
import 'package:firebase_auth_flutter/ui/home_page.dart';
import 'package:firebase_auth_flutter/ui/details_page.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 1,
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
          flex : 5,
          child: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(5),
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
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
                      context,title:'Details',
                      icon:Icons.description,
                      pageConstructor: DetailsPage(),
                    ),
                    Divider(thickness: 2),
                  ],
                )
            ),
          )
      )
    ],
  );

  Widget drawerEntry(BuildContext context,{String title, IconData icon, pageConstructor}) =>
    TextButton(
        onPressed: () {
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
