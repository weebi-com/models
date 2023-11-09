import 'dart:convert';

import 'package:models_weebi/src/common/photo_source.dart';

abstract class PhotoAbstract {
  final String path;
  final PhotoSource source;
  const PhotoAbstract({
    required this.path,
    required this.source,
  });
}

class PhotoObject extends PhotoAbstract {
  const PhotoObject({
    required String path,
    required PhotoSource source,
  }) : super(path: path, source: source);
}

abstract class ArticlePhotoAbstract extends PhotoAbstract {
  final int id;
  final int calibreId;
  const ArticlePhotoAbstract({
    required this.calibreId,
    required this.id,
    required String path,
    required PhotoSource source,
  }) : super(path: path, source: source);

  @override
  String toString() =>
      'ArticlePhotoAbstract(calibreId: $calibreId, id: $id, path: $path, source: $source)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ArticlePhotoAbstract &&
        other.calibreId == calibreId &&
        other.id == id &&
        other.path == path &&
        other.source == source;
  }

  @override
  int get hashCode =>
      calibreId.hashCode ^ id.hashCode ^ path.hashCode ^ source.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'calibreId': calibreId,
      'id': id,
      'path': path,
      'source': source.toString(),
    };
  }

  String toJson() => json.encode(toMap());
}
