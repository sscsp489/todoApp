import 'dart:convert';

List<TodoItem> todoItemFromJson(String str) =>
    List<TodoItem>.from(json.decode(str).map((x) => TodoItem.fromJson(x)));

String todoItemToJson(List<TodoItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoItem {
  TodoItem({
    this.isDone = false,
    this.title,
    this.description,
    this.urgency = 0,
  });

  bool isDone;
  String title;
  String description;
  int urgency;

  factory TodoItem.fromJson(Map<String, dynamic> json) => TodoItem(
        isDone: json["isdone"] == null ? null : json["isdone"],
        title: json["title"] == null ? null : json["title"],
        description: json["desc"] == null ? null : json["desc"],
        urgency: json["urgency"] == null ? null : json["urgency"],
      );

  Map<String, dynamic> toJson() => {
        "isdone": isDone == null ? null : isDone,
        "title": title == null ? null : title,
        "desc": description == null ? null : description,
        "urgency": urgency == null ? null : urgency,
      };
}
