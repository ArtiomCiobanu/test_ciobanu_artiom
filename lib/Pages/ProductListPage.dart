import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_ciobanu_artiom/API/Singletones/HttpTools.dart';
import 'package:test_ciobanu_artiom/Models/ProductInfo.dart';
import 'package:test_ciobanu_artiom/Pages/FavoritesPage.dart';
import 'package:test_ciobanu_artiom/Pages/ShoppingCartPage.dart';
import 'package:test_ciobanu_artiom/UI_Elements/ProductCard.dart';

class ProductListPage extends StatefulWidget {
  ProductListPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProductListPageState();
}

class ProductListPageState extends State<ProductListPage> {
  List<ProductCard> productCards = new List<ProductCard>();
  List<ProductInfo> products = new List<ProductInfo>();

  int pageNumber = 0;
  int lastPageNumber = 2;

  ScrollController mainScrollController = ScrollController();

  bool onEndScroll(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollEndNotification) {
      var scrollPosition = mainScrollController.position;
      if (scrollPosition.pixels >= scrollPosition.maxScrollExtent - 40) {
        loadProducts();
      }
    }
    return true;
  }

  Future loadProducts() async {
    if (pageNumber < lastPageNumber) {
      try {
        var data = await HttpTools.getProductInfoAsync(pageNumber * 10, 10);
        data.forEach((value) {
          setState(() {
            var productInfo = ProductInfo.fromJson(value);
            products.add(productInfo);
            productCards.add(ProductCard(productInfo));
          });
        });

        pageNumber++;
      } catch (e) {
        if (e is SocketException) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Error"),
                    content: Text("An internet connection problem occured."),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          "Retry",
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          loadProducts();
                        },
                      )
                    ],
                  ));
          print("An internet connection problem occured");
        }
        print("An exception has been thrown: $e");
      }
    }
  }

  ProductListPageState() {
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Catalogue"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShoppingCartPage(products)));
            },
            tooltip: "Shopping cart",
            icon: Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavoritesPage(products)));
            },
            icon: Icon(
              Icons.favorite,
            ),
            tooltip: "Show favorites",
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) => onEndScroll(scrollNotification),
        child: SingleChildScrollView(
          controller: mainScrollController,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: productCards,
            ),
          ),
        ),
      ),
    );
  }
}
