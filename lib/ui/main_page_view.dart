import 'package:firebase_auth_flutter/ui/pages/details_page.dart';
import 'package:firebase_auth_flutter/ui/pages/home_page.dart';
import 'package:firebase_auth_flutter/ui/pages/license_view.dart';
import 'package:firebase_auth_flutter/util/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth_flutter/common_components/application_drawer.dart';

class MainPageView extends StatefulWidget {
  @override
  createState() => _MainPageViewState();
}

class _MainPageViewState extends State<MainPageView> {

  String title;
  GlobalKey _pageViewKey = GlobalKey();
  PageController _pageViewController;
  int _currentPage = 1;
  static const _availablePages = {
    0 : 'License',
    1 : 'Home',
    2 : 'Details',
  };

  @override
  void initState() {
    _pageViewController = PageController(
      keepPage: false,
      initialPage: _currentPage,
    );
    title = _availablePages[_currentPage];
    super.initState();
    UserModel.init();
  }

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_availablePages[_currentPage]),
        elevation: 0,
      ),
      drawer: AppDrawer(goToPage,_availablePages[_currentPage]),
      body: PageView(
        physics: AlwaysScrollableScrollPhysics(),
        key: _pageViewKey,
        controller: _pageViewController,
        children: [
          LicenseView(),
          HomePage(),
          DetailsPage(),
        ],
        onPageChanged: (page) => this.setState(() => _currentPage = page ),
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400],
              offset: Offset(0, 0),
              blurRadius: 5,
            )
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentPage,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.description),
              label: 'License'
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Details',
            )
          ],
          elevation: 1000,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue[800],
          unselectedItemColor: Colors.grey[500],
          onTap: goToPage,
        ),
      ),
    );
  }
  void goToPage(int page) {
    print('page:$page');
    if( (page - _currentPage).abs() == 1)
      _pageViewController.animateToPage(page, duration: Duration(milliseconds: 500), curve: Curves.ease);
    else
      _pageViewController.jumpToPage(page);
    this.setState(() => _currentPage = page);
  }
}