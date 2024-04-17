import 'package:clientes_farmacias/dbhelper/mongomodel.dart';
import 'package:clientes_farmacias/pages/datausuario.dart';



import 'package:flutter/material.dart';
import 'package:clientes_farmacias/dbhelper/mondodb.dart';
 // Importa la pantalla de ventas

class InsertPage extends StatefulWidget {
  const InsertPage({Key? key}) : super(key: key);

  @override
  _InsertPageState createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  final fnameController = TextEditingController();
  final flnameController = TextEditingController();

Future<void> insertuser() async {
  final data = Mongodbmodel(firtsname: fnameController.text, lastname: flnameController.text);

  try {
    // Verificar si el usuario ya existe
    bool userExists = await MongoDataBase.getuser(fnameController.text);
    if (userExists) {
      // Si el usuario ya existe, muestra un mensaje y no realiza la inserción
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("El usuario ya existe")));
    } else {
      // Si el usuario no existe, realiza la inserción
      await MongoDataBase.insert(data);
      print("Usuario registrado correctamente");
    }
  } catch (e) {
    // Si ocurre un error, muestra un mensaje de error
    print("Error al registrar usuario: $e");
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error al registrar usuario")));
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insertar Datos'),
      ),
      body: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 70,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Registrarse',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: fnameController,
              decoration: InputDecoration(
                labelText: "Usuario",
                labelStyle: const TextStyle(color: Colors.blue),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.person, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: flnameController,
              decoration: InputDecoration(
                labelText: "Contraseña",
                labelStyle: const TextStyle(color: Colors.blue),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: const Icon(Icons.lock, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20.0),
          ElevatedButton(
  onPressed: () async {
    bool userExists = await MongoDataBase.getuser(fnameController.text);
    if (userExists) {
      // Si el usuario ya existe, muestra un mensaje y no realiza la inserción
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("El usuario ya existe")));
    } else {
      // Si el usuario no existe, intenta registrar y navega a la página de ventas si tiene éxito
      await insertuser();
      
      // Si la inserción es exitosa, entonces navega a la página de ventas
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VentasPage()),
      );
    }
    
    // Limpiar los campos de texto después de realizar la acción
    fnameController.clear();
    flnameController.clear();
  },
  child: const Text(
    'Registrarse',
    style: TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
    ),
  ),
),


          ],
        ),
      ),
    );
  }
}
