import 'package:carshop/src/models/category.dart';

class Vehicle {
  int id;
  String photoUrl;
  int occupants;
  double price;
  int used;
  String model;
  int createAt;
  String categoryId;
  String extra;
  String extraValue;
  Category category;

  Vehicle(
      {this.id,
      this.photoUrl,
      this.occupants = 0,
      this.price = 0.0,
      this.used = 0,
      this.model = '',
      this.createAt = 0,
      this.categoryId,
      this.extra,
      this.extraValue});

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
      id: json["id"],
      photoUrl: json["photoUrl"],
      occupants: json["occupants"],
      price: json["price"],
      used: json["used"],
      model: json["model"],
      createAt: json["createAt"],
      categoryId: json["categoryId"],
      extra: json["extra"],
      extraValue: json["extraValue"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "photoUrl": photoUrl,
        "occupants": occupants,
        "price": price,
        "used": used,
        "model": model,
        "createAt": createAt,
        "categoryId": categoryId,
        "extra": extra,
        "extraValue": extraValue
      };
}
