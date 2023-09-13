import 'package:models_weebi/extensions.dart';
import 'package:models_weebi/weebi_models.dart';

extension ArticlesHandler on Iterable<ArticleCalibre> {
  Set<String> get articlesNamesRaw {
    final biggyBring = <String>{};
    final strings = List<String>.of([]);
    for (final line in this) {
      for (final article in line.articles) {
        strings.add(article.fullName.trim().withoutAccents.toLowerCase());
      }
    }
    return biggyBring;
  }
}

extension ArticlesFilter on Iterable<ArticleCalibre> {
  List<ArticleCalibre> searchByTitleOrId(String queryString) {
    final oneList = [...searchByTitle(queryString), ...searchById(queryString)];
    return List<ArticleCalibre>.of(Set<ArticleCalibre>.of(oneList));
  }

  List<ArticleCalibre> searchByIdOrArticleNames(String queryString) {
    final oneList = [...searchByTitle(queryString), ...searchById(queryString)];
    return List<ArticleCalibre>.of(Set<ArticleCalibre>.of(oneList));
  }

  Set<String> searchByArticleNames(String queryString) {
    final articlesNames = <String>{};
    final cautiousLegacyClean = where((p) => p.title != '*') // stupid legacy
        .where((p) => p.isNotQuickSpend);
    for (final articleName in cautiousLegacyClean.articlesNamesRaw) {
      if (articleName
          .contains(queryString.trim().withoutAccents.toLowerCase())) {
        articlesNames.add(articleName);
      }
    }
    return articlesNames;
  }

  List<ArticleCalibre> searchByTitle(String queryString) {
    return List<ArticleCalibre>.of(where((p) => p.title != '*')
        .where((p) => p.isNotQuickSpend)
        .where((p) => p.title
            .toLowerCase()
            .trim()
            .withoutAccents
            .contains(queryString.trim().withoutAccents.toLowerCase()))
        .toList());
  }

  List<ArticleCalibre> searchById(String queryString) {
    return List<ArticleCalibre>.of(where((p) => p.title != '*')
        .where((p) => p.isNotQuickSpend)
        .where((p) => p.id.toString().contains(queryString.trim()))
        .toList());
  }

  List<ArticleCalibre> get notDeactivated =>
      List<ArticleCalibre>.of(where((p) => p.status));

  List<ArticleCalibre> get palpables =>
      List<ArticleCalibre>.of(where((p) => p.isPalpable ?? true));
}
