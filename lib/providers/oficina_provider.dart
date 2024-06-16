import 'package:controle_aulas_app/database/dao/oficina_dao.dart';
import 'package:controle_aulas_app/models/oficina.dart';
import 'package:flutter/material.dart';

class OficinaProvider with ChangeNotifier {
  List<Oficina> _oficinas = [];
  List<Oficina> get oficinas => _oficinas;
  final OficinaDao oficinaDao;

  OficinaProvider(this.oficinaDao);

  Future<void> carregaAsync() async {
    if (_oficinas.isEmpty) {
      _oficinas = await oficinaDao.lista();
      notifyListeners();
    }
  }

  Future<void> incluiAsync(Oficina oficina) async {
    oficina.id = await oficinaDao.inclui(oficina);

    _oficinas.add(oficina);

    notifyListeners();
  }

  Future<void> alteraAsync(Oficina oficina) async {
    await oficinaDao.altera(oficina);

    _oficinas.removeWhere((element) => element.id == oficina.id);

    _oficinas.add(oficina);

    notifyListeners();
  }

  Future<void> excluiAsync(Oficina oficina) async {
    await oficinaDao.exclui(oficina.id);

    _oficinas.removeWhere((element) => element.id == oficina.id);

    notifyListeners();
  }
}
