import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

Game gameFromJson(String str) => Game.fromJson(json.decode(str));

String gameToJson(Game data) => json.encode(data.toJson());

class Game {
  String? id;
  String? gamename;
  String? gamedev;
  String? price;
  String? details;
  String? age;

  Game(
      {this.id,
      this.gamename,
      this.gamedev,
      this.price,
      this.details,
      this.age});

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        id: json["id"],
        gamename: json["gamename"],
        gamedev: json["gamedev"],
        price: json["price"],
        details: json["details"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gamename": gamename,
        "gamedev": gamedev,
        "price": price,
        "details": details,
        "age": age,
      };

  Game.fromSnapShot(DataSnapshot snapshot) {
    id = snapshot.key;
    gamename = snapshot.value['gamename'];
    gamedev = snapshot.value["gamedev"];
    price = snapshot.value['price'];
    details = snapshot.value['details'];
    age = snapshot.value['age'];
  }
}
