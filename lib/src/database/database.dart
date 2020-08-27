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
          'occupants INTEGER,'
          'price REAL,'
          'used INTEGER,'
          'model TEXT,'
          'createAt INTEGER,'
          'categoryId TEXT,'
          'extra TEXT,'
          'extraValue TEXT'
          ')');

      Category electrico = new Category();
      electrico.name = 'Eléctrico';
      electrico.write = 1;
      electrico.read = 1;
      electrico.edit = 0;

      await db.insert('Categories', electrico.toJson());

      Category camion = new Category();
      camion.name = 'Camión';
      camion.write = 1;
      camion.read = 1;
      camion.edit = 1;

      await db.insert('Categories', camion.toJson());

      Category comercial = new Category();
      comercial.name = 'Comercial';
      comercial.write = 1;
      comercial.read = 1;
      comercial.edit = 1;

      await db.insert('Categories', comercial.toJson());
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

  Future<int> actualizarCategoria(Category category) async {
    final db = await database;
    final res = await db.update('Categories', category.toJson(),
        where: 'id=?', whereArgs: [category.id]);
    return res;
  }

  Future<Category> consultarCategoria(String id) async {
    final db = await database;
    final res =
        await db.query('Categories', where: 'id=?', whereArgs: [int.parse(id)]);
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

  Future<int> actualizarVehiculo(Vehicle vehicle) async {
    final db = await database;
    final res = await db.update('Vehicles', vehicle.toJson(),
        where: 'id=?', whereArgs: [vehicle.id]);
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
