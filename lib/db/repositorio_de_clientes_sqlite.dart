import 'package:panaderia/db/database.dart';
import 'package:panaderia/dominio/entidades/cliente.dart';
import 'package:panaderia/dominio/puertos_de_repositorios/repositorio_de_clientes.dart';
import 'package:sqflite/sql.dart';

class RepositorioDeClientesSqlite implements RepositorioDeClientes {
  
  @override
  Future<void> agregarCliente(Cliente cliente) async {
    final db = await BaseDeDatos.database;

    await db.insert(
      'clientes',
      {
        'id': cliente.id,
        'nombre': cliente.nombre,
        'direccion': cliente.direccion,
      },
      conflictAlgorithm: ConflictAlgorithm.replace, //sobreescribe si existe
    );

    print('📌 Cliente insertado: ${cliente.nombre}');

  }

  @override
  Future<Cliente?> obtenerClientePorId(int id) async {
    final db = await BaseDeDatos.database;

    final resultado = await db.query(
      'clientes',
      where: 'id=?',
      whereArgs: [id],
    );

    if (resultado.isNotEmpty) {
      final fila = resultado.first;
      return Cliente(
        id: fila['id'] as int,
        nombre: fila['nombre'] as String,
        direccion: fila['direccion'] as String,
      );
    }
    return null;
  }

  @override
  Future<List<Cliente>> obtenerTodosLosClientes() async {
    final db = await BaseDeDatos.database;

    final resultado = await db.query('clientes');

    return resultado.map((fila) {
      return Cliente(
        id: fila['id'] as int,
        nombre: fila['nombre'] as String,
        direccion: fila['direccion'] as String,
      );
    }).toList();
  }
}
