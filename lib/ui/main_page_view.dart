import 'package:firebase_auth_flutter/ui/details_page.dart';
import 'package:firebase_auth_flutter/ui/home_page.dart';
import 'package:firebase_auth_flutter/ui/lisense_view.dart';
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
  static const _availablePages = [
    'License',
    'Home',
    'Details',
  ];

  @override
  void initState() {
    _pageViewController = PageController(
      initialPage: _currentPage,
    );
    title = _availablePages[_currentPage];
    super.initState();
  }

  @override
  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_availablePages[_currentPage]),
      ),
      drawer: AppDrawer(),
      body: PageView(
        key: _pageViewKey,
        controller: _pageViewController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          LicenseView(),
          HomePage(),
          DetailsPage(),
        ],
        onPageChanged: (page) => this.setState(() => _currentPage = page ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        elevation: 50,
        backgroundColor: Colors.white60,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: (page) {
          print('page:$page');
          if( (page - _currentPage).abs() == 1)
            _pageViewController.animateToPage(page, duration: Duration(milliseconds: 500), curve: Curves.ease);
          else
            _pageViewController.jumpToPage(page);
          this.setState(() => _currentPage = page);
        }
      ),
    );
  }
}