import 'package:controle_aulas_app/database/dao/escola_dao.dart';
import 'package:controle_aulas_app/database/dao/modelo_escola_dao.dart';
import 'package:controle_aulas_app/database/dao/modelo_oficina_dao.dart';
import 'package:controle_aulas_app/database/dao/modelo_turma_dao.dart';
import 'package:controle_aulas_app/database/dao/oficina_dao.dart';
import 'package:controle_aulas_app/database/dao/turma_dao.dart';
import 'package:controle_aulas_app/providers/dropdown_escola_provider.dart';
import 'package:controle_aulas_app/providers/escola_provider.dart';
import 'package:controle_aulas_app/providers/modelo_escola_provider.dart';
import 'package:controle_aulas_app/providers/modelo_oficina_provider.dart';
import 'package:controle_aulas_app/providers/modelo_turma_provider.dart';
import 'package:controle_aulas_app/providers/oficina_provider.dart';
import 'package:controle_aulas_app/providers/turma_provider.dart';
import 'package:controle_aulas_app/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => EscolaProvider(EscolaDao())),
          ChangeNotifierProvider(create: (_) => OficinaProvider(OficinaDao())),
          ChangeNotifierProvider(create: (_) => TurmaProvider(TurmaDao())),
          ChangeNotifierProvider(
              create: (_) =>
                  ModeloEscolaProvider(ModeloEscolaDao(), EscolaDao())),
          ChangeNotifierProvider(
              create: (_) => ModeloOficinaProvider(
                  ModeloOficinaDao(), OficinaDao(), ModeloEscolaDao())),
          ChangeNotifierProvider(
              create: (_) => ModeloTurmaProvider(
                  ModeloTurmaDao(), TurmaDao(), ModeloOficinaDao())),
          ChangeNotifierProvider(create: (_) => DropdownEscolaProvider()),
        ],
        child: const ControleAulasApp(),
      ),
    );

class ControleAulasApp extends StatelessWidget {
  const ControleAulasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle Aulas App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Menu(),
    );
  }
}
