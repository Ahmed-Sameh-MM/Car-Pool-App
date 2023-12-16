import 'package:driver_car_pool_app/Model%20Classes/user.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserStorage {
  static Future<Database> _initUser() async {
    String path = await getDatabasesPath();
    return await openDatabase(
      join(path, 'user.db'),
      onCreate: (db,version) async {
        return await db.execute(
          'CREATE TABLE user (uid TEXT NOT NULL PRIMARY KEY, email TEXT NOT NULL, name TEXT NOT NULL, points INT NOT NULL, tripsCount INT NOT NULL)'
        );
      },
      version: 1,
    );
  }

  static Future addUser(User user) async {
    final userDB = await _initUser();
    await userDB.insert(
      'user',
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<User> readUser() async {
    final userDB = await _initUser();
    final user = await userDB.query('user');

    return User.fromJson(user[0]);
  }

  static Future deleteUser() async {
    final cardsDB = await _initUser();
    await cardsDB.delete(
      'user',
    );
  }
}

