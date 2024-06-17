import 'package:controle_aulas_app/database/app_database.dart';
import 'package:controle_aulas_app/models/escola.dart';
import 'package:sqflite/sqflite.dart';

class EscolaDao {
  static const String tableSql =
      'CREATE TABLE IF NOT EXISTS $tableName($id INTEGER PRIMARY KEY AUTOINCREMENT, $nome TEXT NOT NULL, $observacao TEXT NULL, $ativo INTEGER NOT NULL)';

  // static const String alterTableSql =
  //     'ALTER TABLE $tableName ADD COLUMN $vencimento INTEGER';

  static const String dropTable = 'DROP TABLE IF EXISTS $tableName';

  static const String tableName = 'escola';

  static const String id = 'id';
  static const String nome = 'nome';
  static const String observacao = 'observacao';
  static const String ativo = 'ativo';

  Future<int> inclui(Escola model) async {
    final Database db = await getDatabase();

    Map<String, dynamic> modelMap = toMap(model);

    return db.insert(tableName, modelMap);
  }

  Future<int> exclui(int fieldId) async {
    final Database db = await getDatabase();
    return db.delete(tableName, where: '$id = ?', whereArgs: [fieldId]);
  }

  Future<int> altera(Escola model) async {
    final Database db = await getDatabase();
    Map<String, dynamic> modelMap = toMap(model);

    return db
        .update(tableName, modelMap, where: '$id = ?', whereArgs: [model.id]);
  }

  Future<List<Escola>> lista({bool ativos = false}) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = ativos
        ? await db
            .query(tableName, where: '${EscolaDao.ativo} = ?', whereArgs: [1])
        : await db.query(tableName);
    final List<Escola> list = toList(maps);

    return list;
  }

  Future<Escola?> obterPorId(int fieldId) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName,
        where: '${EscolaDao.id} = ?', whereArgs: [fieldId], limit: 1);
    final List<Escola> list = toList(maps);

    return list.firstOrNull;
  }

  static Map<String, dynamic> toMap(Escola model) {
    final Map<String, dynamic> modelMap = {};

    modelMap[nome] = model.nome;
    modelMap[observacao] = model.observacao;
    modelMap[ativo] = model.ativo ? 1 : 0;

    return modelMap;
  }

  static List<Escola> toList(List<Map<String, dynamic>> maps) {
    final List<Escola> list = [];

    for (Map<String, dynamic> map in maps) {
      final Escola model = Escola(
        map[id],
        map[nome],
        map[ativo] == 1,
        observacao: map[observacao],
      );
      list.add(model);
    }

    return list;
  }
}
