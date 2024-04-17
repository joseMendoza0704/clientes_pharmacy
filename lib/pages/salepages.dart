import 'package:clientes_farmacias/pages/datausuario.dart';
import 'package:flutter/material.dart';
import 'package:clientes_farmacias/dbhelper/mondodb.dart';
import 'package:clientes_farmacias/dbhelper/mongomodel.dart';

class ProductosPage extends StatefulWidget {
  const ProductosPage({Key? key}) : super(key: key);

  @override
  _ProductosPageState createState() => _ProductosPageState();
}

class _ProductosPageState extends State<ProductosPage> {
  List<Map<String, dynamic>> _productos = [];

  @override
  void initState() {
    super.initState();
    _obtenerProductos();
  }

  Future<void> _obtenerProductos() async {
    List<Map<String, dynamic>> productos = await MongoDataBase.obtenerProductos();
    if (mounted) {
      setState(() {
        _productos = productos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Productos disponibles:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 0),
            Expanded(
              child: ListView.builder(
                itemCount: _productos.length,
                itemBuilder: (context, index) {
                  var producto = _productos[index];
                  return Card(
                    color: Colors.blue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 200, // Ajusta la altura de la imagen según sea necesario
                          child: Image.network(
                            producto['url'], // URL de la imagen del producto
                            fit: BoxFit.cover, // Ajusta la forma en que la imagen se ajusta dentro del contenedor
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                producto['nombre'],
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              SizedBox(height: 8),
                              Text('Precio: ${producto['precio']}', style: TextStyle(color: Colors.white)),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _agregarAlCarrito(producto);
                          },
                          
                          style: 
                          
                          ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            
                            
                          ),
                          
                          child: const Text(
                            'Comprar',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _agregarAlCarrito(Map<String, dynamic> producto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int cantidad = 1; // cantidad inicial
        return AlertDialog(
          title: const Text('Añadir al Carrito', style: TextStyle(color: Colors.blue)),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Cantidad'),
            onChanged: (value) {
              cantidad = int.tryParse(value) ?? 1;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                // Añadir el producto al carrito con la cantidad especificada
                producto['cantidad'] = cantidad;
                Carrito.agregarProducto(producto);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Agregar al Carrito',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CarritoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CarritoList(),
          ),
          ElevatedButton(
            onPressed: () {
              _realizarVenta(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              
            ),
            child: Text('Pagar', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _realizarVenta(BuildContext context) async {
    await VentasHelper.insertarVentasDesdeCarrito(Carrito.productosEnCarrito);
    Carrito.limpiarCarrito(); // Limpiar el carrito al realizar la venta
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Venta realizada con éxito'),
      ),
    );
    // Actualizar la página del carrito
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => CarritoPage()),
    );
  }
}

class CarritoList extends StatefulWidget {
  @override
  _CarritoListState createState() => _CarritoListState();
}

class _CarritoListState extends State<CarritoList> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> productosEnCarrito = Carrito.productosEnCarrito;
    double total = Carrito.calcularTotal();

    return ListView.builder(
      itemCount: productosEnCarrito.length + 1, // +1 para la fila de total
      itemBuilder: (context, index) {
        if (index == productosEnCarrito.length) {
          return ListTile(
            title: Text(
              'Total: \$${total.toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        } else {
          var producto = productosEnCarrito[index];
          return ListTile(
            title: Text(producto['nombre']),
            subtitle: Text('Cantidad: ${producto['cantidad']}'),
            leading: Image.network(
              producto['url'], // URL de la imagen del producto
              width: 50, // Ajusta el tamaño de la imagen según sea necesario
              height: 50,
              fit: BoxFit.cover, // Ajusta la forma en que la imagen se ajusta dentro del contenedor
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('\$${(producto['precio'] * producto['cantidad']).toStringAsFixed(2)}'),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      Carrito.eliminarProducto(producto);
                    });
                    // Actualizar la UI
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${producto['nombre']} eliminado del carrito'),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class VentasHelper {
  static Future<void> insertarVentasDesdeCarrito(List<Map<String, dynamic>> productosEnCarrito) async {
    try {
      // Realizar una copia de la lista de productos en el carrito
      List<Map<String, dynamic>> copiaProductos = List<Map<String, dynamic>>.from(productosEnCarrito);

      // Iterar sobre la copia de la lista de productos
      for (var producto in copiaProductos) {
        Mongodbmodel3 venta = Mongodbmodel3(
          nombre: producto['nombre'],
          precio: double.parse(producto['precio'].toString()),
          cantidad: int.parse(producto['cantidad'].toString()),
          total: double.parse((producto['precio'] * producto['cantidad']).toStringAsFixed(2)),
        );

        // Insertar la venta en la base de datos
        await MongoService.insertarVenta(venta);

        print('Venta insertada en la base de datos: ${venta.toJson()}');

        // Actualizar la cantidad de productos en la base de datos
        await _actualizarCantidadProducto(producto['nombre'], producto['cantidad']);
      }
    } catch (e) {
      print('Error al insertar ventas desde el carrito: $e');
    }
  }

  static Future<void> _actualizarCantidadProducto(String nombreProducto, int cantidadVendida) async {
    try {
      var producto = await MongoDataBase.productcollection.findOne({'nombre': nombreProducto});
      if (producto != null) {
        int cantidadActual = producto['cantidad'] ?? 0;
        int nuevaCantidad = cantidadActual - cantidadVendida;
        if (nuevaCantidad < 0) {
          nuevaCantidad = 0; // Asegurar que la cantidad no sea negativa
        }

        await MongoDataBase.productcollection.update({'nombre': nombreProducto}, {'\$set': {'cantidad': nuevaCantidad}});
        print('Cantidad de producto actualizada en la base de datos: $nombreProducto - $nuevaCantidad');
      } else {
        print('Producto no encontrado en la base de datos: $nombreProducto');
      }
    } catch (e) {
      print('Error al actualizar cantidad de producto: $e');
    }
  }
}

class Carrito {
  static List<Map<String, dynamic>> _productosEnCarrito = [];

  static void agregarProducto(Map<String, dynamic> producto) {
    // Agregar el producto al carrito con la URL de la imagen
    Map<String, dynamic> productoConImagen = {
      ...producto,
      'url': producto['url'], // URL de la imagen del producto
    };
    _productosEnCarrito.add(productoConImagen);
  }

  static void eliminarProducto(Map<String, dynamic> producto) {
    _productosEnCarrito.remove(producto);
  }

  static double calcularTotal() {
    double total = 0;
    for (var producto in _productosEnCarrito) {
      total += producto['precio'] * producto['cantidad'];
    }
    return total;
  }

  static List<Map<String, dynamic>> get productosEnCarrito => _productosEnCarrito;

  static void limpiarCarrito() {
    _productosEnCarrito.clear();
  }
}

void main() {
  runApp(MaterialApp(
    home: VentasPage(),
  ));
}

