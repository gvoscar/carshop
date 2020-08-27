import 'dart:convert';

class Category {
  Category({this.id, this.name, this.read, this.write, this.edit});

  int id;
  String name;
  int read;
  int write;
  int edit;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        read: json["read"],
        write: json["write"],
        edit: json["edit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "read": read,
        "write": write,
        "edit": edit,
      };

  String toEncode() => '{'
      'id:$id,'
      'name:$name,'
      'read:$read,'
      'write:$write,'
      'edit:$edit'
      '}';
}
