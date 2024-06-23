import 'package:controle_aulas_app/database/dao/modelo_oficina_dao.dart';
import 'package:controle_aulas_app/database/dao/modelo_turma_dao.dart';
import 'package:controle_aulas_app/database/dao/turma_dao.dart';
import 'package:controle_aulas_app/models/modelo_turma.dart';
import 'package:flutter/material.dart';

class ModeloTurmaProvider with ChangeNotifier {
  List<ModeloTurma> _modeloTurmas = <ModeloTurma>[];
  List<ModeloTurma> get modeloTurmas => _modeloTurmas;

  final ModeloTurmaDao modeloTurmaDao;
  final TurmaDao turmaDao;
  final ModeloOficinaDao modeloOficinaDao;

  ModeloTurmaProvider(
      this.modeloTurmaDao, this.turmaDao, this.modeloOficinaDao);

  Future<void> carregaAsync({bool ativos = false}) async {
    if (_modeloTurmas.isEmpty) {
      _modeloTurmas = await modeloTurmaDao.lista(ativos: ativos);
      notifyListeners();
    }
  }

  Future<void> incluiAsync(ModeloTurma modeloTurma) async {
    modeloTurma.id = await modeloTurmaDao.inclui(modeloTurma);

    modeloTurma.turma = await turmaDao.obterPorId(modeloTurma.turmaId);

    modeloTurma.modeloOficina =
        await modeloOficinaDao.obterPorId(modeloTurma.modeloOficinaId);

    _modeloTurmas.add(modeloTurma);

    notifyListeners();
  }

  Future<void> alteraAsync(ModeloTurma modeloTurma) async {
    await modeloTurmaDao.altera(modeloTurma);

    modeloTurma.turma = await turmaDao.obterPorId(modeloTurma.turmaId);

    modeloTurma.modeloOficina =
        await modeloOficinaDao.obterPorId(modeloTurma.modeloOficinaId);

    _modeloTurmas.removeWhere((element) => element.id == modeloTurma.id);

    _modeloTurmas.add(modeloTurma);

    notifyListeners();
  }

  Future<void> excluiAsync(ModeloTurma modeloTurma) async {
    await modeloTurmaDao.exclui(modeloTurma.id);

    _modeloTurmas.removeWhere((element) => element.id == modeloTurma.id);

    notifyListeners();
  }
}
