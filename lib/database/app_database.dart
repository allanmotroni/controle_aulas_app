import 'package:controle_aulas_app/database/dao/escola_dao.dart';
import 'package:controle_aulas_app/database/dao/modelo_escola_dao.dart';
import 'package:controle_aulas_app/database/dao/modelo_oficina_dao.dart';
import 'package:controle_aulas_app/database/dao/modelo_turma_dao.dart';
import 'package:controle_aulas_app/database/dao/oficina_dao.dart';
import 'package:controle_aulas_app/database/dao/planejamento_dao.dart';
import 'package:controle_aulas_app/database/dao/turma_dao.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String _databaseName = 'controle_aulas.db';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), _databaseName);

  //await excluirBaseDeDados(path);

  return openDatabase(
    path,
    version: 1,
    onCreate: (db, version) => createTables(db),
    onUpgrade: (db, a, b) => alterTables(db),
    //onDowngrade: onDatabaseDowngradeDelete,
  );
}

Future excluirBaseDeDados(String path) async {
  debugPrint('deleteDatabase() - Start');
  await deleteDatabase(path);
  debugPrint('deleteDatabase() - End');
}

void createTables(Database db) {
  debugPrint('createTables() - Start');
  db.execute(EscolaDao.tableSql);
  db.execute(OficinaDao.tableSql);
  db.execute(TurmaDao.tableSql);
  db.execute(ModeloEscolaDao.tableSql);
  db.execute(ModeloOficinaDao.tableSql);
  db.execute(ModeloTurmaDao.tableSql);
  db.execute(PlanejamentoDao.tableSql);

  debugPrint('createTables() - End');
}

void alterTables(Database db) {
  debugPrint('alterTables() - Start');
  //debugPrint('Script - ${ContaDao.alterTableSql}');
  //db.execute(ContaDao.alterTableSql);
  debugPrint('alterTables() - End');
}
