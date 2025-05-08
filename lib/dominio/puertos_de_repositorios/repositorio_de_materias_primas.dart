import '../entidades/materia_prima.dart';

abstract class RepositorioDeMateriasPrimas {
  Future<void> agregarMateriaPrima(MateriaPrima materiaPrima);
  Future<MateriaPrima?> obtenerMateriaPrimaPorId(int id);
  Future<List<MateriaPrima>> obtenerTodasLasMateriasPrimas();
}
