import 'package:flutter/material.dart';

class PantallaDeCalendarioDePedidos extends StatelessWidget {
  const PantallaDeCalendarioDePedidos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calendario de Pedidos')),
      body: const Center(child: Text('Pantalla de Calendario de Pedidos')),
    );
  }
}
