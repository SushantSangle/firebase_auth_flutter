import 'package:firebase_auth_flutter/util/firebase_helper.dart';
import 'package:firebase_auth_flutter/util/models/data_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool gridMode = false;
  String currency = '₹';
  TextTheme textTheme;

  @override
  void initState() {
    DataModel.state = setState;
    DataModel.pullData();
    super.initState();
  }

  @override
  build(BuildContext context) {
    var gridViewDelegate = SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: gridMode ? 2 : 1,
      childAspectRatio: gridMode ? 1 : 2,
    );

    textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: DataModel.pullData,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView(
            physics: AlwaysScrollableScrollPhysics(),
            gridDelegate: gridViewDelegate,
            children: productsGenerator(context),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: switchMode,
        child: Icon(
          gridMode ? Icons.list : Icons.grid_view,
        ),
      ),
    );
  }

  List<Widget> productsGenerator(context) {
    List<Widget> children = [];
    DataModel.products?.forEach(
      (element) => children.add(gridChild(context,element)));
    return children;
  }

  void switchMode() {
    this.setState(() => gridMode = !gridMode);
  }

  gridChild(context, product) => Container(
    padding: EdgeInsets.all(10),
    child: GestureDetector(
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).canvasColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400],
              blurRadius: 10
            ),
          ],
        ),
        child: gridMode ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: entryDetailsList(product),
        ) : Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: entryDetailsList(product),
        ),
      ),
    ),
  );

  entryDetailsList(Product product) => [
    Expanded(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Hero(
          tag: product.id,
          child: Image(
            image: NetworkImage(product.imageUrl) ,
          ),
        ),
      ),
    ),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${product.price}$currency',
            style: textTheme.headline5.copyWith(
                color: Colors.blue
            ),
          ),
          Text(
            product.title,
            style: textTheme.bodyText1,
          )
        ],
      ),
    )
  ];
}