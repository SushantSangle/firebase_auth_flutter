import 'package:firebase_auth_flutter/util/firebase_helper.dart';
import 'package:flutter/material.dart';

class DataModel {
  static List<Product> products = [];
  static Function _setState;
  static set state(setState) {
    _setState = setState;
  }
  static Future<void> pullData() async{
    products = await FirebaseHelper.getAllProducts();
    _setState(() => null);
    return;
  }
}

class Product {
  String id;
  String title;
  String imageUrl;
  String price;
  String description;
  Product({
    this.id,
    this.imageUrl,
    this.title,
    this.description,
    this.price,
  });
}

