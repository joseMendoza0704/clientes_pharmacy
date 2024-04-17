import 'package:clientes_farmacias/pages/login.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la línea de debug
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Bienvenido a Tu Farmacia',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24, // Tamaño del texto aumentado a 24
              fontWeight: FontWeight.bold, // Texto en negrita
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: Stack(
          children: [
            // Fondo de la pantalla
            Container(
              alignment: Alignment.topLeft, // Posiciona la imagen en la esquina superior izquierda
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://img.freepik.com/vector-gratis/composicion-isometrica-gastroenterologia-vista-medicacion-tubos-pildoras-ilustracion_1284-63536.jpg?t=st=1712787142~exp=1712790742~hmac=7292f8b2f9c83ec54f314ae32d6aa97e6f8f913a66db9d03762567d4632381f2&w=740',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Contenedor en el centro para el contenido
            Center(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.9, // El 90% del ancho de la pantalla
                height: MediaQuery.of(context).size.height * 0.8, // El 80% del alto de la pantalla
                child: Card(
                  elevation: 8,
                  color: Colors.white70.withOpacity(0.9), // Color azul transparente
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '¡Bienvenido!',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue), // Cambia el color del texto a blanco
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Navegar a la página de inicio de sesión
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            // Cambia el color del texto a blanco
                            backgroundColor: Colors.blue, // Cambia el color de fondo del botón a azul
                          ),
                          child: const Text(
                            'Empezar',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white), // Cambia el color del texto a blanco
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
