class ProductModel {
  dynamic id;
  String name;
  double price;
  String description;
  String url;
  bool isSelected;

  ProductModel({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.url,
    required this.isSelected,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map, {dynamic key}) {
    // Ensure price is a double, handling potential string values.
    double parsedPrice;
    try {
      parsedPrice = (map['price'] is double) ? map['price'] as double : double.parse(map['price'] as String);
    } on FormatException {
      parsedPrice = 0; // Or any default value you want.
    }
    return ProductModel(
      id: key ?? map["id"],
      name: map["name"],
      price: parsedPrice,
      description: map["description"],
      url: map["url"],
      isSelected: map["isSelected"],
    );
  }

  Map<String, dynamic> toMap({dynamic key}) {
    return {
      "id": key ?? id,
      "name": name,
      "price": price,
      "description": description,
      "url": url,
      "isSelected": isSelected,
    };
  }
}
