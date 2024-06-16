import 'package:controle_aulas_app/database/dao/modelo_escola_dao.dart';

class EscolaService {
  final ModeloEscolaDao _modeloEscolaDao = ModeloEscolaDao();

  Future<bool> naoPossuiDependenciaAsync(int id) async {
    var modeloEscola =
        await _modeloEscolaDao.obterPorEscolaId(id, escola: false);
    return modeloEscola == null;
  }
}
