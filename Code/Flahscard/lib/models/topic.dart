import 'package:flutter/material.dart';

class Topic {
  int id;
  int subjectId;
  String name;
  Color color;

  Topic({
    this.subjectId,
    this.name,
    this.color,
  });
  Topic.withId({
    this.id,
    this.subjectId,
    this.name,
    this.color,
  });

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['subjectId'] = subjectId;
    map['name'] = name;
    map['color'] = color.toString();
    return map;
  }

  factory Topic.fromMap(Map<String, dynamic> map) {
    String valueString = map['color'].split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    Color colorConverted = new Color(value);
    return Topic.withId(
      id: map['id'],
      subjectId: map['subjectId'],
      name: map['name'],
      color: colorConverted,
    );
  }
}
