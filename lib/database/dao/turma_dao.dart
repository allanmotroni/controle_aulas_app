import 'package:controle_aulas_app/database/app_database.dart';
import 'package:controle_aulas_app/models/turma.dart';
import 'package:sqflite/sqflite.dart';

class TurmaDao {
  static const String tableSql =
      'CREATE TABLE IF NOT EXISTS $tableName($id INTEGER PRIMARY KEY AUTOINCREMENT, $nome TEXT NOT NULL, $observacao TEXT NULL, $ativo INTEGER NOT NULL)';

  // static const String alterTableSql =
  //     'ALTER TABLE $tableName ADD COLUMN $vencimento INTEGER';

  static const String dropTable = 'DROP TABLE IF EXISTS $tableName';

  static const String tableName = 'turma';

  static const String id = 'id';
  static const String nome = 'nome';
  static const String observacao = 'observacao';
  static const String ativo = 'ativo';

  Future<int> inclui(Turma model) async {
    final Database db = await getDatabase();

    Map<String, dynamic> modelMap = toMap(model);

    return db.insert(tableName, modelMap);
  }

  Future<int> exclui(int fieldId) async {
    final Database db = await getDatabase();
    return db.delete(tableName, where: '$id = ?', whereArgs: [fieldId]);
  }

  Future<int> altera(Turma model) async {
    final Database db = await getDatabase();
    Map<String, dynamic> modelMap = toMap(model);

    return db
        .update(tableName, modelMap, where: '$id = ?', whereArgs: [model.id]);
  }

  Future<List<Turma>> lista() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    final List<Turma> list = toList(maps);

    return list;
  }

  Future<Turma?> obterPorId(int fieldId) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName,
        where: '${TurmaDao.id} = ?', whereArgs: [fieldId], limit: 1);
    final List<Turma> list = toList(maps);

    return list.firstOrNull;
  }

  static Map<String, dynamic> toMap(Turma model) {
    final Map<String, dynamic> map = {};

    map[nome] = model.nome;
    map[observacao] = model.observacao;
    map[ativo] = model.ativo ? 1 : 0;

    return map;
  }

  static List<Turma> toList(List<Map<String, dynamic>> maps) {
    final List<Turma> list = [];

    for (Map<String, dynamic> map in maps) {
      final Turma turma = Turma(
        map[id],
        map[nome],
        map[ativo] == 1,
        observacao: map[observacao],
      );
      list.add(turma);
    }

    return list;
  }
}
