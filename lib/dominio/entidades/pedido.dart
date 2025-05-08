import 'cliente.dart';
import 'producto.dart';

class ProductoDetalle {
  final Producto producto;
  final int cantidad;

  ProductoDetalle({required this.producto, required this.cantidad});
}

class Pedido {
  final int id;
  final DateTime fecha;
  final Cliente cliente;
  final List<ProductoDetalle> detalleProductos;

  Pedido({
    required this.id,
    required this.fecha,
    required this.cliente,
    required this.detalleProductos,
  });
}
