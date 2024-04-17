// ignore: unused_import

import 'dart:developer';

import 'package:clientes_farmacias/dbhelper/constans.dart';
import 'package:clientes_farmacias/dbhelper/mongomodel.dart';


import 'package:mongo_dart/mongo_dart.dart';

class MongoDataBase{
  // ignore: prefer_typing_uninitialized_variables
  static var db , usercollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    usercollection = db.collection(USER_COLLECTION);
  }
  
static Future<String> insert(Mongodbmodel data) async {
    try {
      var result = await usercollection.insertOne(data.toJson());
      if (result.isSuccess){
        return "DATOS INSERTADOS";
      }else {
        return "ERROR INESPERADO";
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return(e.toString());
    }
  }
  static Future<bool> getuser(String name) async {
  usercollection = db!.collection(USER_COLLECTION);

  var arrData = await usercollection.findOne({"firtsname" : name});
  if (arrData != null){
    arrData = true;
  }else{
    arrData = false;
  }
  return arrData;

}

  static validateUser(String text, String text2) {}
  


  static Future<bool> validatelogin(String username, String password) async {
  usercollection = db!.collection(USER_COLLECTION);

  var userData = await usercollection.findOne({
    "firtsname": username,
    "lastname": password,
  });

  return userData != null;
}
  // Función para obtener clientes desde la base de datos y mostrarlos en un ListView
  static Future<List<Map<String, dynamic>>> obtenerClientes() async {
    // Conecta a la base de datos
    await connect();

    // Consulta todos los clientes
    var clientesCursor = await usercollection.find();

    // Lista para almacenar los clientes
    List<Map<String, dynamic>> farmacia = [];

    // Itera sobre los resultados y los agrega a la lista
    await for (var cliente in clientesCursor) {
      farmacia.add(cliente);
    }

    // Cierra la conexión
    await db!.close();

    // Retorna la lista de clientes
    return farmacia;
  }
  // ignore: prefer_typing_uninitialized_variables
  static var dt, productcollection;
  static agregarproc() async {
  try {
    dt = await Db.create(MONGO_CONN_URL);
    await dt.open();
    inspect(dt);
    productcollection = dt.collection(USER_PRODUCT);
    print('Conexión establecida y colección de productos inicializada correctamente.');
  } catch (e) {
    print('Error al conectar y inicializar la colección de productos: $e');
  }
}



  static Future<void> conectar() async {
  dt = await Db.create(MONGO_CONN_URL);
  await dt.open(); // Abre la conexión a la base de datos
  productcollection = dt.collection('productos');
}





 static Future<void> agregarProducto(Product producto) async {
  try {
    // Agregar la URL de la imagen al documento JSON
    Map<String, dynamic> productoJson = producto.toJson();
    productoJson['url'] = producto.url;

    await productcollection.insertOne(productoJson);
    // ignore: avoid_print
    print('Producto agregado correctamente: ${producto.nombre}');
  } catch (e) {
    // ignore: avoid_print
    print('Error al agregar producto: $e');
  }
}

 static Future<void> eliminarClientePorNombre(String nombre) async {
  try {
    // ignore: avoid_print
    print('Nombre del cliente a eliminar: $nombre'); // Impresión de depuración

    // Verificar la conexión a la base de datos
    if (usercollection == null) {
      // ignore: avoid_print
      print('Error: No se pudo establecer la conexión a la base de datos');
      return;
    }

    // Construir y ejecutar la consulta de eliminación por nombre
    await usercollection.remove({'firtsname': nombre});
    // ignore: avoid_print
    print('Cliente eliminado correctamente');
  } catch (e) {
    // ignore: avoid_print
    print('Error al eliminar cliente: $e');
  }

  // ignore: unused_element


}

static Future<List<Map<String, dynamic>>> obtenerProductos() async {
    try {
      await conectar(); // Aseguramos que la conexión esté abierta antes de obtener los productos
      var productosCursor = await productcollection.find();
      List<Map<String, dynamic>> productos = [];
      await for (var producto in productosCursor) {
        productos.add(producto);
      }
      return productos;
    } catch (e) {
      print('Error al obtener productos: $e');
      return [];
    }
  }
    // ignore: unused_element
 static Future<void> eliminarProductoPorNombre(String nombre) async {
    try {
      if (productcollection == null) {
        print('Error: No se pudo establecer la conexión a la colección de productos');
        return;
      }

      await productcollection.deleteMany({'nombre': nombre});
      print('Producto(s) eliminado(s) correctamente con el nombre: $nombre');
    } catch (e) {
      print('Error al eliminar producto por nombre: $e');
    }
  }

  
}

class Productos {
  final String nombre;
  final double precio;
  final int cantidad;
  final String url;

  Productos({required this.nombre, required this.precio, required this.cantidad, required this.url});

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'precio': precio,
      'cantidad': cantidad,
      'url': url,
    };
  }
  

  






  
}

