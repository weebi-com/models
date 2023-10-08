import 'package:models_weebi/extensions.dart';
import 'package:models_weebi/weebi_models.dart';

extension ArticlesHandler on Iterable<ArticleCalibre> {
  Set<String> get articlesNamesClean {
    final biggyBring = <String>{};
    final strings = List<String>.of([]);
    for (final line in this) {
      for (final article in line.articles) {
        strings.add(article.fullName.clean);
      }
    }
    return biggyBring;
  }
}

extension ArticlesFilter on Iterable<ArticleCalibre> {
  Iterable<ArticleCalibre> get all =>
      where((ac) => ac.title != '*').where((ac) => ac.id >= 0); // stupid legacy

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
    final cautiousLegacyClean = all.where((p) => p.isNotQuickSpend);
    for (final articleNameClean in cautiousLegacyClean.articlesNamesClean) {
      if (articleNameClean.contains(queryString.clean)) {
        articlesNames.add(articleNameClean);
      }
    }
    return articlesNames;
  }

  List<ArticleCalibre> searchByTitle(String queryString) {
    return List<ArticleCalibre>.of(all
        .where((p) => p.isNotQuickSpend)
        .where((p) => p.title.clean.contains(queryString.clean))
        .toList());
  }

  List<ArticleCalibre> searchById(String queryString) {
    return List<ArticleCalibre>.of(all
        .where((p) => p.isNotQuickSpend)
        .where((p) => p.id.toString().contains(queryString.trim()))
        .toList());
  }

  List<ArticleCalibre> get notDeactivated =>
      List<ArticleCalibre>.of(where((p) => p.status));

  List<ArticleCalibre> get palpables =>
      List<ArticleCalibre>.of(where((p) => p.isPalpable ?? true));
}
