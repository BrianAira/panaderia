import '../dominio/entidades/cliente.dart';
import '../dominio/puertos_de_repositorios/repositorio_de_clientes.dart';

class RepositorioDeClientesEnMemoria implements RepositorioDeClientes {
  final Map<int, Cliente> _clientes = {};

  RepositorioDeClientesEnMemoria() {
    // Inicializar con clientes de ejemplo
    inicializarClientesDemo();
  }

  void inicializarClientesDemo() {
    agregarCliente(
      Cliente(
        id: 1,
        nombre: "Panadería El Molino",
        direccion: "Av. Principal 123",
      ),
    );
    agregarCliente(
      Cliente(
        id: 2,
        nombre: "Cafetería La Esquina",
        direccion: "Calle 45 N° 678",
      ),
    );
    agregarCliente(
      Cliente(
        id: 3,
        nombre: "Restaurante Sabor Casero",
        direccion: "Blvd. Central 890",
      ),
    );
    agregarCliente(
      Cliente(id: 4, nombre: "Hotel Las Palmas", direccion: "Ruta 7 Km 5"),
    );
    agregarCliente(
      Cliente(
        id: 5,
        nombre: "Supermercado La Familia",
        direccion: "Av. Libertad 456",
      ),
    );
  }

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
