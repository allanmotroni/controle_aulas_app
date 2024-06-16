import 'package:controle_aulas_app/database/app_database.dart';
import 'package:controle_aulas_app/database/dao/modelo_escola_dao.dart';
import 'package:controle_aulas_app/database/dao/oficina_dao.dart';
import 'package:controle_aulas_app/models/modelo_oficina.dart';
import 'package:sqflite/sqflite.dart';

class ModeloOficinaDao {
  static const String tableSql =
      'CREATE TABLE IF NOT EXISTS $tableName($id INTEGER PRIMARY KEY AUTOINCREMENT, $modeloEscolaId INTEGER NOT NULL, $oficinaId INTEGER NOT NULL, $duracao INTEGER NOT NULL, $valor REAL NOT NULL, $ativo INTEGER NOT NULL, FOREIGN KEY($modeloEscolaId) REFERENCES ${ModeloEscolaDao.tableName}(${ModeloEscolaDao.id}), FOREIGN KEY($oficinaId) REFERENCES ${OficinaDao.tableName}(${OficinaDao.id}))';

  // static const String alterTableSql =
  //     'ALTER TABLE $tableName ADD COLUMN $vencimento INTEGER';

  static const String dropTable = 'DROP TABLE IF EXISTS $tableName';

  static const String tableName = 'modelo_oficina';

  static const String id = 'id';
  static const String modeloEscolaId = 'modelo_escola_id';
  static const String oficinaId = 'oficina_id';
  static const String duracao = 'duracao';
  static const String valor = 'valor';
  static const String ativo = 'ativo';

  Future<int> inclui(ModeloOficina model) async {
    final Database db = await getDatabase();

    Map<String, dynamic> map = toMap(model);

    return db.insert(tableName, map);
  }

  Future<int> exclui(int fieldId) async {
    final Database db = await getDatabase();
    return db.delete(tableName, where: '$id = ?', whereArgs: [fieldId]);
  }

  Future<int> altera(ModeloOficina model) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contaMap = toMap(model);

    return db
        .update(tableName, contaMap, where: '$id = ?', whereArgs: [model.id]);
  }

  Future<List<ModeloOficina>> lista(
      {bool modeloEscola = true, bool oficina = true}) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    final List<ModeloOficina> list = toList(maps);

    if (modeloEscola || oficina) {
      ModeloEscolaDao modeloEscolaDao = ModeloEscolaDao();
      OficinaDao oficinaDao = OficinaDao();
      for (var model in list) {
        if (modeloEscola) {
          model.modeloEscola =
              await modeloEscolaDao.obterPorId(model.modeloEscolaId);
        }
        if (oficina) {
          model.oficina = await oficinaDao.obterPorId(model.oficinaId);
        }
      }
    }

    return list;
  }

  Future<ModeloOficina?> obterPorId(int fieldId,
      {bool modeloEscola = true, bool oficina = true}) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName,
        where: '${ModeloOficinaDao.id} = ?', whereArgs: [fieldId], limit: 1);
    final List<ModeloOficina> list = toList(maps);

    if (modeloEscola || oficina) {
      ModeloEscolaDao modeloEscolaDao = ModeloEscolaDao();
      OficinaDao oficinaDao = OficinaDao();
      for (var model in list) {
        if (modeloEscola) {
          model.modeloEscola =
              await modeloEscolaDao.obterPorId(model.modeloEscolaId);
        }
        if (oficina) {
          model.oficina = await oficinaDao.obterPorId(model.oficinaId);
        }
      }
    }

    return list.firstOrNull;
  }

  Future<ModeloOficina?> obterPorOficinaId(int fieldId,
      {bool modeloEscola = true, bool oficina = true}) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(tableName,
        where: '${ModeloOficinaDao.oficinaId} = ?', whereArgs: [fieldId], limit: 1);
    final List<ModeloOficina> list = toList(maps);

    if (modeloEscola || oficina) {
      ModeloEscolaDao modeloEscolaDao = ModeloEscolaDao();
      OficinaDao oficinaDao = OficinaDao();
      for (var model in list) {
        if (modeloEscola) {
          model.modeloEscola =
              await modeloEscolaDao.obterPorId(model.modeloEscolaId);
        }
        if (oficina) {
          model.oficina = await oficinaDao.obterPorId(model.oficinaId);
        }
      }
    }

    return list.firstOrNull;
  }

  static Map<String, dynamic> toMap(ModeloOficina model) {
    final Map<String, dynamic> map = {};

    map[modeloEscolaId] = model.modeloEscolaId;
    map[oficinaId] = model.oficinaId;
    map[duracao] = model.duracao;
    map[valor] = model.valor;
    map[ativo] = model.ativo ? 1 : 0;

    return map;
  }

  static List<ModeloOficina> toList(List<Map<String, dynamic>> maps) {
    final List<ModeloOficina> list = [];

    for (Map<String, dynamic> map in maps) {
      final ModeloOficina model = ModeloOficina(
        map[id],
        map[modeloEscolaId],
        map[oficinaId],
        map[duracao],
        map[valor],
        map[ativo] == 1,
      );
      list.add(model);
    }

    return list;
  }
}
