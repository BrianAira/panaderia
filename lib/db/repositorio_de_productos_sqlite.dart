import 'package:panaderia/db/database.dart';
import 'package:panaderia/dominio/entidades/materia_prima.dart';
import 'package:panaderia/dominio/entidades/producto.dart';
import 'package:panaderia/dominio/puertos_de_repositorios/repositorio_de_productos.dart';
import 'package:sqflite/sqflite.dart';

class RepositorioDeProductosSqlite implements RepositorioDeProductos {
  @override
  Future<void> agregarProducto(Producto producto) async {
    final db = await BaseDeDatos.database;

    await db.insert('productos', {
      'id': producto.id,
      'nombre': producto.nombre,
      'precio': producto.precio,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
    for (var mp in producto.materiasPrimasRequeridas) {
      await db.insert('producto_materia_prima', {
        'producto_id': producto.id,
        'materia_prima_id': mp.materiaPrima.id,
        'cantidad': mp.cantidad,
      });
    }
  }

  @override
  Future<Producto?> obtenerProductoPorId(int id) async {
    final db = await BaseDeDatos.database;

    final productoMap = await db.query(
      'productos',
      where: 'id=?',
      whereArgs: [id],
    );
    if (productoMap.isEmpty) return null;
    final materiaPrimaMaps = await db.query(
      'producto_materia_prima',
      where: 'producto_id=?',
      whereArgs: [id],
    );
    final materiasPrimasRequeridas = <MateriaPrimaRequerida>[];

    for (var mp in materiaPrimaMaps) {
      final materia = MateriaPrima(
        id: mp['materia_prima_id'] as int,
        descripcion: '',
        cantidadDisponible: 0,
      );

      materiasPrimasRequeridas.add(
        MateriaPrimaRequerida(
          materiaPrima: materia,
          cantidad: mp['cantidad'] as int,
        ),
      );
    }
    final prod = productoMap.first;

    return Producto(
      id: prod['id'] as int,
      nombre: prod['nombre'] as String,
      precio: prod['precio'] as double,
      materiasPrimasRequeridas: materiasPrimasRequeridas,
    );
  }

  @override
  Future<List<Producto>> obtenerTodosLosProductos() async {
    final db = await BaseDeDatos.database;
    final productosMap = await db.query('productos');

    final productos = <Producto>[];

    for (var prod in productosMap) {
      final id = prod['id'] as int;

      final materiaPrimaMaps = await db.query(
        'producto_materia_prima',
        where: 'producto_id=?',
        whereArgs: [id],
      );

      final materiasPrimasRequeridas =
          materiaPrimaMaps.map((mp) {
            return MateriaPrimaRequerida(
              materiaPrima: MateriaPrima(
                id: mp['materia_prima_id'] as int,
                descripcion: '',
                cantidadDisponible: 0,
              ),
              cantidad: mp['cantidad'] as int,
            );
          }).toList();
      productos.add(
        Producto(
          id: id,
          nombre: prod['nombre'] as String,
          precio: prod['precio'] as double,
          materiasPrimasRequeridas: materiasPrimasRequeridas,
        ),
      );
    }
    return productos;
  }
}
