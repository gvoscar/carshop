import 'package:carshop/src/features/categories/providers/categories_provider.dart';
import 'package:carshop/src/features/categories/providers/categories_provider_impl.dart';
import 'package:carshop/src/models/category.dart';
import 'package:rxdart/subjects.dart';

class CategoriesBloc {
  List<Category> _categorias;

  CategoriesBloc() {
    cargarCategorias();
  }

  final CategoriesProvider _provider = new CategoriesProviderImpl();
  final _categoriasController = new BehaviorSubject<List<Category>>();
  final _cargaController = new BehaviorSubject<bool>();

  Stream<List<Category>> get categoriasStream => _categoriasController.stream;
  Stream<bool> get cargaStream => _cargaController.stream;

  void cargarCategorias() async {
    _categorias = await _provider.cargarCategorias();
    _categoriasController.sink.add(_categorias);
  }

  List<Category> get categorias => _categorias;

  Future<Category> consultarCategoria(String id) {
    return _provider.obtenerCategoria(id);
  }

  void agregarCategoria(Category category) async {
    _cargaController.sink.add(true);
    await _provider.agregarCategoria(category);
    _cargaController.sink.add(false);
    cargarCategorias();
  }

  void actualizarCategoria(Category category) async {
    _cargaController.sink.add(true);
    await _provider.actualizarCategoria(category);
    _cargaController.sink.add(false);
    cargarCategorias();
  }

  dispose() {
    _categoriasController?.close();
    _cargaController?.close();
  }
}
