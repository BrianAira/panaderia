import '../dominio/entidades/materia_prima.dart';
import '../dominio/puertos_de_repositorios/repositorio_de_materias_primas.dart';

class RepositorioDeMateriasPrimasEnMemoria
    implements RepositorioDeMateriasPrimas {
  final Map<int, MateriaPrima> _materiasPrimas = {};

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
