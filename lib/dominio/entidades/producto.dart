import 'materia_prima.dart';

class MateriaPrimaRequerida {
  final MateriaPrima materiaPrima;
  final int cantidad;

  MateriaPrimaRequerida({required this.materiaPrima, required this.cantidad});
}

class Producto {
  final int id;
  final String nombre;
  final double precio;
  final List<MateriaPrimaRequerida> materiasPrimasRequeridas;

  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.materiasPrimasRequeridas,
  });
}
