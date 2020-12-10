import 'package:Flahscard/database/controllers/paperboards_ctr.dart';
import 'package:Flahscard/database/database_helper.dart';
import 'package:Flahscard/models/topic.dart';

import 'dart:async';

class TopicsCtr {
  DatabaseHelper con = new DatabaseHelper();

  Future<int> insertTopic(Topic topic) async {
    var dbClient = await con.db;
    int res = await dbClient.insert("topics", topic.toMap());
    return res;
  }

  Future<int> updateTopic(Topic topic) async {
    var db = await con.db;
    final int result = await db.update(
      'topics',
      topic.toMap(),
      where: 'id = ?',
      whereArgs: [topic.id],
    );
    return result;
  }

  Future<int> deleteTopic(int id) async {
    var db = await con.db;
    final int result = await db.delete(
      'topics',
      where: 'id = ?',
      whereArgs: [id],
    );

    PaperboardsCtr paperboardsCtr = PaperboardsCtr();
    paperboardsCtr.getAllPaperboards(id).then(
          (topics) => topics.forEach(
            (topic) => paperboardsCtr.deletePaperboard(topic.id),
          ),
        );
    return result;
  }

  Future<Topic> getTopic(int id) async {
    var dbClient = await con.db;
    var res = await dbClient
        .rawQuery("SELECT * FROM topics WHERE id = '${id.toString()}'");

    if (res.length > 0) {
      return new Topic.fromMap(res.first);
    }
    return null;
  }

  Future<List<Topic>> getAllTopics(int subjectId) async {
    var dbClient = await con.db;
    final List<Map<String, dynamic>> result = await dbClient
        .rawQuery("SELECT * FROM topics WHERE subjectId = $subjectId");
    final List<Topic> topics = [];
    result.forEach((topicMap) {
      topics.add(Topic.fromMap(topicMap));
    });

    return topics;
  }

  Future<List<Topic>> getAllTopicsByName(String name) async {
    var dbClient = await con.db;
    final List<Map<String, dynamic>> result = await dbClient
        .rawQuery("SELECT * FROM topics WHERE name LIKE '%$name%'");
    final List<Topic> topics = [];
    result.forEach((topicMap) {
      topics.add(Topic.fromMap(topicMap));
    });

    return topics;
  }
}
