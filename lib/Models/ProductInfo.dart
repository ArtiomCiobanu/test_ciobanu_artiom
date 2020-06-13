class ProductInfo {
  final int id;
  final String title;
  final String shortDescription;
  final String image;
  final int price;
  final int salePrecent;
  final String details;

  bool isFavorite = false;
  bool addedToCart = false;

  int finalPrice = 0;

  ProductInfo(
      {this.id = 0,
      this.title = "",
      this.shortDescription = "",
      this.image = "",
      this.price = 0,
      this.salePrecent = 1,
      this.details = ""}) {
    if (salePrecent == 0) {
      finalPrice = price;
    } else {
      var sale = salePrecent / 100;
      var p = price * sale;
      finalPrice = price - p.truncate();
    }
  }

  static ProductInfo fromJson(Map data) {
    return ProductInfo(
      id: data['id'],
      title: data['title'],
      shortDescription: data['short_description'],
      image: data['image'],
      price: data['price'],
      salePrecent: data['sale_precent'],
      details: data['details'],
    );
  }
}
