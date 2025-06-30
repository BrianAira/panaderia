import 'package:get_it/get_it.dart';
import 'package:panaderia/db/repositorio_de_clientes_sqlite.dart';
import 'package:panaderia/db/repositorio_de_order_de_carga_sqlite.dart';
import 'package:panaderia/db/repositorio_de_pedidos_sqlite.dart';
import 'package:panaderia/db/repositorio_de_productos_sqlite.dart';
import 'package:panaderia/dominio/puertos_de_repositorios/repositorio_de_orden_de_carga.dart';

// import '../adaptadores/repositorio_de_clientes_en_memoria.dart';
// import '../adaptadores/repositorio_de_productos_en_memoria.dart';
// import '../adaptadores/repositorio_de_materias_primas_en_memoria.dart';
// import '../adaptadores/repositorio_de_pedidos_en_memoria.dart';

import '../dominio/puertos_de_repositorios/repositorio_de_clientes.dart';
import '../dominio/puertos_de_repositorios/repositorio_de_productos.dart';
import '../dominio/puertos_de_repositorios/repositorio_de_materias_primas.dart';
import '../dominio/puertos_de_repositorios/repositorio_de_pedidos.dart';

import '../db/repositorio_de_materias_primas_sqlite.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Registramos los repositorios como singletons
  locator.registerLazySingleton<RepositorioDeClientes>(
    () => RepositorioDeClientesSqlite(),
    //  () => RepositorioDeClientesEnMemoria(),
  );

  locator.registerLazySingleton<RepositorioDeProductos>(
    () => RepositorioDeProductosSqlite(),
    //  () => RepositorioDeProductosEnMemoria(),
  );

  locator.registerLazySingleton<RepositorioDeMateriasPrimas>(
    () => RepositorioDeMateriasPrimasSQLite(),
    //() => RepositorioDeMateriasPrimasEnMemoria(),
  );

  locator.registerLazySingleton<RepositorioDePedidos>(
    () => RepositorioDePedidosSqlite(),
    //() => RepositorioDePedidosEnMemoria(),
  );

  locator.registerLazySingleton<RepositorioDeOrdenDeCarga>(
    ()=>RepositorioDeOrdenDeCargaSQLite(),
  );
}
