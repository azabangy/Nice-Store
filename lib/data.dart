import 'product_model.dart';

class Data {

  static int amount = 1;

  static List<ProductModel> generateProducts() {
    return [
      ProductModel(1, "assets/shoes_1.png", "Creter Impact", "Men's Shoes",
          "men shoes color white size [43, 44, 45, 46]", 105.56),
      ProductModel(2, "assets/shoes_2.png", "Air - Max Pre Day", "Men's Shoes",
          "men shoes color blue size [44, 45, 46]", 137.56),
      ProductModel(3, "assets/shoes_3.png", "Air Max 51", "Men's Shoes",
          "men shoes color black size [42, 46, 47]", 99.56),
      ProductModel(4, "assets/shoes_4.png", "EM Shoes", "Men's Shoes",
          "men shoes color grey size [43, 44, 45, 46, 47]", 212.56),
    ];
  }

  static List<ProductModel> generateCategories() {
    return [
      ProductModel(1, "assets/shoes_1.png", "Lifestyle", "Men's Shoes",
          "men shoes", 105.56),
      ProductModel(2, "assets/shoes_2.png", "Basketball", "Men's Shoes",
          "men shoes", 137.56),
      ProductModel(3, "assets/shoes_3.png", "Running", "Men's Shoes",
          "men shoes", 99.56),
      ProductModel(
          4, "assets/shoes_4.png", "Rugby", "Men's Shoes", "men shoes", 212.56),
    ];
  }

  static ProductModel generateProductId(int id) {
    List<ProductModel> products =[];
    products.addAll(generateProducts());
    return products[id];
  }
}
