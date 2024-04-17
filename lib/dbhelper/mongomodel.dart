import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

Mongodbmodel mongodbmodelFromJson(String str) => Mongodbmodel.fromJson(json.decode(str));

String mongodbmodelToJson(Mongodbmodel data) => json.encode(data.toJson());

class Mongodbmodel {
  String firtsname;
  String lastname;

  Mongodbmodel({
    required this.firtsname,
    required this.lastname,
  });

  factory Mongodbmodel.fromJson(Map<String, dynamic> json) => Mongodbmodel(
    firtsname: json["firtsname"],
    lastname: json["lastname"],
  );

  Map<String, dynamic> toJson() => {
    "firtsname": firtsname,
    "lastname": lastname,
  };

  






}

class Product {
  final String nombre;
  final double precio;
  final int cantidad;
  final String url;

  Product({required this.nombre, required this.precio, required this.cantidad, required this.url});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      nombre: json['nombre'],
      precio: json['precio'],
      cantidad: json['cantidad'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'precio': precio,
      'cantidad': cantidad,
      'url': url,
    };
  }
}


class MongoDatabase {
  static late Db db;
  static late DbCollection productCollection;

  static Future<void> connect() async {
    db = await Db.create('mongodb://localhost:27017/my_database');
    await db.open();
    productCollection = db.collection('products');
  }

  static Future<void> insertProduct(Product product) async {
    try {
      await productCollection.insertOne(product.toJson());
      print('Producto agregado correctamente: ${product.nombre}');
    } catch (e) {
      print('Error al agregar producto: $e');
    }
  }

  static Future<List<Product>> getProducts() async {
    List<Product> products = [];
    var productsCursor = productCollection.find();
    await for (var product in productsCursor) {
      products.add(Product.fromJson(product));
    }
    return products;
  }

  static Future<void> deleteProduct(String nombre) async {
    try {
      await productCollection.deleteOne({'nombre': nombre});
      print('Producto eliminado correctamente: $nombre');
    } catch (e) {
      print('Error al eliminar producto: $e');
    }
  }
}


// To parse this JSON data, do
//
//     final mongodbmodel = mongodbmodelFromJson(jsonString);

class MongoService {
  static Db? db;
  static DbCollection? ventasCollection;

  static Future<void> connectToDatabase() async {
    try {
      db = await Db.create('mongodb+srv://Jl396911:Dukito11@cluster0.lgeba5y.mongodb.net/database?retryWrites=true&w=majority&appName=Cluster0');
      await db!.open();
      print('Conexión a la base de datos establecida.');

      ventasCollection = db!.collection('Ventas');
    } catch (e) {
      print('Error al conectar a la base de datos: $e');
    }
  }

  static Future<void> insertarVenta(Mongodbmodel3 venta) async {
    try {
      if (ventasCollection == null) {
        print('Error: No se pudo establecer la conexión a la colección de ventas');
        return;
      }

      await ventasCollection!.insertOne(venta.toJson());
      print('Venta agregada correctamente a la base de datos');
    } catch (e) {
      print('Error al agregar venta: $e');
    }
  }
}


Mongodbmodel3 insertarventas(String str) => Mongodbmodel3.fromJson(json.decode(str));

String  ventas(Mongodbmodel data) => json.encode(data.toJson());

class Mongodbmodel3 {
  String nombre;
  double precio;
  int cantidad;
  double total;

  Mongodbmodel3({
    required this.nombre,
    required this.precio,
    required this.cantidad,
    required this.total,
  });

  factory Mongodbmodel3.fromJson(Map<String, dynamic> json) => Mongodbmodel3(
        nombre: json["nombre"],
        precio: double.parse(json["precio"].toString()), // Convertir a double
        cantidad: json["cantidad"],
        total: double.parse(json["total"].toString()), // Convertir a double
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "precio": precio,
        "cantidad": cantidad,
        "total": total,
      };
}

