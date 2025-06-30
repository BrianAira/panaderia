import 'package:panaderia/db/database.dart';
import 'package:panaderia/dominio/entidades/cliente.dart';
import 'package:panaderia/dominio/entidades/pedido.dart';
import 'package:panaderia/dominio/entidades/producto.dart';
import 'package:panaderia/dominio/puertos_de_repositorios/repositorio_de_pedidos.dart';

class RepositorioDePedidosSqlite implements RepositorioDePedidos {
  @override
  Future<void> agregarPedido(Pedido pedido) async {
    final db = await BaseDeDatos.database;
    //insertar pedido
    await db.insert('pedidos', {
      'id': pedido.id,
      'fecha': pedido.fecha.toIso8601String(),
      'id_cliente': pedido.cliente.id,
    });

  
    for (final productoDetalle in pedido.detalleProductos) {
      
      await db.insert('detalle_pedidos', {
        'id_pedido': pedido.id,
        'id_producto': productoDetalle.producto.id,
        'cantidad': productoDetalle.cantidad,
      });
    }
  }

  @override
  Future<Pedido?> obtenerPedidoPorId(int id) async {
    final db = await BaseDeDatos.database;

    //obtener el pedido principal
    final pedidos = await db.query('pedidos', where: 'id=?', whereArgs: [id]);
    if (pedidos.isEmpty) return null;
    final pedidoMap = pedidos.first;

    //obtener cliente
    final clienteMap = await db.query(
      'clientes',
      where: 'id=?',
      whereArgs: [pedidoMap['id_cliente']],
    );
    final cliente = Cliente(
      id: clienteMap[0]['id'] as int,
      nombre: clienteMap[0]['nombre'] as String,
      direccion: clienteMap[0]['direccion'] as String,
    );
    // final cliente = Cliente(
    //   id: pedidoMap['id_cliente'] as int,
    //   nombre: 'Cliente 1',
    //   direccion: 'Direccion 1',
    // );

    final detalle = await db.query(
      'detalle_pedidos',
      where: 'id_pedido=?',
      whereArgs: [id],
    );

    final productos = <ProductoDetalle>[];

    for (final fila in detalle) {
      final productoId = fila['id_producto'] as int;
      final cantidad = fila['cantidad'] as int;
      final productoMap = await db.query(
        'productos',
        where: 'id=?',
        whereArgs: [productoId],
      );
      final producto = Producto(
        id:productoMap[0]['id'] as int,
        nombre: productoMap[0]['nombre'] as String,
        precio: productoMap[0]['precio'] as double,
        materiasPrimasRequeridas: [],
      );
      // final producto = Producto(
      //   id: productoId,
      //   nombre: 'Producto 1',
      //   precio: 0.0,
      //   materiasPrimasRequeridas: [],
      // );

      productos.add(ProductoDetalle(producto: producto, cantidad: cantidad));
    }
    return Pedido(
      id: id,
      fecha: DateTime.parse(pedidoMap['fecha'] as String),
      cliente: cliente,
      detalleProductos: productos,
    );
  }

  @override
  Future<List<Pedido>> obtenerTodosLosPedidos() async {
    final db = await BaseDeDatos.database;
    final pedidosMaps = await db.query('pedidos');

    final pedidos = <Pedido>[];

    for (final pedidoMap in pedidosMaps) {
      final pedido = await obtenerPedidoPorId(pedidoMap['id'] as int);
      if (pedido != null) pedidos.add(pedido);
    }
    return pedidos;
  }
}
