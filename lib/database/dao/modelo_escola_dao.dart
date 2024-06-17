import 'package:controle_aulas_app/database/app_database.dart';
import 'package:controle_aulas_app/database/dao/escola_dao.dart';
import 'package:controle_aulas_app/models/modelo_escola.dart';
import 'package:sqflite/sqflite.dart';

class ModeloEscolaDao {
  static const String tableSql =
      'CREATE TABLE IF NOT EXISTS $tableName($id INTEGER PRIMARY KEY AUTOINCREMENT, $diaSemana INTEGER NOT NULL, $escolaId INTEGER NOT NULL, $ativo INTEGER NOT NULL, FOREIGN KEY($escolaId) REFERENCES ${EscolaDao.tableName}(${EscolaDao.id}))';

  // static const String alterTableSql =
  //     'ALTER TABLE $tableName ADD COLUMN $vencimento INTEGER';

  static const String dropTable = 'DROP TABLE IF EXISTS $tableName';

  static const String tableName = 'modelo_escola';

  static const String id = 'id';
  static const String diaSemana = 'dia_semana';
  static const String escolaId = 'escola_id';
  static const String ativo = 'ativo';

  Future<int> inclui(ModeloEscola model) async {
    final Database db = await getDatabase();

    Map<String, dynamic> map = toMap(model);

    return db.insert(tableName, map);
  }

  Future<int> exclui(int fieldId) async {
    final Database db = await getDatabase();
    return db.delete(tableName, where: '$id = ?', whereArgs: [fieldId]);
  }

  Future<int> altera(ModeloEscola model) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contaMap = toMap(model);

    return db
        .update(tableName, contaMap, where: '$id = ?', whereArgs: [model.id]);
  }

  Future<List<ModeloEscola>> lista(
      {bool ativos = false, bool escola = true}) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = ativos
        ? await db.query(tableName,
            where: '${ModeloEscolaDao.ativo} = ?', whereArgs: [1])
        : await db.query(tableName);

    final List<ModeloEscola> list = toList(maps);

    if (escola) {
      final EscolaDao escolaDao = EscolaDao();
      for (var model in list) {
        model.escola = await escolaDao.obterPorId(model.escolaId);
      }
    }

    return list;
  }

  Future<ModeloEscola?> obterPorId(int fieldId, {bool escola = true}) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName,
        where: '${ModeloEscolaDao.id} = ?', whereArgs: [fieldId], limit: 1);
    final List<ModeloEscola> list = toList(maps);

    if (escola) {
      final EscolaDao escolaDao = EscolaDao();
      for (var model in list) {
        model.escola = await escolaDao.obterPorId(model.escolaId);
      }
    }

    return list.firstOrNull;
  }

  Future<ModeloEscola?> obterPorEscolaId(int fieldId,
      {bool escola = true}) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName,
        where: '${ModeloEscolaDao.escolaId} = ?',
        whereArgs: [fieldId],
        limit: 1);
    final List<ModeloEscola> list = toList(maps);

    if (escola) {
      final EscolaDao escolaDao = EscolaDao();
      for (var model in list) {
        model.escola = await escolaDao.obterPorId(model.escolaId);
      }
    }

    return list.firstOrNull;
  }

  static Map<String, dynamic> toMap(ModeloEscola model) {
    final Map<String, dynamic> map = {};

    map[diaSemana] = model.diaSemana;
    map[escolaId] = model.escolaId;
    map[ativo] = model.ativo ? 1 : 0;

    return map;
  }

  static List<ModeloEscola> toList(List<Map<String, dynamic>> maps) {
    final List<ModeloEscola> list = [];

    for (Map<String, dynamic> map in maps) {
      final ModeloEscola model = ModeloEscola(
        map[id],
        map[diaSemana],
        map[escolaId],
        map[ativo] == 1,
      );
      list.add(model);
    }

    return list;
  }
}
