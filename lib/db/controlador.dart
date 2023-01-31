import 'dart:io';

import 'package:dogs_db_pseb_bridge/models/modelo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // database
  DatabaseHelper._privateConstructor(); // Name constructor to create instance of database
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // getter for database

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS
    // to store database

    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/basededatos1.db';

    // open/ create database at a given path
    var studentsDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

    return studentsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''Create TABLE movimientos (
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  categoria TEXT,
                  tipo TEXT,
                  concepto TEXT,
                  cantidad INTEGER,
                  fecha TEXT
                   )
    
    ''');
  }
  // insert
  void setModel(categoria,tipo,concepto,cantidad,fecha){
    Model().setBTC(categoria,tipo,concepto,cantidad,fecha);
    insert(Model());
  }
  void updModel(id,categoria,tipo,concepto,cantidad,fecha){
    Model().updModel(id, categoria,tipo,concepto,cantidad,fecha);
    update(Model());
  }
  Future<int> insert(Model obj) async {
    // add dog to table

    Database db = await instance.database;
    int result = await db.insert('movimientos', obj.toMap());
    return result;
  }

  // read operation
  Future<List<Model>> getAll() async {
    List<Model> orders = [];

    Database db = await instance.database;

    // read data from table
    List<Map<String, dynamic>> listMap = await db.query('movimientos');

    for (var x in listMap) {
      Model obj = Model.fromMap(x);
      orders.add(obj);
    }

    return orders;
  }


  // delete
  Future<int> delete(int id) async {
    Database db = await instance.database;
    int result = await db.delete('movimientos', where: 'id=?', whereArgs: [id]);
    return result;
  }

  // update
  Future<int> update(Model obj) async {
    Database db = await instance.database;
    int result = await db.update('movimientos', obj.toMap(), where: 'id=?', whereArgs: [obj.id]);
    return result;
  }

}
