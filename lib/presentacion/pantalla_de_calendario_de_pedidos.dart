import 'package:flutter/material.dart';
import 'package:panaderia/dominio/puertos_de_repositorios/repositorio_de_pedidos.dart';
import 'package:panaderia/dominio/entidades/pedido.dart';
import 'package:panaderia/config/locator.dart';

class PantallaDeCalendarioDePedidos extends StatefulWidget {
  const PantallaDeCalendarioDePedidos({super.key});

  @override
  State<PantallaDeCalendarioDePedidos> createState() =>
      _PantallaDeCalendarioDePedidosState();
}

class _PantallaDeCalendarioDePedidosState
    extends State<PantallaDeCalendarioDePedidos> {
  final _repositorioPedidos = locator<RepositorioDePedidos>();
  List<Pedido> _pedidos = [];
  bool _cargando = true;

  Future<void> _cargarPedidos() async {
    final pedidos = await _repositorioPedidos.obtenerTodosLosPedidos();
    setState(() {
      _pedidos = pedidos;
      _cargando = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _cargarPedidos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendario de Pedidos')),
      body:
          _cargando
              ? const Center(child: CircularProgressIndicator())
              : _pedidos.isEmpty
              ? const Center(child: Text("No hay pedidos registrados."))
              : ListView.builder(
                itemCount: _pedidos.length,
                itemBuilder: (context, index) {
                  final pedido = _pedidos[index];
                  return ListTile(
                    title: Text(pedido.cliente.nombre),
                    subtitle: Text('Entrega: ${pedido.fecha.day}/${pedido.fecha.month}'),
                  );
                },
              ),
    );
  }
}
