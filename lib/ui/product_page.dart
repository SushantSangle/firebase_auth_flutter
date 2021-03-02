import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth_flutter/util/models/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {

  Product product;
  String currency = '₹';
  ProductPage([Product product]) { this.product = product; }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(product?.title ?? 'Product Description'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: product.id,
                child: Image(
                  height: MediaQuery.of(context).size.height * 0.4,
                  image: CachedNetworkImageProvider(product.imageUrl),
                  fit: BoxFit.contain,
                ),
              ),
              Divider(),
              Hero(
                tag: '${product.id}details',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: textTheme.headline4,
                    ),
                    Text(
                      '${product.price}$currency\n',
                      style: textTheme.headline5.copyWith(color : Colors.blue)
                    )
                  ],
                ),
              ),
              Text(
                'Description:',
                style: textTheme.headline5.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                product.description,
                style: textTheme.bodyText2,
              )
            ],
          ),
        ),
      ),
    );
  }
}