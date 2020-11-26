import 'package:Flahscard/constants.dart';
import 'package:Flahscard/database/database_helper.dart';
import 'package:Flahscard/models/subject.dart';

import 'dart:async';

class SubjectsCtr {
  DatabaseHelper con = new DatabaseHelper();

  Future<int> insertSubject(Subject subject) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("subjects", subject.toMap());
    return res;
  }

  Future<int> updateSubject(Subject subject) async {
    var db = await con.db;
    final int result = await db.update(
      'subjects',
      subject.toMap(),
      where: 'id = ?',
      whereArgs: [subject.id],
    );
    return result;
  }

  Future<int> deleteSubject(int id) async {
    var db = await con.db;
    final int result = await db.delete(
      'subjects',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<Subject> getSubject(int id) async {
    var dbClient = await con.db;
    var res = await dbClient.rawQuery(
        "SELECT * FROM subjects WHERE id = '${id.toString()}' AND userId = $userIdConstant");

    if (res.length > 0) {
      return new Subject.fromMap(res.first);
    }

    return null;
  }

  Future<List<Subject>> getAllSubjects() async {
    var dbClient = await con.db;
    final List<Map<String, dynamic>> result = await dbClient
        .rawQuery("SELECT * FROM subjects WHERE userId = $userIdConstant");
    final List<Subject> subjects = [];
    result.forEach((subjectMap) {
      subjects.add(Subject.fromMap(subjectMap));
    });

    return subjects;
  }
}
