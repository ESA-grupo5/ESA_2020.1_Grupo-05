import 'package:Flahscard/database/database_helper.dart';
import 'package:Flahscard/models/user.dart';

import 'dart:async';

class LoginCtr {
  DatabaseHelper con = new DatabaseHelper();

  Future<int> saveUser(User user) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("users", user.toMap());
    return res;
  }

  Future<int> updateUser(User user) async {
    var db = await con.db;
    final int result = await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
    return result;
  }

  Future<int> deleteUser(int id) async {
    var db = await con.db;
    final int result = await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<User> getLogin(String email, String password) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM users WHERE email = '$email' and password = '$password'");
    if (res.length > 0) {
      return new User.fromMap(res.first);
    }

    return null;
  }

  Future<User> getUser(int id) async {
    var dbClient = await con.db;
    var res = await dbClient
        .rawQuery("SELECT * FROM users WHERE id = '${id.toString()}'");

    if (res.length > 0) {
      return new User.fromMap(res.first);
    }

    return null;
  }

  Future<List<User>> getAllUser() async {
    var dbClient = await con.db;
    final List<Map<String, dynamic>> result = await dbClient.query('users');
    final List<User> users = [];
    result.forEach((userMap) {
      users.add(User.fromMap(userMap));
    });

    return users;
  }
}
