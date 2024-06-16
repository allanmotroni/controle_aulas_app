import 'package:controle_aulas_app/database/dao/modelo_oficina_dao.dart';

class OficinaService {
  final ModeloOficinaDao _modeloOficinaDao = ModeloOficinaDao();

  Future<bool> naoPossuiDependenciaAsync(int id) async {
    var modeloOficina = await _modeloOficinaDao.obterPorOficinaId(id,
        modeloEscola: false, oficina: false);
    return modeloOficina == null;
  }
}
