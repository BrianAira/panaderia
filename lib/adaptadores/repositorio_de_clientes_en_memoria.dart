import '../dominio/entidades/cliente.dart';
import '../dominio/puertos_de_repositorios/repositorio_de_clientes.dart';

class RepositorioDeClientesEnMemoria implements RepositorioDeClientes {
  final Map<int, Cliente> _clientes = {};

  @override
  Future<void> agregarCliente(Cliente cliente) async {
    _clientes[cliente.id] = cliente;
  }

  @override
  Future<Cliente?> obtenerClientePorId(int id) async {
    return _clientes[id];
  }

  @override
  Future<List<Cliente>> obtenerTodosLosClientes() async {
    return _clientes.values.toList();
  }
}
