import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.error,
    required this.message,
    required this.data,
  });

  bool error;
  String message;
  List<Datum> data;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    error: json["error"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  String id;
  List<String> field;
  End start;
  End end;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    field: List<String>.from(json["field"].map((x) => x)),
    start: End.fromJson(json["start"]),
    end: End.fromJson(json["end"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "field": List<dynamic>.from(field.map((x) => x)),
    "start": start.toJson(),
    "end": end.toJson(),
  };
}

class End {
  End({
    required this.x,
    required this.y,
  });

  int x;
  int y;

  factory End.fromJson(Map<String, dynamic> json) => End(
    x: json["x"],
    y: json["y"],
  );

  Map<String, dynamic> toJson() => {
    "x": x,
    "y": y,
  };
}
