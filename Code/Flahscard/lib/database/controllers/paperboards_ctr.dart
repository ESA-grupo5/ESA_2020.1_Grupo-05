import 'package:Flahscard/database/controllers/topics_ctr.dart';
import 'package:Flahscard/database/database_helper.dart';
import 'package:Flahscard/models/paperboard.dart';

import 'dart:async';

import 'package:Flahscard/models/topic.dart';

class PaperboardsCtr {
  DatabaseHelper con = new DatabaseHelper();

  Future<int> insertPaperboard(Paperboard paperboard) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("paperboards", paperboard.toMap());
    return res;
  }

  Future<int> updatePaperboard(Paperboard paperboard) async {
    var db = await con.db;
    final int result = await db.update(
      'paperboards',
      paperboard.toMap(),
      where: 'id = ?',
      whereArgs: [paperboard.id],
    );
    return result;
  }

  Future<int> deletePaperboard(int id) async {
    var db = await con.db;
    final int result = await db.delete(
      'paperboards',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<Paperboard> getPaperboard(int id) async {
    var dbClient = await con.db;
    var res = await dbClient
        .rawQuery("SELECT * FROM paperboards WHERE id = '${id.toString()}'");

    if (res.length > 0) {
      return new Paperboard.fromMap(res.first);
    }
    return null;
  }

  Future<List<Paperboard>> getAllPaperboards(int topicId) async {
    var dbClient = await con.db;
    final List<Map<String, dynamic>> result = await dbClient
        .rawQuery("SELECT * FROM paperboards WHERE topicId = $topicId");
    final List<Paperboard> paperboards = [];
    result.forEach((paperboardMap) {
      paperboards.add(Paperboard.fromMap(paperboardMap));
    });

    return paperboards;
  }

  Future<List<Paperboard>> getPaperboardsByUser() async {
    TopicsCtr _topicCtr = TopicsCtr();
    List<Topic> topics = await _topicCtr.getTopicsByUser();
    List<Paperboard> cards = [];
    for (int i = 0; i < topics.length; i++) {
      await getAllPaperboards(topics[i].id)
          .then((value) => value.forEach((element) {
                cards.add(element);
              }));
    }
    return cards;
  }
}
