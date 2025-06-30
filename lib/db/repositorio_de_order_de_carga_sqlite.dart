import 'package:sqflite/sqflite.dart';
import 'package:panaderia/db/database.dart';
import 'package:panaderia/dominio/entidades/orden_de_carga_de_materia_prima.dart';
import 'package:panaderia/dominio/entidades/materia_prima.dart';
import 'package:panaderia/dominio/puertos_de_repositorios/repositorio_de_orden_de_carga.dart';

class RepositorioDeOrdenDeCargaSQLite implements RepositorioDeOrdenDeCarga {
  @override
  Future<void> agregarOrden(OrdenDeCargaDeMateriaPrima orden) async {
    final db = await BaseDeDatos.database;
 
    // 1. Insertar la orden principal
    await db.insert(
      'ordenes_carga',
      {
        'id': orden.id,
        'fechaOrden': orden.fechaOrden.toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // 2. Insertar cada detalle relacionado con esta orden
    for (var detalle in orden.detalle) {
      await db.insert(
        'detalle_orden_carga',
        {
          'ordenId': orden.id,
          'materiaPrimaId': detalle.materiaPrima.id,
          'cantidad': detalle.cantidad,
        },
      );
    }
  }

  @override
  Future<List<OrdenDeCargaDeMateriaPrima>> obtenerTodasLasOrdenes() async {
    final db = await BaseDeDatos.database;

    // 1. Obtener todas las órdenes
    final List<Map<String, dynamic>> ordenesMap =
        await db.query('ordenes_carga');

    // 2. Iterar sobre cada orden para buscar sus detalles
    List<OrdenDeCargaDeMateriaPrima> ordenes = [];
    for (var ordenMap in ordenesMap) {
      final int ordenId = ordenMap['id'];

      final detallesMap = await db.query(
        'detalle_orden_carga',
        where: 'ordenId = ?',
        whereArgs: [ordenId],
      );

      // 3. Convertir cada detalle a MateriaPrimaDetalle
      List<MateriaPrimaDetalle> detalles = [];
      for (var d in detallesMap) {
        // Recuperar información de la materia prima
        final mpMap = await db.query(
          'materias_primas',
          where: 'id = ?',
          whereArgs: [d['materiaPrimaId']],
          limit: 1,
        );

        if (mpMap.isNotEmpty) {
          final materia = MateriaPrima(
            id: mpMap[0]['id'] as int ,
            descripcion: mpMap[0]['descripcion'] as String,
            cantidadDisponible: mpMap[0]['cantidadDisponible'] as int,
          );

          detalles.add(MateriaPrimaDetalle(
            materiaPrima: materia,
            cantidad: d['cantidad'] as int,
          ));
        }
      }

      // 4. Crear objeto orden con sus detalles
      ordenes.add(
        OrdenDeCargaDeMateriaPrima(
          id: ordenId,
          fechaOrden: DateTime.parse(ordenMap['fechaOrden']),
          detalle: detalles,
        ),
      );
    }

    return ordenes;
  }
}
