
import 'package:clientes_farmacias/dbhelper/mondodb.dart';
import 'package:clientes_farmacias/dbhelper/registraser.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _usernameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    Future<void> _login(BuildContext context) async {
      String username = _usernameController.text.trim();
      String password = _passwordController.text.trim();

      if (username.isEmpty || password.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error de inicio de sesión'),
              content: Text('Por favor, ingresa tu nombre de usuario y contraseña.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return; // Salir de la función si los campos están vacíos
      }

      bool isValid = await MongoDataBase.validatelogin(username, password);

      if (isValid) {
        Navigator.pushReplacementNamed(context, '/ventas');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error de inicio de sesión'),
              content: Text('El nombre de usuario o la contraseña son incorrectos. Por favor, inténtalo de nuevo.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Iniciar Sesión"),
      ),
      body: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50.0),
            const CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 100,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 50.0),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Usuario',
                labelStyle: TextStyle(
                  color: Colors.blue,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Contraseña',
                labelStyle: TextStyle(
                  color: Colors.blue,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () {
                _login(context);
              },
              child: const Text(
                'Iniciar Sesión',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "¿No tienes cuenta?",
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    // Navegar a otra página
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InsertPage()),
                    );
                  },
                  child: const Text(
                    'Regístrate aquí',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
