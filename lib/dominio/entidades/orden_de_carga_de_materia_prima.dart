import 'materia_prima.dart';

class MateriaPrimaDetalle {
  final MateriaPrima materiaPrima;
  final int cantidad;

  MateriaPrimaDetalle({required this.materiaPrima, required this.cantidad});
}

class OrdenDeCargaDeMateriaPrima {
  final int id;
  final List<MateriaPrimaDetalle> detalle;
  final DateTime fechaOrden;

  OrdenDeCargaDeMateriaPrima({
    required this.id,
    required this.detalle,
    required this.fechaOrden,
  });
}
