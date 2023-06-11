import 'dart:convert';
import 'package:models_base/base.dart';
import 'package:models_base/common.dart';

class ArticlePhoto extends ArticlePhotoAbstract {
  const ArticlePhoto(
      {required super.calibreId,
      required super.id,
      required super.path,
      required super.source});
  factory ArticlePhoto.fromMap(Map<String, dynamic> map) {
    return ArticlePhoto(
      calibreId: map['calibreId']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      path: map['path'] ?? '',
      source: PhotoSource.tryParse(map['source'] as String),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  static final dummy = ArticlePhoto(
    calibreId: 1,
    id: 1,
    path: 'path',
    source: PhotoSource.unknown,
  );

  factory ArticlePhoto.fromJson(String source) =>
      ArticlePhoto.fromMap(json.decode(source));

  ArticlePhoto copyWith({
    int? calibreId,
    int? id,
    String? path,
    PhotoSource? source,
  }) {
    return ArticlePhoto(
      calibreId: calibreId ?? this.calibreId,
      id: id ?? this.id,
      path: path ?? this.path,
      source: source ?? this.source,
    );
  }
}
