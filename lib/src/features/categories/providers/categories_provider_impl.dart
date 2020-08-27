import 'package:carshop/src/database/database.dart';
import 'package:carshop/src/features/categories/providers/categories_provider.dart';
import 'package:carshop/src/models/category.dart';

class CategoriesProviderImpl implements CategoriesProvider {
  CategoriesProviderImpl();

  @override
  Future<List<Category>> cargarCategorias() async {
    print('cargarCategorias');
    final lista = await DB.db.consultarCategorias();
    return lista;
  }

  @override
  Future<Category> agregarCategoria(Category category) async {
    print('agregarCategoria');
    int id = await DB.db.crearCategoria(category);
    return category;
  }

  @override
  Future<Category> actualizarCategoria(Category category) async {
    print('actualizarCategoria');
    await DB.db.actualizarCategoria(category);
    return category;
  }

  @override
  Future<Category> obtenerCategoria(String id) {
    // print('obtenerCategoria');
    final data = DB.db.consultarCategoria(id);
    return data;
  }
}
