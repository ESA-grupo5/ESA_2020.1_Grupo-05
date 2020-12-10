class Paperboard {
  int id;
  int topicId;
  String front;
  String back;
  int alreadyLearned;

  Paperboard({
    this.topicId,
    this.front,
    this.back,
    this.alreadyLearned,
  });
  Paperboard.withId({
    this.id,
    this.topicId,
    this.front,
    this.back,
    this.alreadyLearned,
  });

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['topicId'] = topicId;
    map['front'] = front;
    map['back'] = back;
    map['alreadyLearned'] = alreadyLearned;

    return map;
  }

  factory Paperboard.fromMap(Map<String, dynamic> map) {
    return Paperboard.withId(
        id: map['id'],
        topicId: map['topicId'],
        front: map['front'],
        back: map['back'],
        alreadyLearned: map['alreadyLearned']);
  }
}
