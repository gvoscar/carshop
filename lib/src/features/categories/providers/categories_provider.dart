import 'package:carshop/src/models/category.dart';

abstract class CategoriesProvider {
  Future<List<Category>> cargarCategorias();
  Future<Category> agregarCategoria(Category category);
  Future<Category> actualizarCategoria(Category category);
  Future<Category> obtenerCategoria(String id);
}
