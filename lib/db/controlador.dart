import 'dart:io';

import 'package:dogs_db_pseb_bridge/models/dog.dart';
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
    String path = '${directory.path}/btcs.db';

    // open/ create database at a given path
    var studentsDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

    return studentsDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''Create TABLE btcs (
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  tipo TEXT,
                  qtyBuy INTEGER,
                  qtySell INTEGER,
                  comision INTEGER,
                  fecha TEXT
                   )
    
    ''');
  }
  // insert
  void setBTC(tipo,qtyBuy,qtySell,comision,fecha){
    Bitcoin().setBTC(tipo,qtyBuy,qtySell,comision,fecha);
    insertOrder(Bitcoin());
  }
  void updBTC(id,tipo,qtyBuy,qtySell,comision,fecha){
    Bitcoin().updBTC(id, tipo,qtyBuy,qtySell,comision,fecha);
    updateBTC(Bitcoin());
  }
  Future<int> insertOrder(Bitcoin dog) async {
    // add dog to table

    Database db = await instance.database;
    int result = await db.insert('btcs', dog.toMap());
    return result;
  }

  // read operation
  Future<List<Bitcoin>> getAllOrders() async {
    List<Bitcoin> dogs = [];

    Database db = await instance.database;

    // read data from table
    List<Map<String, dynamic>> listMap = await db.query('btcs');

    for (var dogMap in listMap) {
      Bitcoin dog = Bitcoin.fromMap(dogMap);
      dogs.add(dog);
    }

    return dogs;
  }


  // delete
  Future<int> deleteDog(int id) async {
    Database db = await instance.database;
    int result = await db.delete('btcs', where: 'id=?', whereArgs: [id]);
    return result;
  }

  // update
  Future<int> updateBTC(Bitcoin btc) async {
    Database db = await instance.database;
    int result = await db.update('btcs', btc.toMap(), where: 'id=?', whereArgs: [btc.id]);
    return result;
  }

}
