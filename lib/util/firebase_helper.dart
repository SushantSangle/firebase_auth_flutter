import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class _ConnectionHelper {
  static Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }
    } catch (Exception) {
      return false;
    }
  }
}

class FirebaseHelper {
  static final Future<FirebaseApp>  _initialize = Firebase.initializeApp();
  static FirebaseApp _app;
  static UserCredential _credential;

  static get userChanges{
    return FirebaseAuth.instance.userChanges();
  }

  static User get currentUser{
    return FirebaseAuth.instance.currentUser;
  }

  static get appFuture{
    return _initialize;
  }
  static Future signIn({String email, String password}) async {
    _credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return;
  }

  static signOut() async{
    return FirebaseAuth.instance.signOut();
  }

  static signUp({String displayName, String email, String password, String phoneNo,String address, String company}) async{
    try{
      var userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      var currentUser = userCredential.user;
      addUserDetails(phoneNo,address,company,displayName,currentUser);
      _credential = userCredential;
      return _credential;
    }catch(e){
      throw e;
    }
  }

  static Future addUserDetails(String phoneNo,String address, String company,String displayName,User user) async{
    CollectionReference userInfo = FirebaseFirestore.instance.collection('userInfo');
    await currentUser.updateProfile(displayName: displayName ?? '');
    await userInfo.doc(user.uid).set({
        "phone" : phoneNo ?? '',
        "address" : address ?? '',
        "company" : company ?? '',
      },
    );
  }

  static Future getCurrentUserDetails() async{
    try{
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.
      collection('userInfo').doc(FirebaseAuth.instance.currentUser.uid).get();
      print(snapshot.data().toString());
      return snapshot.data()..addAll(
        {
          'displayName' : FirebaseAuth.instance.currentUser.displayName,
          'email' : FirebaseAuth.instance.currentUser.email,
        }
      );
    }catch(e){
      print(e);
    }
  }

}