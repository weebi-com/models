import 'package:models_weebi/common.dart';
import 'package:models_weebi/src/base/article_photo_base.dart';

class ArticlePhotoDummy extends ArticlePhotoAbstract {
  ArticlePhotoDummy()
      : super(
          calibreId: 1,
          id: 1,
          source: PhotoSource.unknown,
          path: 'path',
        );
}
