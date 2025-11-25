class ToppingsModel {
  String id;
  String name;
  int price;
  String? image;

  ToppingsModel({
    required this.id,
    required this.name,
    required this.price,
    this.image,
  });

  factory ToppingsModel.fromJson(Map<String, dynamic> json) {
    return ToppingsModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
    );
  }
}

class SideOptionsModel {
  String name;
  String id;
  int price;
  String? image;

  SideOptionsModel({
    required this.name,
    required this.id,
    required this.price,
    this.image,
  });

  factory SideOptionsModel.fromJson(Map<String, dynamic> json) {
    return SideOptionsModel(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      image: json["image"],
    );
  }
}
