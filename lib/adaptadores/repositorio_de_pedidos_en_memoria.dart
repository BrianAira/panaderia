import '../dominio/entidades/pedido.dart';
import '../dominio/puertos_de_repositorios/repositorio_de_pedidos.dart';

class RepositorioDePedidosEnMemoria implements RepositorioDePedidos {
  final Map<int, Pedido> _pedidos = {};

  @override
  Future<void> agregarPedido(Pedido pedido) async {
    _pedidos[pedido.id] = pedido;
  }

  @override
  Future<Pedido?> obtenerPedidoPorId(int id) async {
    return _pedidos[id];
  }

  @override
  Future<List<Pedido>> obtenerTodosLosPedidos() async {
    return _pedidos.values.toList();
  }
}
