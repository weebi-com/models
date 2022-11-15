extension CheckHeaderFormat on List<dynamic> {
  String get checkHerderHeaderImportFormat {
    if (length < 6) {
      return '''Le fichier doit respectivement avoir les colonnes suivantes : 
          |firstName|lastName|tel|mail|address|isWoman|category|''';
    } else if ((this[0] != 'firstName') ||
        (this[1] != 'lastName') ||
        (this[2] != 'tel') ||
        (this[3] != 'mail') ||
        (this[4] != 'address') ||
        (this[5] != 'isWoman') ||
        (this[6] != 'category')) {
      return '''Le fichier excel doit respectivement avoir les colonnes suivantes : 
          |firstName|lastName|tel|mail|address|isWoman|category|''';
    } else {
      return 'ok';
    }
  }

  String get checkArticleHeaderFormat {
    if (length < 4) {
      return '''Le fichier excel doit respectivement avoir les cellules suivant : 
          "title" - "price" - "cost" - "barcode"''';
    } else if ((this[0] != 'title') ||
        (this[1] != 'price') ||
        (this[2] != 'cost') ||
        (this[3] != 'barcode')) {
      return '''Le fichier excel doit respectivement avoir les cellules suivant : 
          "title" - "price" - "cost" - "barcode"''';
    } else {
      return 'ok';
    }
  }
}
