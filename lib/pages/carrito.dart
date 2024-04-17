class Carrito {
  static List<Map<String, dynamic>> _productosEnCarrito = [];

  static void agregarProducto(Map<String, dynamic> producto) {
    _productosEnCarrito.add(producto);
  }

  static double calcularTotal() {
    double total = 0;
    for (var producto in _productosEnCarrito) {
      total += producto['precio'] * producto['cantidad'];
    }
    return total;
  }

  static List<Map<String, dynamic>> get productosEnCarrito => _productosEnCarrito;
}
