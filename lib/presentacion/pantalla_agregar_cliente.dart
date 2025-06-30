import 'package:flutter/material.dart';
import 'package:panaderia/config/locator.dart';
import 'package:panaderia/dominio/entidades/cliente.dart';
import 'package:panaderia/dominio/puertos_de_repositorios/repositorio_de_clientes.dart';

class PantallaAgregarCliente extends StatefulWidget {
  const PantallaAgregarCliente({super.key});

  @override
  State<PantallaAgregarCliente> createState() => _PantallaAgregarClienteState();
}

class _PantallaAgregarClienteState extends State<PantallaAgregarCliente> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final _repositorioClientes = locator<RepositorioDeClientes>();

  void _guardarCliente() async {
    final nombre = _nombreController.text.trim();
    final direccion = _direccionController.text.trim();

    if (nombre.isEmpty || direccion.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor complete todos los campos')),
      );
      return;
    }

    final cliente = Cliente(
      id: DateTime.now().millisecondsSinceEpoch,
      nombre: nombre,
      direccion: direccion,
    );

    await _repositorioClientes.agregarCliente(cliente);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cliente agregado exitosamente')),
    );

    _nombreController.clear();
    _direccionController.clear();
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _direccionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Cliente')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nombre', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(hintText: 'Ej: Juan Pérez'),
            ),
            const SizedBox(height: 16),
            const Text('Dirección', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _direccionController,
              decoration: const InputDecoration(hintText: 'Ej: Calle Falsa 123'),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: _guardarCliente,
                icon: const Icon(Icons.save),
                label: const Text('Guardar Cliente'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
