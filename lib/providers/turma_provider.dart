import 'package:controle_aulas_app/database/dao/turma_dao.dart';
import 'package:controle_aulas_app/models/turma.dart';
import 'package:flutter/material.dart';

class TurmaProvider with ChangeNotifier {
  List<Turma> _turmas = [];
  List<Turma> get turmas => _turmas;
  final TurmaDao turmaDao;

  TurmaProvider(this.turmaDao);

  Future<void> carregaAsync() async {
    if (_turmas.isEmpty) {
      _turmas = await turmaDao.lista();
      notifyListeners();
    }
  }

  Future<void> incluiAsync(Turma turma) async {
    turma.id = await turmaDao.inclui(turma);

    _turmas.add(turma);

    notifyListeners();
  }

  Future<void> alteraAsync(Turma turma) async {
    await turmaDao.altera(turma);

    _turmas.removeWhere((element) => element.id == turma.id);

    _turmas.add(turma);

    notifyListeners();
  }

  Future<void> excluiAsync(Turma turma) async {
    await turmaDao.exclui(turma.id);

    _turmas.removeWhere((element) => element.id == turma.id);

    notifyListeners();
  }
}
