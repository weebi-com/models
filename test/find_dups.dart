import 'package:models_weebi/src/models/article_calibre.dart';
import 'package:models_weebi/src/models/herder.dart';
import 'package:test/test.dart';
import 'package:models_weebi/extensions.dart';

void main() {
  group('find dups', () {
    test('in ArticleCalibre', () {
      final dummy = ArticleCalibre.dummyRetail;
      final oldList = [dummy];
      final newDummyPureDup = ArticleCalibre.dummyRetail;
      final newDummyDiff =
          ArticleCalibre.dummyRetail.copyWith(title: 'ptit avocat');
      final newList = [newDummyPureDup, newDummyDiff];

      final twoLists = oldList.findDupsByTitle(newList: newList);
      expect(twoLists.dups.length, 1);
      expect(twoLists.noDups.length, 1);
      expect(twoLists.noDups.first.title, 'ptit avocat');
    });
    test('single herder', () {
      final oldList = [Herder.defaultHerder];
      final newList = [Herder.dummyJohnDoeId1];
      final twoLists = newList.findDupsByFields(newList: oldList);
      expect(twoLists.dups.length, 0);
      expect(twoLists.noDups.length, 1);
      expect(twoLists.noDups.first.firstName, 'John');
    });
    test('in herder', () {
      final dummy = Herder.dummyJohnDoeId1;
      final oldList = [dummy];

      final newDummyPureDup = Herder.dummyJohnDoeId1;
      final newDummyNameDup =
          Herder.dummyJohnDoeId1.copyWith(firstName: 'ptit couillon');
      final newDummyMailDup =
          Herder.dummyJohnDoeId1.copyWith(mail: 'ptitcouillon@gmail.com');

      final newDummyTelDiff = Herder.dummyJohnDoeId1.copyWith(
          firstName: 'ptit couillon bis',
          tel: '06',
          mail: 'ptitcouillon@gmail.com');
      final newList = [
        newDummyPureDup,
        newDummyNameDup,
        newDummyMailDup,
        newDummyTelDiff,
      ];
      final twoLists = newList.findDupsByFields(newList: oldList);
      expect(twoLists.dups.length, 3);
      expect(twoLists.noDups.length, 1);
      expect(twoLists.noDups.first.tel, '06');
    });
  });
}
