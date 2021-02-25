import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_flutter/util/firebase_helper.dart';

class UserModel {
  static String phone;
  static String address;
  static String company;
  static get user => FirebaseHelper.currentUser;
  static get displayName => user.displayName;
  static get email => user.email;

  static getCurrentUserDetails() async{
    if( phone == null && address == null && company == null){
      var snapshot = await FirebaseHelper.getCurrentUserDetails();
      if( snapshot == null )
        return;
      phone = snapshot['phone'];
      address = snapshot['address'];
      company = snapshot['company'];
      return;
    } else {
      print('confirmation check');
      FirebaseHelper.getCurrentUserDetails().then((snapshot) {
        if( snapshot == null )
          return;
        phone = snapshot['phone'];
        address = snapshot['address'];
        company = snapshot['company'];
        return;
      });
    }
  }
}