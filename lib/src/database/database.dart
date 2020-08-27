import 'dart:io';
import 'dart:math';

import 'package:carshop/src/models/category.dart';
import 'package:carshop/src/models/user.dart';
import 'package:carshop/src/models/vehicle.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DB {
  static Database _database;
  static final DB db = DB._();

  DB._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Users ('
          'id INTEGER PRIMARY KEY,'
          'email TEXT,'
          'password TEXT'
          ')');

      await db.execute('CREATE TABLE Categories ('
          'id INTEGER PRIMARY KEY,'
          'name TEXT,'
          'read INTEGER,'
          'write INTEGER,'
          'edit INTEGER'
          ')');

      await db.execute('CREATE TABLE Vehicles ('
          'id INTEGER PRIMARY KEY,'
          'photoUrl TEXT,'
          'price REAL,'
          'used INTEGER,'
          'model TEXT,'
          'createAt INTEGER,'
          'categoryId INTEGER'
          ')');
    });
  }

  Future<int> crearUsuario(User user) async {
    final db = await database;
    final res = await db.insert('Users', user.toJson());
    return res;
  }

  Future<User> consultarUsuario(String email) async {
    final db = await database;
    final res = await db.query('Users', where: 'email=?', whereArgs: [email]);
    return (res.isNotEmpty) ? User.fromJson(res.first) : null;
  }

  Future<int> crearCategoria(Category category) async {
    final db = await database;
    final res = await db.insert('Categories', category.toJson());
    return res;
  }

  Future<Category> consultarCategoria(String id) async {
    final db = await database;
    final res = await db.query('Categories', where: 'id=?', whereArgs: [id]);
    return (res.isNotEmpty) ? Category.fromJson(res.first) : null;
  }

  Future<List<Category>> consultarCategorias() async {
    final db = await database;
    final res = await db.query('Categories');
    List<Category> lista =
        res.isNotEmpty ? res.map((e) => Category.fromJson(e)).toList() : [];
    return lista;
  }

  Future<int> crearVehiculo(Vehicle vehicle) async {
    final db = await database;
    final res = await db.insert('Vehicles', vehicle.toJson());
    return res;
  }

  Future<List<Vehicle>> consultarVehiculos() async {
    final db = await database;
    final res = await db.query('Vehicles');
    List<Vehicle> lista =
        res.isNotEmpty ? res.map((e) => Vehicle.fromJson(e)).toList() : [];
    return lista;
  }
}
