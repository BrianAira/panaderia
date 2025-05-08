import 'package:get_it/get_it.dart';

import '../adaptadores/repositorio_de_clientes_en_memoria.dart';
import '../adaptadores/repositorio_de_productos_en_memoria.dart';
import '../adaptadores/repositorio_de_materias_primas_en_memoria.dart';
import '../adaptadores/repositorio_de_pedidos_en_memoria.dart';

import '../dominio/puertos_de_repositorios/repositorio_de_clientes.dart';
import '../dominio/puertos_de_repositorios/repositorio_de_productos.dart';
import '../dominio/puertos_de_repositorios/repositorio_de_materias_primas.dart';
import '../dominio/puertos_de_repositorios/repositorio_de_pedidos.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Registramos los repositorios como singletons
  locator.registerLazySingleton<RepositorioDeClientes>(
    () => RepositorioDeClientesEnMemoria(),
  );

  locator.registerLazySingleton<RepositorioDeProductos>(
    () => RepositorioDeProductosEnMemoria(),
  );

  locator.registerLazySingleton<RepositorioDeMateriasPrimas>(
    () => RepositorioDeMateriasPrimasEnMemoria(),
  );

  locator.registerLazySingleton<RepositorioDePedidos>(
    () => RepositorioDePedidosEnMemoria(),
  );
}
