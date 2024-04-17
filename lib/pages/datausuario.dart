import 'package:clientes_farmacias/pages/salepages.dart';
import 'package:flutter/material.dart';


class VentasPage extends StatefulWidget {
  const VentasPage({Key? key}) : super(key: key);

  @override
  _VentasPageState createState() => _VentasPageState();
}

class _VentasPageState extends State<VentasPage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    QuienesSomosFarmacia(),
    CarritoPage(),
    ProductosPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pharmacy_rounded),
            label: 'Tu Farmacia',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Productos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}


class QuienesSomosFarmacia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiénes somos - Farmacia'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.local_pharmacy,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Quiénes somos',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Somos una farmacia comprometida con la salud y el bienestar de nuestros clientes. '
                'Ofrecemos una amplia gama de productos farmacéuticos y servicios para satisfacer '
                'las necesidades de la comunidad. Nuestro equipo está dedicado a brindar un '
                'servicio excepcional y asesoramiento experto para garantizar la salud y la '
                'satisfacción de nuestros clientes.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Farmacia App',
    home: QuienesSomosFarmacia(),
  ));
}




