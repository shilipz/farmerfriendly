// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VegetableDetails {
  final String name;
  final int quantity;
  final DateTime collectionDate;

  VegetableDetails({
    required this.name,
    required this.quantity,
    required this.collectionDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'quantity': quantity,
      'collectionDate': collectionDate.millisecondsSinceEpoch,
    };
  }

  factory VegetableDetails.fromMap(Map<String, dynamic> map) {
    return VegetableDetails(
      name: map['name'] as String,
      quantity: map['quantity'] as int,
      collectionDate:
          DateTime.fromMillisecondsSinceEpoch(map['collectionDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory VegetableDetails.fromJson(String source) =>
      VegetableDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}
