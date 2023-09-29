class ProductModel {
  int id;
  String image;
  String title;
  String type;
  String description;
  double price;
  int? amount= 1;
  double? totalPrice =0;

  ProductModel(this.id, this.image, this.title, this.type, this.description,
      this.price, {this.amount, this.totalPrice});
}
