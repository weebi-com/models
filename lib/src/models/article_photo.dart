import 'dart:convert';
import 'package:models_weebi/base.dart';
import 'package:models_weebi/common.dart';

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

  static const dummy = ArticlePhoto(
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ArticlePhoto &&
        other.id == id &&
        other.calibreId == calibreId &&
        other.path == path &&
        other.source == source;
  }

  @override
  int get hashCode =>
      id.hashCode ^ calibreId.hashCode ^ path.hashCode ^ source.hashCode;
}
