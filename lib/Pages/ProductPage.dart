import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_ciobanu_artiom/Models/ProductInfo.dart';
import 'package:test_ciobanu_artiom/Models/ProductDBNote.dart';
import 'package:test_ciobanu_artiom/API/Singletones/DatabaseTools.dart';

class ProductPage extends StatefulWidget {
  final ProductInfo productInfo;
  final String priceText;
  final String oldPriceText;

  ProductPage(this.productInfo, this.priceText, this.oldPriceText, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      ProductPageState(productInfo, priceText, oldPriceText);
}

class ProductPageState extends State<ProductPage> {
  final ProductInfo productInfo;
  final String priceText;
  final String oldPriceText;

  Color getFavoriteIconColor() {
    if (productInfo.isFavorite) {
      return Colors.pink;
    } else {
      return Colors.black;
    }
  }

  String getNormalizedDetailsText() {
    String text = "";
    var detailsLines = productInfo.details.split("\\n");

    detailsLines.forEach((element) {
      text += "${element.trim()}\n";
    });

    return text;
  }

  void saveProductToDatabase() async {
    int res;
    var product = ProductDBNote.fromProductInfo(productInfo);
    try {
      res = await DatabaseTools.insertProductDBNote(product);
    } catch (e) {
      res = await DatabaseTools.updateProductDBNote(product);
    }

    print(res);
  }

  ProductPageState(this.productInfo, this.priceText, this.oldPriceText);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Product Page"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 40.0, bottom: 30.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.width * 0.8,
                        child: productInfo.productImage,
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 30, bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 76),
                                  child: Text(
                                    productInfo.title,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent[400]),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      productInfo.isFavorite =
                                          !productInfo.isFavorite;
                                      saveProductToDatabase();
                                    });
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: getFavoriteIconColor(),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(bottom: 5.0, left: 15.0),
                        child: Text(
                          productInfo.shortDescription,
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            priceText,
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.blue),
                          ),
                          Text(
                            oldPriceText,
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 27.0),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.black12,
                        thickness: 1,
                        height: 30.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 17.0, right: 35.0),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "INFORMATION",
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  getNormalizedDetailsText(),
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5, top: 5, left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 2.5),
                    child: ButtonTheme(
                      height: 45,
                      child: RaisedButton(
                        child: Text(
                          "ADD TO CART",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        color: Color.fromARGB(255, 49, 27, 146),
                        onPressed: () {
                          productInfo.addedToCart = true;
                          saveProductToDatabase();
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 2.5),
                  child: ButtonTheme(
                    height: 45,
                    child: RaisedButton(
                      child: Text(
                        "BUY NOW",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      color: Color.fromARGB(255, 106, 27, 154),
                      onPressed: () {
                      },
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
