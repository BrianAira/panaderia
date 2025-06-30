

import 'package:panaderia/dominio/entidades/orden_de_carga_de_materia_prima.dart';

abstract class RepositorioDeOrdenDeCarga {
  Future<void> agregarOrden(OrdenDeCargaDeMateriaPrima orden);
  //Future<OrdenDeCargaDeMateriaPrima?> obtenerTodasLasOrdenes(int id);
  Future<List<OrdenDeCargaDeMateriaPrima>> obtenerTodasLasOrdenes();
}
