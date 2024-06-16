import 'package:controle_aulas_app/database/app_database.dart';
import 'package:controle_aulas_app/models/oficina.dart';
import 'package:sqflite/sqflite.dart';

class OficinaDao {
  static const String tableSql =
      'CREATE TABLE IF NOT EXISTS $tableName($id INTEGER PRIMARY KEY AUTOINCREMENT, $nome TEXT NOT NULL, $observacao TEXT NULL, $ativo INTEGER NOT NULL)';

  // static const String alterTableSql =
  //     'ALTER TABLE $tableName ADD COLUMN $vencimento INTEGER';

  static const String dropTable = 'DROP TABLE IF EXISTS $tableName';

  static const String tableName = 'oficina';

  static const String id = 'id';
  static const String nome = 'nome';
  static const String observacao = 'observacao';
  static const String ativo = 'ativo';

  Future<int> inclui(Oficina model) async {
    final Database db = await getDatabase();

    Map<String, dynamic> modelMap = toMap(model);

    return db.insert(tableName, modelMap);
  }

  Future<int> exclui(int fieldId) async {
    final Database db = await getDatabase();
    return db.delete(tableName, where: '$id = ?', whereArgs: [fieldId]);
  }

  Future<int> altera(Oficina model) async {
    final Database db = await getDatabase();
    Map<String, dynamic> modelMap = toMap(model);

    return db
        .update(tableName, modelMap, where: '$id = ?', whereArgs: [model.id]);
  }

  Future<List<Oficina>> lista() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    final List<Oficina> list = toList(maps);

    return list;
  }

  Future<Oficina?> obterPorId(int fieldId) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName,
        where: '${OficinaDao.id} = ?', whereArgs: [fieldId], limit: 1);
    final List<Oficina> list = toList(maps);

    return list.firstOrNull;
  }

  static Map<String, dynamic> toMap(Oficina model) {
    final Map<String, dynamic> map = {};

    map[nome] = model.nome;
    map[observacao] = model.observacao;
    map[ativo] = model.ativo ? 1 : 0;

    return map;
  }

  static List<Oficina> toList(List<Map<String, dynamic>> maps) {
    final List<Oficina> list = [];

    for (Map<String, dynamic> map in maps) {
      final Oficina oficina = Oficina(
        map[id],
        map[nome],
        map[ativo] == 1,
        observacao: map[observacao],
      );
      list.add(oficina);
    }

    return list;
  }
}
