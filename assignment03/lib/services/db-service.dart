// ignore_for_file: todo, avoid_print, library_prefixes, avoid_function_literals_in_foreach_calls, file_names, unused_import

import 'package:path/path.dart' as pathPackage;
import 'package:sqflite/sqflite.dart' as sqflitePackage;

class SQFliteDbService {
  late sqflitePackage.Database db;
  late String path;

  Future<void> getOrCreateDatabaseHandle() async {
    try {
      //TODO: Put your code here to complete this method.
      var databasesPath = await sqflitePackage.getDatabasesPath();
      path = pathPackage.join(databasesPath, 'stock_database.db');
      db = await sqflitePackage.openDatabase(
        path,
        onCreate: (sqflitePackage.Database db1, int version) async {
          await db1.execute(
            "CREATE TABLE Stocks(Symbol TEXT PRIMARY KEY, BookValue REAL, Name TEXT, Currency TEXT)",
          );
        },
        version: 1,
      );
    } catch (e) {
      print('SQFliteDbService getOrCreateDatabaseHandle: $e');
    }
  }

  Future<void> printAllStocksInDbToConsole() async {
    try {
      //TODO: Put your code here to complete this method.
      List<Map<String, dynamic>> listOfStocks = await getAllStocksFromDb();
      if (listOfStocks.isEmpty) {
        print('No records in the db');
      } else {
        listOfStocks.forEach((stock) {
          print(
              '{Symbol: ${stock['Symbol']}, Book Value: ${stock['BookValue']}, Name: ${stock['Name']}, Currency: ${stock['Currency']}}');
        });
      }
    } catch (e) {
      print('SQFliteDbService printAllStocksInDbToConsole: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllStocksFromDb() async {
    try {
      //TODO: Put your code here to complete this method.
      // Replace this return with valid data.
      final List<Map<String, dynamic>> listOfStocks = await db!.query('Stocks');
      return listOfStocks;
    } catch (e) {
      print('SQFliteDbService getAllStocksFromDb: $e');
      return <Map<String, dynamic>>[];
    }
  }

  Future<void> deleteDb() async {
    try {
      //TODO: Put your code here to implement this method.
      await sqflitePackage.deleteDatabase(path);
      print('Db deleted');
    } catch (e) {
      print('SQFliteDbService deleteDb: $e');
    }
  }

  Future<void> insertStock(Map<String, dynamic> stock) async {
    try {
      //TODO:
      //Put code here to insert a stock into the database.
      //Insert the Stock into the correct table.
      //Also specify the conflictAlgorithm.
      //In this case, if the same stock is inserted
      //multiple times, it replaces the previous data.
      await db!.insert(
        'Stocks',
        stock,
        conflictAlgorithm: sqflitePackage.ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('SQFliteDbService insertStock: $e');
    }
  }

  Future<void> updateStock(Map<String, dynamic> stock) async {
    try {
      //TODO:
      //Put code here to update stock info.
      await db!.update(
        'Stocks',
        stock,
        where: "city = ?",
        whereArgs: [stock['city']],
      );
    } catch (e) {
      print('SQFliteDbService updateStock: $e');
    }
  }

  Future<void> deleteStock(Map<String, dynamic> stock) async {
    try {
      //TODO:
      //Put code here to delete a stock from the database.
      await db!.delete(
        'Stocks',
        where: "city = ?",
        whereArgs: [stock['city']],
      );
    } catch (e) {
      print('SQFliteDbService deleteStock: $e');
    }
  }
}
