import 'package:carshop/src/models/category.dart';

class Vehicle {
  int id;
  String photoUrl;
  double price;
  int used;
  String model;
  int createAt;
  String categoryEncode;
  String categoryId;

  Vehicle(
      {this.id,
      this.photoUrl,
      this.price,
      this.used,
      this.model,
      this.createAt,
      this.categoryId});

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        photoUrl: json["photoUrl"],
        price: json["price"],
        used: json["used"],
        model: json["model"],
        createAt: json["createAt"],
        categoryId: json["categoryId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "photoUrl": photoUrl,
        "price": price,
        "used": used,
        "model": model,
        "createAt": createAt,
        "categoryId": categoryId,
      };
}
