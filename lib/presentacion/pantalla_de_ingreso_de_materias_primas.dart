import 'package:flutter/material.dart';
import 'package:panaderia/config/locator.dart';
import 'package:panaderia/dominio/entidades/materia_prima.dart';
import 'package:panaderia/dominio/puertos_de_repositorios/repositorio_de_materias_primas.dart';
import 'package:panaderia/presentacion/pantalla_lista_materias_primas.dart';

class PantallaDeIngresoDeMateriasPrimas extends StatefulWidget {
  const PantallaDeIngresoDeMateriasPrimas({super.key});

  @override
  State<PantallaDeIngresoDeMateriasPrimas> createState() =>
      _PantallaDeIngresoDeMateriasPrimasState();
}

class _PantallaDeIngresoDeMateriasPrimasState
    extends State<PantallaDeIngresoDeMateriasPrimas> {
  final RepositorioDeMateriasPrimas repositorio =
      locator<RepositorioDeMateriasPrimas>();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController cantidadController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    
    void guardarMateriasPrimas() async {
      final descripcion = descripcionController.text.trim();
      final cantidadString = cantidadController.text.trim();
      if (descripcion.isEmpty || cantidadString.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Complete los campos")));
        return;
      }
      final int cantidad = int.parse(cantidadString);
      if (cantidad <= 0) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Cantidad invalida")));
        return;
      }
      final nuevaMateria = MateriaPrima(
        id: DateTime.now().millisecondsSinceEpoch,
        descripcion: descripcion,
        cantidadDisponible: cantidad,
      );
      await repositorio.agregarMateriaPrima(nuevaMateria);
      descripcionController.clear();
      cantidadController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Materia prima agregada')));
    }

    @override
    void dispose() {
      descripcionController.dispose();
      cantidadController.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Ingreso de Materias Primas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Descripcion',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(
                hintText: "ej: Haria000, azucar..",
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'cantidad disponible:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: cantidadController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Ej:500'),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                onPressed: guardarMateriasPrimas,
                label: Text('Guardar materia prima'),
              ),
            ),
            ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PantallaListaMateriasPrimas(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(minimumSize: const Size(250, 60)),
            child: const Text('Ver Materias Primas'),
          ),
          ],
        ),
      ),
    );
  }
}
