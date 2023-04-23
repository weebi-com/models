import 'package:models_weebi/src/models/articles_line.dart';
import 'package:models_weebi/src/models/herder.dart';
import 'package:models_weebi/utils.dart';
import 'package:test/test.dart';
import 'package:models_weebi/extensions.dart';

void main() {
  group('find dups', () {
    test('in articleLines', () {
      final dummy = ArticleLines.dummy;
      final oldList = [dummy];
      final newDummyPureDup = ArticleLines.dummy;
      final newDummyDiff = ArticleLines.dummy.copyWith(title: 'ptit avocat');
      final newList = [newDummyPureDup, newDummyDiff];

      final twoLists = newList.findDupsInNewList(oldList: oldList);
      expect(twoLists.listDups.length, 1);
      expect(twoLists.listNoDups.length, 1);
      expect(twoLists.listNoDups.first.title, 'ptit avocat');
    });
    test('in herder', () {
      final dummy = Herder.dummy;
      final oldList = [dummy];

      final newDummyPureDup = Herder.dummy;
      final newDummyNameDup = Herder.dummy.copyWith(firstName: 'ptit couillon');
      final newDummyMailDup =
          Herder.dummy.copyWith(mail: 'ptitcouillon@gmail.com');

      final newDummyTelDiff = Herder.dummy.copyWith(
          firstName: 'ptit couillon bis',
          tel: '06',
          mail: 'ptitcouillon@gmail.com');
      final newList = [
        newDummyPureDup,
        newDummyNameDup,
        newDummyMailDup,
        newDummyTelDiff,
      ];
      final twoLists = newList.findDupsInNewList(oldList: oldList);
      expect(twoLists.listDups.length, 3);
      expect(twoLists.listNoDups.length, 1);
      expect(twoLists.listNoDups.first.tel, '06');
    });
  });
}
