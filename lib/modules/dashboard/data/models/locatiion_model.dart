// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

List<LocationModel> locationModelFromJson(String str) =>
    List<LocationModel>.from(
        json.decode(str).map((x) => LocationModel.fromJson(x)));

String locationModelToJson(List<LocationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationModel {
  String? fromLocation;
  String? toLocation;

  LocationModel({
    this.fromLocation,
    this.toLocation,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        fromLocation: json["from_location"],
        toLocation: json["to_location"],
      );

  Map<String, dynamic> toJson() => {
        "from_location": fromLocation,
        "to_location": toLocation,
      };
}
