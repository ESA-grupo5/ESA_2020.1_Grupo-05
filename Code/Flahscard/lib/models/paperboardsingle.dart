class PaperboardSingle {
  int id;
  String termo;

  PaperboardSingle({
    this.id,
    this.termo,
  });
  PaperboardSingle.withId({
    this.id,
    this.termo,
  });

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['termo'] = termo;

    return map;
  }

  factory PaperboardSingle.fromMap(Map<String, dynamic> map) {
    return PaperboardSingle.withId(
      id: map['id'],
      termo: map['termo'],
    );
  }
}
