import '../dominio/entidades/materia_prima.dart';
import '../dominio/puertos_de_repositorios/repositorio_de_materias_primas.dart';

class RepositorioDeMateriasPrimasEnMemoria
    implements RepositorioDeMateriasPrimas {
  final Map<int, MateriaPrima> _materiasPrimas = {};

  RepositorioDeMateriasPrimasEnMemoria() {
    // Inicializar con materias primas de ejemplo
    inicializarMateriasPrimasDemo();
  }

  void inicializarMateriasPrimasDemo() {
    // Agregamos ingredientes básicos para productos de panadería
    agregarMateriaPrima(
      MateriaPrima(
        id: 1,
        descripcion: "Harina de trigo",
        cantidadDisponible: 50000,
      ),
    );
    agregarMateriaPrima(
      MateriaPrima(
        id: 2,
        descripcion: "Levadura fresca",
        cantidadDisponible: 2000,
      ),
    );
    agregarMateriaPrima(
      MateriaPrima(id: 3, descripcion: "Sal fina", cantidadDisponible: 5000),
    );
    agregarMateriaPrima(
      MateriaPrima(id: 4, descripcion: "Azúcar", cantidadDisponible: 10000),
    );
    agregarMateriaPrima(
      MateriaPrima(id: 5, descripcion: "Manteca", cantidadDisponible: 8000),
    );
    agregarMateriaPrima(
      MateriaPrima(id: 6, descripcion: "Huevos", cantidadDisponible: 500),
    );
    agregarMateriaPrima(
      MateriaPrima(id: 7, descripcion: "Leche", cantidadDisponible: 15000),
    );
    agregarMateriaPrima(
      MateriaPrima(
        id: 8,
        descripcion: "Frutas confitadas",
        cantidadDisponible: 3000,
      ),
    );
    agregarMateriaPrima(
      MateriaPrima(
        id: 9,
        descripcion: "Dulce de leche",
        cantidadDisponible: 5000,
      ),
    );
    agregarMateriaPrima(
      MateriaPrima(id: 10, descripcion: "Grasa", cantidadDisponible: 6000),
    );
  }

  @override
  Future<void> agregarMateriaPrima(MateriaPrima materiaPrima) async {
    _materiasPrimas[materiaPrima.id] = materiaPrima;
  }

  @override
  Future<MateriaPrima?> obtenerMateriaPrimaPorId(int id) async {
    return _materiasPrimas[id];
  }

  @override
  Future<List<MateriaPrima>> obtenerTodasLasMateriasPrimas() async {
    return _materiasPrimas.values.toList();
  }
}
