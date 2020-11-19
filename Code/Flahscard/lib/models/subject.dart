class Subject {
  int id;
  int userId;
  String name;

  Subject({this.userId, this.name});
  Subject.withId({this.id, this.userId, this.name});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['userId'] = userId;
    map['name'] = name;
    return map;
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject.withId(
      id: map['id'],
      userId: map['userId'],
      name: map['name'],
    );
  }
}
