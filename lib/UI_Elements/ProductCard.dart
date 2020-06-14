import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_ciobanu_artiom/Models/ProductInfo.dart';
import 'package:test_ciobanu_artiom/Pages/ProductPage.dart';

class ProductCard extends StatefulWidget {
  final ProductInfo productInfo;
  ProductCard(this.productInfo);

  @override
  State<StatefulWidget> createState() => ProductCardState(productInfo);
}

class ProductCardState extends State<ProductCard> {
  final ProductInfo productInfo;

  String priceText = "";
  String oldPriceText = "";

  Image productImage;

  ProductCardState(this.productInfo) {
    if (productInfo.finalPrice < productInfo.price) {
      priceText = "\$${productInfo.finalPrice.toString()}, - ";
      oldPriceText = "\$${productInfo.price.toString()}";
    } else {
      priceText = "\$${productInfo.price.toString()}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.white,
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductPage(productInfo, priceText, oldPriceText)));
      },
      child: Center(
        child: new Container(
          margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                child: productInfo.productImage
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  productInfo.title,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent[400]),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5.0),
                child: Text(productInfo.shortDescription),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    priceText,
                    style: TextStyle(fontSize: 21.0, color: Colors.blue),
                  ),
                  Text(
                    oldPriceText,
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough, fontSize: 17.0),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
