class Debt {
  int id;
  String person;
  String description;
  double value;

  Debt(
      {required this.id,
      required this.person,
      required this.description,
      required this.value});

  factory Debt.fromJson(Map<String, dynamic> json) =>
      _debtsFromJson(json);

  Map<String, dynamic> toJson() => _debtsToJson(this);
}

Debt _debtsFromJson(Map<String, dynamic> json) {
  return Debt(
    id: json["id"],
    person: json["person"],
    description: json["description"],
    value: json["value"]
  );
}
// 2
Map<String, dynamic> _debtsToJson(Debt instance) =>
    <String, dynamic>{
      'id': instance.id,
      'person': instance.person,
      'description': instance.description,
      'value': instance.value,
    };

