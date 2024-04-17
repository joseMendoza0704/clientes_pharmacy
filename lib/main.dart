import 'package:clientes_farmacias/dbhelper/mondodb.dart';
import 'package:clientes_farmacias/dbhelper/mongomodel.dart';
import 'package:clientes_farmacias/pages/datausuario.dart';

import 'package:clientes_farmacias/pages/welcomepage.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDataBase.connect();
  await MongoService.connectToDatabase();
  // Asegúrate de inicializar la conexión a la base de datos antes de ejecutar la aplicación
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la línea de debug
      initialRoute: '/Home',
      routes: {
        '/Home': (context) => const WelcomePage(),
        '/ventas': (context) => const VentasPage(),
      },
      title: 'TuFarmaciaApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomePage(),
    );
  }
}
