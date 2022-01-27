import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_firebase/data/model/picture_model.dart';

class ProductModel {
  final String id;
  final String name;
  final double price;
  final List<PictureModel>? listPicture;
  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.listPicture,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    double? price,
    List<PictureModel>? listPicture,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      listPicture: listPicture ?? this.listPicture,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'listPicture': listPicture?.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductModel.fromQueryDocumentSnapshot(QueryDocumentSnapshot map) {
    List<PictureModel>? listPic;
    if (map['listPicture'] != null) {
      listPic = (map['listPicture'] as List)
          .map((pictureModel) => PictureModel.fromMap(pictureModel))
          .toList();
    }

    return ProductModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      listPicture: listPic,
    );
  }
}
