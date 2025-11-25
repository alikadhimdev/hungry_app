class CartModel {
  String id;
  String totalPrice;
  List<CartItemModel>? items;
  CartModel({required this.id, required this.totalPrice, this.items});
  factory CartModel.fromJson(Map<String, dynamic> json) {
    final itemsList = json["items"] as List?;
    return CartModel(
      id: json["id"],
      totalPrice: json["total_price"],
      items: itemsList?.map((e) => CartItemModel.fromJson((e))).toList(),
    );
  }
}

class CartItemModel {
  String itemId;
  String productId;
  String name;
  String image;
  int qyt;
  String price;
  String spicy;
  List<String> toppings;
  List<String> sideOptions;
  String? notes;

  CartItemModel({
    required this.itemId,
    required this.productId,
    required this.name,
    required this.image,
    required this.qyt,
    required this.price,
    required this.spicy,
    required this.toppings,
    required this.sideOptions,
    this.notes,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    List<String> convertToList(dynamic v) {
      if (v == null) return [];
      if (v is List) {
        return v.map((e) {
          if (e is Map) {
            return e['id'].toString();
          }
          return e.toString();
        }).toList();
      }
      if (v is Map) return v.values.map((e) => e.toString()).toList();
      return [v.toString()];
    }

    return CartItemModel(
      itemId: json["item_id"],
      productId: json["product_id"],
      name: json["name"],
      image: json["image"] ?? "",
      qyt: json["quantity"] ?? 1,
      price: json["price"],
      spicy: json["spicy"],
      toppings: convertToList(json["toppings"]),
      sideOptions: convertToList(json["side_options"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "product_id": productId,
      "quantity": qyt,
      "spicy": spicy,
      "toppings": toppings,
      "side_options": sideOptions,
      "notes": notes,
    };
  }
}
