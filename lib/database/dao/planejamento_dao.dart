import 'package:controle_aulas_app/database/app_database.dart';
import 'package:controle_aulas_app/database/dao/modelo_turma_dao.dart';
import 'package:controle_aulas_app/models/planejamento.dart';
import 'package:sqflite/sqflite.dart';

class PlanejamentoDao {
  static const String tableSql =
      'CREATE TABLE IF NOT EXISTS $tableName($id INTEGER PRIMARY KEY AUTOINCREMENT, $modeloTurmaId INTEGER NOT NULL, $data TEXT NOT NULL, $concluido INTEGER NULL, $ativo INTEGER NOT NULL, FOREIGN KEY($modeloTurmaId) REFERENCES ${ModeloTurmaDao.tableName}(${ModeloTurmaDao.id}))';

  static const String dropTable = 'DROP TABLE IF EXISTS $tableName';

  static const String tableName = 'planejamento';

  static const String id = 'id';
  static const String modeloTurmaId = 'modelo_turma_id';
  static const String data = 'data';
  static const String concluido = 'concluido';
  static const String ativo = 'ativo';

  Future<int> inclui(Planejamento model) async {
    final Database db = await getDatabase();

    Map<String, dynamic> map = toMap(model);

    return db.insert(tableName, map);
  }

  Future<int> exclui(int fieldId) async {
    final Database db = await getDatabase();
    return db.delete(tableName, where: '$id = ?', whereArgs: [fieldId]);
  }

  Future<int> altera(Planejamento model) async {
    final Database db = await getDatabase();
    Map<String, dynamic> modelMap = toMap(model);

    return db
        .update(tableName, modelMap, where: '$id = ?', whereArgs: [model.id]);
  }

  Future<List<Planejamento>> lista() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    final List<Planejamento> list = toList(maps);

    return list;
  }

  Future<Planejamento?> obterPorId(int fieldId) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName,
        where: '${PlanejamentoDao.id} = ?', whereArgs: [fieldId], limit: 1);
    final List<Planejamento> list = toList(maps);

    return list.firstOrNull;
  }

  Future<List<Planejamento>?> obterPorPeriodo(
      DateTime dataInicial, DateTime dataFinal) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName,
        where: '${PlanejamentoDao.data} >= ? AND ${PlanejamentoDao.data} <= ?',
        whereArgs: [
          dataInicial.toIso8601String(),
          dataFinal.toIso8601String()
        ]);
    final List<Planejamento> list = toList(maps);

    return list;
  }

  static Map<String, dynamic> toMap(Planejamento model) {
    final Map<String, dynamic> map = {};

    map[modeloTurmaId] = model.modeloTurmaId;
    map[data] = model.data;
    map[concluido] = model.concluido;
    map[ativo] = model.ativo ? 1 : 0;

    return map;
  }

  static List<Planejamento> toList(List<Map<String, dynamic>> maps) {
    final List<Planejamento> list = [];

    for (Map<String, dynamic> map in maps) {
      final Planejamento model = Planejamento(
        map[id],
        map[modeloTurmaId],
        map[data],
        map[concluido],
        map[ativo] == 1,
      );
      list.add(model);
    }

    return list;
  }
}
