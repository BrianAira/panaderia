import 'package:flutter/material.dart';
import '../../config/locator.dart';
import '../../dominio/entidades/materia_prima.dart';
import '../../dominio/puertos_de_repositorios/repositorio_de_materias_primas.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class PantallaListaMateriasPrimas extends StatefulWidget {
  const PantallaListaMateriasPrimas({super.key});

  @override
  State<PantallaListaMateriasPrimas> createState() =>
      _PantallaListaMateriasPrimasState();
}

class _PantallaListaMateriasPrimasState
    extends State<PantallaListaMateriasPrimas> {
  final repositorio = locator<RepositorioDeMateriasPrimas>();
  List<MateriaPrima> _materias = [];
  bool _cargando = true;

  Future<void> _cargarMaterias() async {
    final lista = await repositorio.obtenerTodasLasMateriasPrimas();
    setState(() {
      _materias = lista;
      _cargando = false;
    });
  }

  @override
  void initState() {
    super.initState();
    print('🔍 initState ejecutado');

    _cargarMaterias();
  }

  Future<void> imprimirRutaDB() async {
    final path = join(await getDatabasesPath(), 'panaderia.db');
    print('📁 Ruta de la base de datos SQLite: $path');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de materias primas')),
      body:
          _cargando
              ? const Center(child: CircularProgressIndicator())
              : _materias.isEmpty
              ? const Center(child: Text('No hay materias primas registradas.'))
              : ListView.builder(
                itemCount: _materias.length,
                itemBuilder: (context, index) {
                  final m = _materias[index];
                  return ListTile(
                    leading: const Icon(Icons.kitchen),
                    title: Text(m.descripcion),
                    subtitle: Text(
                      'Cantidad disponible: ${m.cantidadDisponible}',
                    ),
                    trailing: Text('ID: ${m.id}'),
                  );
                },
              ),
    );
  }
}
