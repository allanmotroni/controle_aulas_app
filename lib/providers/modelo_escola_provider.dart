import 'package:controle_aulas_app/database/dao/modelo_escola_dao.dart';
import 'package:controle_aulas_app/models/modelo_escola.dart';
import 'package:flutter/material.dart';

class ModeloEscolaProvider with ChangeNotifier {
  List<ModeloEscola> _modeloEscolas = <ModeloEscola>[];
  List<ModeloEscola> get modeloEscolas => _modeloEscolas;

  final ModeloEscolaDao modeloEscolaDao;

  ModeloEscolaProvider(this.modeloEscolaDao);

  Future<void> carregaAsync({bool ativos = false}) async {
    if (_modeloEscolas.isEmpty) {
      _modeloEscolas = await modeloEscolaDao.lista(ativos: ativos);
      notifyListeners();
    }
  }

  Future<void> incluiAsync(ModeloEscola modeloEscola) async {
    modeloEscola.id = await modeloEscolaDao.inclui(modeloEscola);

    _modeloEscolas.add(modeloEscola);

    notifyListeners();
  }

  Future<void> alteraAsync(ModeloEscola modeloEscola) async {
    await modeloEscolaDao.altera(modeloEscola);

    _modeloEscolas.removeWhere((element) => element.id == modeloEscola.id);

    _modeloEscolas.add(modeloEscola);

    notifyListeners();
  }

  Future<void> excluiAsync(ModeloEscola modeloEscola) async {
    await modeloEscolaDao.exclui(modeloEscola.id);

    _modeloEscolas.removeWhere((element) => element.id == modeloEscola.id);

    notifyListeners();
  }
}
