import 'package:controle_aulas_app/database/app_database.dart';
import 'package:controle_aulas_app/database/dao/modelo_oficina_dao.dart';
import 'package:controle_aulas_app/database/dao/turma_dao.dart';
import 'package:controle_aulas_app/models/modelo_turma.dart';
import 'package:sqflite/sqflite.dart';

class ModeloTurmaDao {
  static const String tableSql =
      'CREATE TABLE IF NOT EXISTS $tableName($id INTEGER PRIMARY KEY AUTOINCREMENT, $modeloOficinaId INTEGER NOT NULL, $turmaId INTEGER NOT NULL, $ativo INTEGER NOT NULL, FOREIGN KEY($modeloOficinaId) REFERENCES ${ModeloOficinaDao.tableName}(${ModeloOficinaDao.id}), FOREIGN KEY($turmaId) REFERENCES ${TurmaDao.tableName}(${TurmaDao.id}))';

  // static const String alterTableSql =
  //     'ALTER TABLE $tableName ADD COLUMN $vencimento INTEGER';

  static const String dropTable = 'DROP TABLE IF EXISTS $tableName';

  static const String tableName = 'modelo_turma';

  static const String id = 'id';
  static const String modeloOficinaId = 'modelo_oficina_id';
  static const String turmaId = 'turma_id';
  static const String ativo = 'ativo';

  Future<int> inclui(ModeloTurma model) async {
    final Database db = await getDatabase();

    Map<String, dynamic> map = toMap(model);

    return db.insert(tableName, map);
  }

  Future<int> exclui(int fieldId) async {
    final Database db = await getDatabase();
    return db.delete(tableName, where: '$id = ?', whereArgs: [fieldId]);
  }

  Future<int> altera(ModeloTurma model) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contaMap = toMap(model);

    return db
        .update(tableName, contaMap, where: '$id = ?', whereArgs: [model.id]);
  }

  Future<List<ModeloTurma>> lista(
      {bool ativos = false,
      bool modeloOficina = true,
      bool turma = true}) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = ativos
        ? await db.query(tableName,
            where: '${ModeloTurmaDao.ativo} = ?', whereArgs: [1])
        : await db.query(tableName);
    final List<ModeloTurma> list = toList(maps);

    if (modeloOficina || turma) {
      ModeloOficinaDao modeloOficinaDao = ModeloOficinaDao();
      TurmaDao turmaDao = TurmaDao();
      for (var model in list) {
        if (modeloOficina) {
          model.modeloOficina =
              await modeloOficinaDao.obterPorId(model.modeloOficinaId);
        }
        if (turma) {
          model.turma = await turmaDao.obterPorId(model.turmaId);
        }
      }
    }

    return list;
  }

  Future<ModeloTurma?> obterPorId(int fieldId,
      {bool modeloOficina = true, bool turma = true}) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName,
        where: '${ModeloTurmaDao.id} = ?', whereArgs: [fieldId], limit: 1);
    final List<ModeloTurma> list = toList(maps);

    if (modeloOficina || turma) {
      ModeloOficinaDao modeloOficinaDao = ModeloOficinaDao();
      TurmaDao turmaDao = TurmaDao();
      for (var model in list) {
        if (modeloOficina) {
          model.modeloOficina =
              await modeloOficinaDao.obterPorId(model.modeloOficinaId);
        }
        if (turma) {
          model.turma = await turmaDao.obterPorId(model.turmaId);
        }
      }
    }

    return list.firstOrNull;
  }

  Future<ModeloTurma?> obterPorTurmaId(int fieldId,
      {bool modeloOficina = true, bool turma = true}) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName,
        where: '${ModeloTurmaDao.turmaId} = ?', whereArgs: [fieldId], limit: 1);
    final List<ModeloTurma> list = toList(maps);

    if (modeloOficina || turma) {
      ModeloOficinaDao modeloOficinaDao = ModeloOficinaDao();
      TurmaDao turmaDao = TurmaDao();
      for (var model in list) {
        if (modeloOficina) {
          model.modeloOficina =
              await modeloOficinaDao.obterPorId(model.modeloOficinaId);
        }
        if (turma) {
          model.turma = await turmaDao.obterPorId(model.turmaId);
        }
      }
    }

    return list.firstOrNull;
  }

  static Map<String, dynamic> toMap(ModeloTurma model) {
    final Map<String, dynamic> map = {};

    map[modeloOficinaId] = model.modeloOficinaId;
    map[turmaId] = model.turmaId;
    map[ativo] = model.ativo ? 1 : 0;

    return map;
  }

  static List<ModeloTurma> toList(List<Map<String, dynamic>> maps) {
    final List<ModeloTurma> list = [];

    for (Map<String, dynamic> map in maps) {
      final ModeloTurma model = ModeloTurma(
        map[id],
        map[modeloOficinaId],
        map[turmaId],
        map[ativo] == 1,
      );
      list.add(model);
    }

    return list;
  }
}
