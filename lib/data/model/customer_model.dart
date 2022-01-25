import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  final String id;
  final String name;
  final String? profilePicture;

  CustomerModel({
    required this.id,
    required this.name,
    this.profilePicture,
  });

  CustomerModel copyWith({
    String? id,
    String? name,
    String? profilePicture,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'profilePicture': profilePicture,
    };
  }

  factory CustomerModel.fromQueryDocumentSnapshot(QueryDocumentSnapshot doc) {
    return CustomerModel(
      id: doc['id'] ?? '',
      name: doc['name'] ?? '',
      profilePicture: doc['profilePicture'],
    );
  }
}
