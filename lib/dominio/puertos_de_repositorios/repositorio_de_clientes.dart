import '../entidades/cliente.dart';

abstract class RepositorioDeClientes {
  Future<void> agregarCliente(Cliente cliente);
  Future<Cliente?> obtenerClientePorId(int id);
  Future<List<Cliente>> obtenerTodosLosClientes();
  
}
