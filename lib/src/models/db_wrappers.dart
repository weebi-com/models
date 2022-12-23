import 'package:sembast/sembast.dart';

abstract class Wrapper {
  final Database db;
  Wrapper(this.db);
}

class DbTickets extends Wrapper {
  final Database dbTk;
  DbTickets(this.dbTk) : super(dbTk);
}

class DbArticles extends Wrapper {
  final Database dbA;
  DbArticles(this.dbA) : super(dbA);
}

class DbClosings extends Wrapper {
  final Database dbC;
  DbClosings(this.dbC) : super(dbC);
}

class DbHerders extends Wrapper {
  final Database dbH;
  DbHerders(this.dbH) : super(dbH);
}

class DbShop extends Wrapper {
  final Database dbS;
  DbShop(this.dbS) : super(dbS);
}

class DbOld extends Wrapper {
  final Database dbO;
  DbOld(this.dbO) : super(dbO);
}
