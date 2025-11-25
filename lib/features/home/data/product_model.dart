class ProductModel {
  String name;
  String des;
  int rate;
  int price;
  String? image;
  CreatorModel creator;
  String id;

  ProductModel({
    required this.name,
    required this.des,
    required this.rate,
    required this.price,
    this.image,
    required this.creator,
    required this.id,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json["name"],
      des: json["description"],
      rate: json["rating"],
      price: json["price"],
      image: json["image"],
      creator: CreatorModel.fromJson(json["creator"]),
    );
  }
}

class CreatorModel {
  String name;
  String id;
  String email;

  CreatorModel({required this.name, required this.id, required this.email});

  factory CreatorModel.fromJson(Map<String, dynamic> json) {
    return CreatorModel(
      email: json["email"],
      id: json["id"],
      name: json["name"],
    );
  }
}
