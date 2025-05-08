import 'package:flutter/material.dart';
import 'pantalla_de_ingreso_de_pedidos.dart';
import 'pantalla_de_ingreso_de_materias_primas.dart';
import 'pantalla_de_calendario_de_pedidos.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Panadería - Menú Principal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PantallaDeIngresoDePedidos(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size(250, 60)),
              child: const Text('Ingreso de Pedidos'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => const PantallaDeIngresoDeMateriasPrimas(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size(250, 60)),
              child: const Text('Ingreso de Materias Primas'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PantallaDeCalendarioDePedidos(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(minimumSize: const Size(250, 60)),
              child: const Text('Calendario de Pedidos'),
            ),
          ],
        ),
      ),
    );
  }
}
