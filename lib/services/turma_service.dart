import 'package:controle_aulas_app/database/dao/modelo_turma_dao.dart';

class TurmaService {
  final ModeloTurmaDao _modeloTurmaDao = ModeloTurmaDao();

  Future<bool> naoPossuiDependenciaAsync(int id) async {
    var modeloTurma = await _modeloTurmaDao.obterPorTurmaId(id,
        modeloOficina: false, turma: false);
    return modeloTurma == null;
  }
}