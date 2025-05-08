import '../dominio/entidades/producto.dart';
import '../dominio/puertos_de_repositorios/repositorio_de_productos.dart';

class RepositorioDeProductosEnMemoria implements RepositorioDeProductos {
  final Map<int, Producto> _productos = {};

  @override
  Future<void> agregarProducto(Producto producto) async {
    _productos[producto.id] = producto;
  }

  @override
  Future<Producto?> obtenerProductoPorId(int id) async {
    return _productos[id];
  }

  @override
  Future<List<Producto>> obtenerTodosLosProductos() async {
    return _productos.values.toList();
  }
}
