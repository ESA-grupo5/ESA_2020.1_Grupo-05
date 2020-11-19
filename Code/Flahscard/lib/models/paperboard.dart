class Paperboard {
  int id;
  int topicId;
  String front;
  String back;

  Paperboard({
    this.topicId,
    this.front,
    this.back,
  });
  Paperboard.withId({
    this.id,
    this.topicId,
    this.front,
    this.back,
  });

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['userId'] = topicId;
    map['front'] = front;
    map['back'] = back;

    return map;
  }

  factory Paperboard.fromMap(Map<String, dynamic> map) {
    return Paperboard.withId(
      id: map['id'],
      topicId: map['topicId'],
      front: map['front'],
      back: map['back'],
    );
  }
}
