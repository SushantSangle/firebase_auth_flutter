import 'package:firebase_auth_flutter/util/firebase_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin UserModel  {
  static String phone;
  static String address;
  static String company;
  static get user => FirebaseHelper.currentUser;
  static get displayName => user.displayName;
  static get email => user.email;
  static SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
    getCurrentUserDetails();
  }

  static getCurrentUserDetails() async{
    if( phone == null && address == null && company == null){
      var snapshot = await FirebaseHelper.getCurrentUserDetails();
      if( snapshot == null ){
        await prefs.reload();
        getUserFromSharedPrefs();
      }
      phone = snapshot['phone'];
      address = snapshot['address'];
      company = snapshot['company'];
      saveUser();
      return;
    } else {
      print('confirmation check');
      FirebaseHelper.getCurrentUserDetails().then((snapshot) {
        if( snapshot == null )
          return;
        phone = snapshot['phone'];
        address = snapshot['address'];
        company = snapshot['company'];
        saveUser();
        return;
      });
    }
  }
  static getUserFromSharedPrefs() {
    if(prefs != null){
      phone = prefs.containsKey('phone') ? prefs.get('phone') : '';
      company = prefs.containsKey('company') ? prefs.get('company') : '';
      address = prefs.containsKey('address') ? prefs.get('address') : '';
    }
  }
  static removeUser() async {
    prefs.remove('phone');
    prefs.remove('company');
    prefs.remove('address');
  }
  static saveUser() async {
    prefs.setString('phone', phone ?? '');
    prefs.setString('company', company ?? '');
    prefs.setString('address', address ?? '');
  }
}