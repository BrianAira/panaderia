import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BaseDeDatos {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;

    final path = join(await getDatabasesPath(), 'panaderia.db');

    await deleteDatabase(path); //Elimina la base de datos corrupta

    print('📂 Base de datos en: $path');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: _crearTablas, //Llama al metodo para crear las tablas
    );

    print('✅ Base de datos abierta exitosamente');
    return _db!;
  }

  static Future<void> _crearTablas(Database db, int version) async {
    await db.execute('''
    CREATE TABLE clientes (
      id INTEGER PRIMARY KEY,
      nombre TEXT,
      direccion TEXT
    )
  ''');

  await db.execute('''
    CREATE TABLE materias_primas (
      id INTEGER PRIMARY KEY,
      descripcion TEXT,
      cantidadDisponible INTEGER
    )
  ''');

  await db.execute('''
    CREATE TABLE productos (
      id INTEGER PRIMARY KEY,
      nombre TEXT,
      precio REAL
    )
  ''');

  await db.execute('''
    CREATE TABLE producto_materia_prima (
      producto_id INTEGER,
      materia_prima_id INTEGER,
      cantidad INTEGER
    )
  ''');

  await db.execute('''
    CREATE TABLE pedidos (
      id INTEGER PRIMARY KEY,
      fecha TEXT,
      id_cliente INTEGER
    )
  ''');

  await db.execute('''
    CREATE TABLE detalle_pedidos (
      id_pedido INTEGER,
      id_producto INTEGER,
      cantidad INTEGER
    )
  ''');

  await db.execute('''
    CREATE TABLE ordenes_carga (
      id INTEGER PRIMARY KEY,
      fechaOrden TEXT
    )
  ''');

  await db.execute('''
    CREATE TABLE detalle_orden_carga (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ordenId INTEGER,
      materiaPrimaId INTEGER,
      cantidad INTEGER,
      FOREIGN KEY (ordenId) REFERENCES ordenes_carga(id),
      FOREIGN KEY (materiaPrimaId) REFERENCES materias_primas(id)
    )
  ''');

  }
}
