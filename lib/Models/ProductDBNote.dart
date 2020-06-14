import 'package:test_ciobanu_artiom/Models/ProductInfo.dart';

class ProductDBNote {
  final int id;
  final bool isFavorite;
  final bool isAddedToCart;

  ProductDBNote(this.id, this.isFavorite, this.isAddedToCart);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isFavorite': isFavorite,
      'isAddedToCart': isAddedToCart,
    };
  }

  static ProductDBNote fromProductInfo(ProductInfo info) {
    return ProductDBNote(info.id, info.isFavorite, info.addedToCart);
  }
}
