import 'package:flutter/material.dart';
import 'package:panaderia/config/locator.dart';
import 'package:panaderia/dominio/entidades/materia_prima.dart';
import 'package:panaderia/dominio/entidades/producto.dart';
import 'package:panaderia/dominio/puertos_de_repositorios/repositorio_de_materias_primas.dart';
import 'package:panaderia/dominio/puertos_de_repositorios/repositorio_de_productos.dart';

class PantallaAgregarProducto extends StatefulWidget {
  const PantallaAgregarProducto({super.key});

  @override
  State<PantallaAgregarProducto> createState() => _PantallaAgregarProductoState();
}

class _PantallaAgregarProductoState extends State<PantallaAgregarProducto> {
  final _nombreController = TextEditingController();
  final _precioController = TextEditingController();

  final _repositorioProductos = locator<RepositorioDeProductos>();
  final _repositorioMaterias = locator<RepositorioDeMateriasPrimas>();

  List<MateriaPrima> _todasLasMateriasPrimas = [];
  final List<MateriaPrimaRequerida> _materiasSeleccionadas = [];

  @override
  void initState() {
    super.initState();
    _cargarMateriasPrimas();
  }

  Future<void> _cargarMateriasPrimas() async {
    final materias = await _repositorioMaterias.obtenerTodasLasMateriasPrimas();
    setState(() {
      _todasLasMateriasPrimas = materias;
    });
  }

  void _agregarMateriaPrima() {
    if (_todasLasMateriasPrimas.isEmpty) return;

    setState(() {
      _materiasSeleccionadas.add(
        MateriaPrimaRequerida(
          materiaPrima: _todasLasMateriasPrimas.first,
          cantidad: 1,
        ),
      );
    });
  }

  void _guardarProducto() async {
    final nombre = _nombreController.text.trim();
    final precioStr = _precioController.text.trim();
    if (nombre.isEmpty || precioStr.isEmpty || _materiasSeleccionadas.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Complete todos los campos')),
      );
      return;
    }

    final precio = double.tryParse(precioStr);
    if (precio == null || precio <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Precio inválido')),
      );
      return;
    }

    final nuevoProducto = Producto(
      id: DateTime.now().millisecondsSinceEpoch,
      nombre: nombre,
      precio: precio,
      materiasPrimasRequeridas: _materiasSeleccionadas,
    );

    await _repositorioProductos.agregarProducto(nuevoProducto);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Producto agregado exitosamente')),
    );

    _nombreController.clear();
    _precioController.clear();
    setState(() {
      _materiasSeleccionadas.clear();
    });
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _precioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agregar Producto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre del producto'),
            ),
            TextField(
              controller: _precioController,
              decoration: const InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            const Text(
              'Materias primas necesarias:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _materiasSeleccionadas.length,
                itemBuilder: (context, index) {
                  final mpReq = _materiasSeleccionadas[index];

                  return Card(
                    child: ListTile(
                      title: DropdownButton<MateriaPrima>(
                        value: mpReq.materiaPrima,
                        isExpanded: true,
                        items: _todasLasMateriasPrimas.map((mp) {
                          return DropdownMenuItem<MateriaPrima>(
                            value: mp,
                            child: Text(mp.descripcion),
                          );
                        }).toList(),
                        onChanged: (mp) {
                          if (mp != null) {
                            setState(() {
                              _materiasSeleccionadas[index] = MateriaPrimaRequerida(
                                materiaPrima: mp,
                                cantidad: mpReq.cantidad,
                              );
                            });
                          }
                        },
                      ),
                      subtitle: Row(
                        children: [
                          const Text('Cantidad:'),
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: mpReq.cantidad > 1
                                ? () {
                                    setState(() {
                                      _materiasSeleccionadas[index] =
                                          MateriaPrimaRequerida(
                                        materiaPrima: mpReq.materiaPrima,
                                        cantidad: mpReq.cantidad - 1,
                                      );
                                    });
                                  }
                                : null,
                          ),
                          Text(mpReq.cantidad.toString()),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                _materiasSeleccionadas[index] =
                                    MateriaPrimaRequerida(
                                  materiaPrima: mpReq.materiaPrima,
                                  cantidad: mpReq.cantidad + 1,
                                );
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _materiasSeleccionadas.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: _agregarMateriaPrima,
              icon: const Icon(Icons.add),
              label: const Text('Agregar Materia Prima'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _guardarProducto,
              child: const Text('Guardar Producto'),
            )
          ],
        ),
      ),
    );
  }
}
