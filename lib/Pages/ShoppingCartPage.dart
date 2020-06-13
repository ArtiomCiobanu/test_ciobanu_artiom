import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_ciobanu_artiom/Models/ProductInfo.dart';
import 'package:test_ciobanu_artiom/UI_Elements/ProductCard.dart';

class ShoppingCartPage extends StatefulWidget {
  final List<ProductInfo> products;

  ShoppingCartPage(this.products);

  @override
  State<StatefulWidget> createState() {
    return ShoppingCartPageState(products);
  }
}

class ShoppingCartPageState extends State<ShoppingCartPage> {
  List<ProductCard> favoriteProducts;

  Widget pageContent;

  ShoppingCartPageState(List<ProductInfo> products) {
    favoriteProducts = products
        .where((product) => product.addedToCart == true)
        .map((e) => ProductCard(e))
        .toList();

    pageContent = (favoriteProducts.length > 0)
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: favoriteProducts)
        : Container(
            margin: EdgeInsets.only(top: 150),
            child: Text(
              "You haven't chosen any products.",
              textAlign: TextAlign.center,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Shopping Cart"),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
            ),
            tooltip: "Show favorites",
            iconSize: 22,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: pageContent,
        ),
      ),
    );
  }
}
