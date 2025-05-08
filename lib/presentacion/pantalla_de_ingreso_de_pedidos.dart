import 'package:flutter/material.dart';

class PantallaDeIngresoDePedidos extends StatelessWidget {
  const PantallaDeIngresoDePedidos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ingreso de Pedidos')),
      body: const Center(child: Text('Pantalla de Ingreso de Pedidos')),
    );
  }
}
