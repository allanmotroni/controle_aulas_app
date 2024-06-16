import 'package:controle_aulas_app/database/dao/escola_dao.dart';
import 'package:controle_aulas_app/providers/escola_provider.dart';
import 'package:controle_aulas_app/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => EscolaProvider(EscolaDao())),
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
