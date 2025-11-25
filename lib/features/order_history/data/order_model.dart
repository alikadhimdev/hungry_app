import 'package:hungry_app/features/cart/data/cart_model.dart';
import 'package:hungry_app/features/home/data/product_model.dart';

class OrderModel {
  String payment;
  DeliveryAddressModel address;
  String notes;
  List<OrderItemModel> items;

  OrderModel({
    required this.payment,
    required this.address,
    required this.notes,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      payment: json["paymentMethod"],
      address: json["deliveryAddress"],
      notes: json["notes"],
      items: json["items"],
    );
  }
}

class DeliveryAddressModel {
  String street;
  String city;

  DeliveryAddressModel({required this.street, required this.city});

  factory DeliveryAddressModel.formJson(Map<String, dynamic> json) {
    return DeliveryAddressModel(city: json["city"], street: json["street"]);
  }
}

class OrderItemModel {
  String id;
  int qyt;
  double price;
  double spicy;
  List<String> toppings;
  List<String> sideOptions;
  String notes;
  List<ProductModel> products;

  OrderItemModel({
    required this.id,
    required this.qyt,
    required this.price,
    required this.spicy,
    required this.toppings,
    required this.sideOptions,
    required this.notes,
    required this.products,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    List<String> convertToList(dynamic v) {
      if (v == null) return [];
      if (v is List) return v.map((e) => e.toString()).toList();
      if (v is Map) return v.values.map((e) => e.toString()).toList();
      return [v.toString()];
    }

    return OrderItemModel(
      id: json["_id"],
      qyt: json["quantity"],
      price: json["price"],
      spicy: json["spicy"],
      toppings: convertToList(json["toppings"]),
      sideOptions: convertToList(json["sideOptions"]),
      notes: json["notes"],
      products: json["products"],
    );
  }
}
