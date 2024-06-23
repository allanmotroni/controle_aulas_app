import 'package:controle_aulas_app/database/dao/modelo_escola_dao.dart';
import 'package:controle_aulas_app/database/dao/modelo_oficina_dao.dart';
import 'package:controle_aulas_app/database/dao/oficina_dao.dart';
import 'package:controle_aulas_app/models/modelo_oficina.dart';
import 'package:flutter/material.dart';

class ModeloOficinaProvider with ChangeNotifier {
  List<ModeloOficina> _modeloOficinas = <ModeloOficina>[];
  List<ModeloOficina> get modeloOficinas => _modeloOficinas;

  final ModeloOficinaDao modeloOficinaDao;
  final OficinaDao oficinaDao;
  final ModeloEscolaDao modeloEscolaDao;

  ModeloOficinaProvider(
      this.modeloOficinaDao, this.oficinaDao, this.modeloEscolaDao);

  Future<void> carregaAsync({bool ativos = false}) async {
    if (_modeloOficinas.isEmpty) {
      _modeloOficinas = await modeloOficinaDao.lista(ativos: ativos);
      notifyListeners();
    }
  }

  Future<void> incluiAsync(ModeloOficina modeloOficina) async {
    modeloOficina.id = await modeloOficinaDao.inclui(modeloOficina);

    modeloOficina.oficina =
        await oficinaDao.obterPorId(modeloOficina.oficinaId);

    modeloOficina.modeloEscola =
        await modeloEscolaDao.obterPorId(modeloOficina.modeloEscolaId);

    _modeloOficinas.add(modeloOficina);

    notifyListeners();
  }

  Future<void> alteraAsync(ModeloOficina modeloOficina) async {
    await modeloOficinaDao.altera(modeloOficina);

    modeloOficina.oficina =
        await oficinaDao.obterPorId(modeloOficina.oficinaId);

    modeloOficina.modeloEscola =
        await modeloEscolaDao.obterPorId(modeloOficina.modeloEscolaId);

    _modeloOficinas.removeWhere((element) => element.id == modeloOficina.id);

    _modeloOficinas.add(modeloOficina);

    notifyListeners();
  }

  Future<void> excluiAsync(ModeloOficina modeloOficina) async {
    await modeloOficinaDao.exclui(modeloOficina.id);

    _modeloOficinas.removeWhere((element) => element.id == modeloOficina.id);

    notifyListeners();
  }
}
