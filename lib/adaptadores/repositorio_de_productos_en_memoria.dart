import '../dominio/entidades/producto.dart';
import '../dominio/puertos_de_repositorios/repositorio_de_productos.dart';
import '../dominio/puertos_de_repositorios/repositorio_de_materias_primas.dart';
import '../config/locator.dart';

class RepositorioDeProductosEnMemoria implements RepositorioDeProductos {
  final Map<int, Producto> _productos = {};
  late RepositorioDeMateriasPrimas _repositorioMateriasPrimas;

  RepositorioDeProductosEnMemoria() {
    // Obtenemos el repositorio de materias primas del locator
    _repositorioMateriasPrimas = locator<RepositorioDeMateriasPrimas>();
    // Inicializar con productos de ejemplo
    inicializarProductosDemo();
  }

  Future<void> inicializarProductosDemo() async {
    // Obtenemos todas las materias primas disponibles
    final materiasPrimas =
        await _repositorioMateriasPrimas.obtenerTodasLasMateriasPrimas();

    // Buscamos las materias primas por su ID
    final harina = materiasPrimas.firstWhere((mp) => mp.id == 1);
    final levadura = materiasPrimas.firstWhere((mp) => mp.id == 2);
    final sal = materiasPrimas.firstWhere((mp) => mp.id == 3);
    final azucar = materiasPrimas.firstWhere((mp) => mp.id == 4);
    final manteca = materiasPrimas.firstWhere((mp) => mp.id == 5);
    final huevos = materiasPrimas.firstWhere((mp) => mp.id == 6);
    final leche = materiasPrimas.firstWhere((mp) => mp.id == 7);
    final frutasConfitadas = materiasPrimas.firstWhere((mp) => mp.id == 8);
    final dulceDeLeche = materiasPrimas.firstWhere((mp) => mp.id == 9);
    final grasa = materiasPrimas.firstWhere((mp) => mp.id == 10);

    // Pan Francés
    await agregarProducto(
      Producto(
        id: 1,
        nombre: "Pan Francés",
        precio: 100.0,
        materiasPrimasRequeridas: [
          MateriaPrimaRequerida(materiaPrima: harina, cantidad: 500),
          MateriaPrimaRequerida(materiaPrima: levadura, cantidad: 20),
          MateriaPrimaRequerida(materiaPrima: sal, cantidad: 10),
          MateriaPrimaRequerida(materiaPrima: grasa, cantidad: 30),
        ],
      ),
    );

    // Medialunas
    await agregarProducto(
      Producto(
        id: 2,
        nombre: "Medialunas",
        precio: 120.0,
        materiasPrimasRequeridas: [
          MateriaPrimaRequerida(materiaPrima: harina, cantidad: 500),
          MateriaPrimaRequerida(materiaPrima: levadura, cantidad: 20),
          MateriaPrimaRequerida(materiaPrima: azucar, cantidad: 50),
          MateriaPrimaRequerida(materiaPrima: manteca, cantidad: 200),
          MateriaPrimaRequerida(materiaPrima: huevos, cantidad: 2),
        ],
      ),
    );

    // Pan de Molde
    await agregarProducto(
      Producto(
        id: 3,
        nombre: "Pan de Molde",
        precio: 180.0,
        materiasPrimasRequeridas: [
          MateriaPrimaRequerida(materiaPrima: harina, cantidad: 700),
          MateriaPrimaRequerida(materiaPrima: levadura, cantidad: 25),
          MateriaPrimaRequerida(materiaPrima: sal, cantidad: 15),
          MateriaPrimaRequerida(materiaPrima: manteca, cantidad: 50),
          MateriaPrimaRequerida(materiaPrima: leche, cantidad: 200),
        ],
      ),
    );

    // Rosca de Pascua
    await agregarProducto(
      Producto(
        id: 4,
        nombre: "Rosca de Pascua",
        precio: 500.0,
        materiasPrimasRequeridas: [
          MateriaPrimaRequerida(materiaPrima: harina, cantidad: 500),
          MateriaPrimaRequerida(materiaPrima: levadura, cantidad: 25),
          MateriaPrimaRequerida(materiaPrima: azucar, cantidad: 150),
          MateriaPrimaRequerida(materiaPrima: manteca, cantidad: 100),
          MateriaPrimaRequerida(materiaPrima: huevos, cantidad: 3),
          MateriaPrimaRequerida(materiaPrima: frutasConfitadas, cantidad: 100),
        ],
      ),
    );

    // Facturas
    await agregarProducto(
      Producto(
        id: 5,
        nombre: "Facturas",
        precio: 90.0,
        materiasPrimasRequeridas: [
          MateriaPrimaRequerida(materiaPrima: harina, cantidad: 400),
          MateriaPrimaRequerida(materiaPrima: levadura, cantidad: 20),
          MateriaPrimaRequerida(materiaPrima: azucar, cantidad: 80),
          MateriaPrimaRequerida(materiaPrima: manteca, cantidad: 150),
          MateriaPrimaRequerida(materiaPrima: huevos, cantidad: 2),
          MateriaPrimaRequerida(materiaPrima: dulceDeLeche, cantidad: 200),
        ],
      ),
    );
  }

  @override
  Future<void> agregarProducto(Producto producto) async {
    _productos[producto.id] = producto;
  }

  @override
  Future<Producto?> obtenerProductoPorId(int id) async {
    return _productos[id];
  }

  @override
  Future<List<Producto>> obtenerTodosLosProductos() async {
    return _productos.values.toList();
  }
}
