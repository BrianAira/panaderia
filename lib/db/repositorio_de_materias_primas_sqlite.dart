import 'package:sqflite/sqflite.dart';
import '../../dominio/entidades/materia_prima.dart';
import '../db/database.dart';
import '../../dominio/puertos_de_repositorios/repositorio_de_materias_primas.dart';

class RepositorioDeMateriasPrimasSQLite
    implements RepositorioDeMateriasPrimas {
  @override
  Future<void> agregarMateriaPrima(MateriaPrima materiaPrima) async {
    final db = await BaseDeDatos.database;
    await db.insert(
      'materias_primas',
      {
        'id': materiaPrima.id,
        'descripcion': materiaPrima.descripcion,
        'cantidadDisponible': materiaPrima.cantidadDisponible,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<MateriaPrima?> obtenerMateriaPrimaPorId(int id) async {
    final db = await BaseDeDatos.database;
    final maps = await db.query(
      'materias_primas',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      final m = maps.first;
      return MateriaPrima(
        id: m['id'] as int,
        descripcion: m['descripcion'] as String,
        cantidadDisponible: m['cantidadDisponible'] as int,
      );
    }
    return null;
  }

  @override
  Future<List<MateriaPrima>> obtenerTodasLasMateriasPrimas() async {
    final db = await BaseDeDatos.database;
    final maps = await db.query('materias_primas');

    return maps.map((m) {
      return MateriaPrima(
        id: m['id'] as int,
        descripcion: m['descripcion'] as String,
        cantidadDisponible: m['cantidadDisponible'] as int,
      );
    }).toList();
  }
}
