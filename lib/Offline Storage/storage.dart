import 'package:driver_car_pool_app/Model%20Classes/driver.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DriverStorage {
  static Future<Database> _initDriver() async {
    String path = await getDatabasesPath();
    return await openDatabase(
      join(path, 'driver.db'),
      onCreate: (db,version) async {
        return await db.execute(
          'CREATE TABLE driver (uid TEXT NOT NULL PRIMARY KEY, email TEXT NOT NULL, name TEXT NOT NULL, points INT NOT NULL, tripsCount INT NOT NULL)'
        );
      },
      version: 1,
    );
  }

  static Future addDriver(Driver driver) async {
    final driverDB = await _initDriver();
    await driverDB.insert(
      'driver',
      driver.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<Driver> readDriver() async {
    final driverDB = await _initDriver();
    final driver = await driverDB.query('driver');

    return Driver.fromJson(driver[0]);
  }

  static Future deleteDriver() async {
    final driverDB = await _initDriver();
    await driverDB.delete(
      'driver',
    );
  }
}

