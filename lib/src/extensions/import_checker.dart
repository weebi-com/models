extension CheckDataImportFormat on List<dynamic> {
  String get checkHerderColLength {
    if (length < 6) {
      return '''Le fichier doit contenir x7 colonnes dans cet ordre 
          |prénom|nom|tel|mail|addresse|femme?|catégorie|
      ex: |Jimmy|Joe|77|j@j.com|Dakar|false|prospect|
          ''';
    } else {
      return 'ok';
    }
  }

  String get checkHeaderRowsFitArticle {
    if (length < 4) {
      return '''Le fichier excel doit contenir x4 colonnes dans cet ordre : 
          | libellé | prix | coût | code barre ''';
    } else {
      for (var i = 0; i < length; i++) {
        if (this[i] == 1) {
          if (this[i] == null) {
            return 'cellule prix vide pour ${this[i - 1]}';
          }
          if (this[i].runtimeType != int && int.tryParse(this[i]) == null) {}
        }
      }
      return 'ok';
    }
  }
}

