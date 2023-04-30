import 'package:models_weebi/src/models/articles_lines.dart';
import 'package:models_weebi/src/models/herder.dart';
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

      final twoLists = newList.findDupsByTitle(oldList: oldList);
      expect(twoLists.dups.length, 1);
      expect(twoLists.noDups.length, 1);
      expect(twoLists.noDups.first.title, 'ptit avocat');
    });
    test('single herder', () {
      final oldList = [Herder.defaultHerder];
      final newList = [Herder.dummy];
      final twoLists = newList.findDupsByFields(oldList: oldList);
      expect(twoLists.dups.length, 0);
      expect(twoLists.noDups.length, 1);
      expect(twoLists.noDups.first.firstName, 'John');
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
      final twoLists = newList.findDupsByFields(oldList: oldList);
      expect(twoLists.dups.length, 3);
      expect(twoLists.noDups.length, 1);
      expect(twoLists.noDups.first.tel, '06');
    });
  });
}
