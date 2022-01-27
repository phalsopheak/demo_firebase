class PictureModel {
  final String id;
  final String pictureUrl;
  PictureModel({
    required this.id,
    required this.pictureUrl,
  });

  PictureModel copyWith({
    String? id,
    String? pictureUrl,
  }) {
    return PictureModel(
      id: id ?? this.id,
      pictureUrl: pictureUrl ?? this.pictureUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pictureUrl': pictureUrl,
    };
  }

  factory PictureModel.fromMap(Map<String, dynamic> map) {
    return PictureModel(
      id: map['id'] ?? '',
      pictureUrl: map['pictureUrl'] ?? '',
    );
  }
}
