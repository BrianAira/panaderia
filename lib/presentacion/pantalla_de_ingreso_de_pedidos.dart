import 'package:flutter/material.dart';
import 'package:panaderia/dominio/puertos_de_repositorios/repositorio_de_pedidos.dart';
import '../dominio/entidades/cliente.dart';
import '../dominio/entidades/producto.dart';
import '../dominio/entidades/pedido.dart';
import '../dominio/puertos_de_repositorios/repositorio_de_clientes.dart';
import '../dominio/puertos_de_repositorios/repositorio_de_productos.dart';
import '../config/locator.dart';

class PantallaDeIngresoDePedidos extends StatefulWidget {
  const PantallaDeIngresoDePedidos({super.key});

  @override
  State<PantallaDeIngresoDePedidos> createState() =>
      _PantallaDeIngresoDePedidosState();
}

class _PantallaDeIngresoDePedidosState
    extends State<PantallaDeIngresoDePedidos> {
  final _repositorioPedidos = locator<RepositorioDePedidos>();
  Cliente? _clienteSeleccionado;
  DateTime _fechaEntrega = DateTime.now().add(const Duration(days: 1));
  final List<ProductoDetalle> _productosPedidos = [];

  List<Cliente> _clientes = [];
  List<Producto> _productos = [];

  final _repositorioClientes = locator<RepositorioDeClientes>();
  final _repositorioProductos = locator<RepositorioDeProductos>();

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final clientes = await _repositorioClientes.obtenerTodosLosClientes();
    final productos = await _repositorioProductos.obtenerTodosLosProductos();

    setState(() {
      _clientes = clientes;
      _productos = productos;

      if (_clientes.isNotEmpty) {
        _clienteSeleccionado = _clientes.first;
      }
    });
  }

  void _agregarProducto() {
    if (_productos.isEmpty) return;

    setState(() {
      _productosPedidos.add(
        ProductoDetalle(producto: _productos.first, cantidad: 1),
      );
    });
  }

  void _eliminarProducto(int index) {
    setState(() {
      _productosPedidos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ingreso de Pedidos')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selector de cliente
            const Text(
              'Cliente:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton<Cliente>(
              value: _clienteSeleccionado,
              isExpanded: true,
              items:
                  _clientes.map((cliente) {
                    return DropdownMenuItem<Cliente>(
                      value: cliente,
                      child: Text(cliente.nombre),
                    );
                  }).toList(),
              onChanged: (cliente) {
                setState(() {
                  _clienteSeleccionado = cliente;
                });
              },
            ),

            const SizedBox(height: 16),

            // Selector de fecha
            const Text(
              'Fecha de entrega:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  '${_fechaEntrega.day}/${_fechaEntrega.month}/${_fechaEntrega.year}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  child: const Text('Cambiar fecha'),
                  onPressed: () async {
                    final nuevaFecha = await showDatePicker(
                      context: context,
                      initialDate: _fechaEntrega,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );

                    if (nuevaFecha != null) {
                      setState(() {
                        _fechaEntrega = nuevaFecha;
                      });
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Lista de productos
            const Text(
              'Productos:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _productosPedidos.length,
                itemBuilder: (context, index) {
                  final productoDetalle = _productosPedidos[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          // Selector de producto
                          Expanded(
                            flex: 2,
                            child: DropdownButton<Producto>(
                              value: productoDetalle.producto,
                              isExpanded: true,
                              items:
                                  _productos.map((producto) {
                                    return DropdownMenuItem<Producto>(
                                      value: producto,
                                      child: Text(producto.nombre),
                                    );
                                  }).toList(),
                              onChanged: (producto) {
                                if (producto != null) {
                                  setState(() {
                                    _productosPedidos[index] = ProductoDetalle(
                                      producto: producto,
                                      cantidad: productoDetalle.cantidad,
                                    );
                                  });
                                }
                              },
                            ),
                          ),

                          // Selector de cantidad
                          Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed:
                                      productoDetalle.cantidad > 1
                                          ? () {
                                            setState(() {
                                              _productosPedidos[index] =
                                                  ProductoDetalle(
                                                    producto:
                                                        productoDetalle
                                                            .producto,
                                                    cantidad:
                                                        productoDetalle
                                                            .cantidad -
                                                        1,
                                                  );
                                            });
                                          }
                                          : null,
                                ),
                                Text(productoDetalle.cantidad.toString()),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      _productosPedidos[index] =
                                          ProductoDetalle(
                                            producto: productoDetalle.producto,
                                            cantidad:
                                                productoDetalle.cantidad + 1,
                                          );
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),

                          // Botón eliminar
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _eliminarProducto(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Botón para agregar producto
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Agregar producto'),
                onPressed: _agregarProducto,
              ),
            ),

            const SizedBox(height: 16),

            // Botones de acción
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed:
                      _productosPedidos.isEmpty || _clienteSeleccionado == null
                          ? null
                          : () async{
                            // Aquí iría la lógica para guardar el pedido
                            final pedido = Pedido(
                              id: DateTime.now().millisecondsSinceEpoch,
                              fecha:_fechaEntrega,
                              cliente: _clienteSeleccionado!,
                              detalleProductos: _productosPedidos,
                            );

                            await _repositorioPedidos.agregarPedido(pedido);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Pedido creado exitosamente'),
                              ),
                            );
                            Navigator.of(context).pop();
                          },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text('Aceptar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
