import '../entidades/pedido.dart';

abstract class RepositorioDePedidos {
  Future<void> agregarPedido(Pedido pedido);
  Future<Pedido?> obtenerPedidoPorId(int id);
  Future<List<Pedido>> obtenerTodosLosPedidos();
}
