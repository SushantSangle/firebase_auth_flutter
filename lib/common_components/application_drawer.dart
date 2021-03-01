import 'package:firebase_auth_flutter/ui/LoginPage.dart';
import 'package:firebase_auth_flutter/util/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_flutter/ui/pages/home_page.dart';
import 'package:firebase_auth_flutter/ui/pages/details_page.dart';
import 'package:firebase_auth_flutter/ui/pages/license_view.dart';

class AppDrawer extends StatelessWidget {

  static const drawerMap = {
    'Details' : 2,
    'Home' : 1,
    'License' : 0,
  };
  Function pageChangeFunction;
  String currentPage;
  AppDrawer([this.pageChangeFunction,this.currentPage]);

  @override
  Widget build(BuildContext context) {
    print('page from drawer: $currentPage');
    return Drawer(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(20,20,5,5),
                      child: Text(
                        'Locations',
                        style: Theme.of(context).textTheme.headline6.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
                      context,title:'Details',
                      icon:Icons.person,
                      pageConstructor: DetailsPage(),
                    ),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }


  Widget drawerEntry(BuildContext context,{String title, IconData icon, pageConstructor,onPressed}) {
    bool selected = (title == currentPage);
    var textStyle = Theme.of(context).textTheme.headline6
        .copyWith(fontWeight: FontWeight.normal);
    if(selected){
      textStyle = textStyle.copyWith(color: Colors.blue);
    }
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: TextButton(
        onPressed: pageChangeFunction != null ?
            () {
          pageChangeFunction(drawerMap[title]);
          Navigator.of(context).pop();
        } : onPressed ?? () {
          return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => pageConstructor,
            ),
          );
        },
        style: ButtonStyle(
          backgroundColor:
          MaterialStateProperty.all(
              selected ? Colors.blue[100] : Theme
                  .of(context)
                  .canvasColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(right: Radius.circular(50
                )
              )
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: textStyle.color,
                  size: textStyle.height,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text(
                    title,
                    style: textStyle,
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
