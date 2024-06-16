import 'package:controle_aulas_app/utils/variaveis.dart';

class Utils {
  static String obterDescricaoAcaoTela(EnumAcaoTela acaoTela) {
    if (acaoTela == EnumAcaoTela.incluir) {
      return "Incluir";
    } else if (acaoTela == EnumAcaoTela.alterar) {
      return "Alterar";
    } else if (acaoTela == EnumAcaoTela.excluir) {
      return "Excluir";
    } else if (acaoTela == EnumAcaoTela.consultar) {
      return "Consultar";
    }
    return "";
  }
}
