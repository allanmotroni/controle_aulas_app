import 'package:controle_aulas_app/database/dao/escola_dao.dart';
import 'package:controle_aulas_app/models/escola.dart';
import 'package:flutter/material.dart';

class EscolaProvider with ChangeNotifier {
  List<Escola> _escolas = [];
  List<Escola> get escolas => _escolas;
  final EscolaDao escolaDao;

  EscolaProvider(this.escolaDao);

  Future<void> carregaAsync({bool ativos = false}) async {
    if (_escolas.isEmpty) {
      _escolas = await escolaDao.lista(ativos: ativos);
      notifyListeners();
    }
  }

  Future<void> incluiAsync(Escola escola) async {
    escola.id = await escolaDao.inclui(escola);

    _escolas.add(escola);

    notifyListeners();
  }

  Future<void> alteraAsync(Escola escola) async {
    await escolaDao.altera(escola);

    _escolas.removeWhere((element) => element.id == escola.id);

    _escolas.add(escola);

    notifyListeners();
  }

  Future<void> excluiAsync(Escola escola) async {
    await escolaDao.exclui(escola.id);

    _escolas.removeWhere((element) => element.id == escola.id);

    notifyListeners();
  }
}
