import '../entidades/producto.dart';

abstract class RepositorioDeProductos {
  Future<void> agregarProducto(Producto producto);
  Future<Producto?> obtenerProductoPorId(int id);
  Future<List<Producto>> obtenerTodosLosProductos();
}
