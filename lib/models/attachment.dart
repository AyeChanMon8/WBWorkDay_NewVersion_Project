import 'dart:convert';

class Attachment {
  int id;
  String name;
  String type;
  String url;
  String datas;
  String mimetype;
  String index_content;
  Attachment({
    this.id = 0,
    this.name = '',
    this.type = '',
    this.url = '',
    this.datas = '',
    this.mimetype = '',
    this.index_content = '',
  });

  Attachment copyWith({
    int? id,
    String? name,
    String? type,
    String? url,
    String? datas,
    String? mimetype,
    String? index_content,
  }) {
    return Attachment(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      url: url ?? this.url,
      datas: datas ?? this.datas,
      mimetype: mimetype ?? this.mimetype,
      index_content: index_content ?? this.index_content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'url': url,
      'datas': datas,
      'mimetype': mimetype,
      'index_content': index_content,
    };
  }

  factory Attachment.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Attachment(
      id: map['id'] ?? 0,
      name: map['name']??"",
      type: map['type']??"",
      url: map['url']??"",
      datas: map['datas']??"",
      mimetype: map['mimetype']??"",
      index_content: map['index_content']??"",
    );
  }

  String toJson() => json.encode(toMap());

  factory Attachment.fromJson(String source) =>
      Attachment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Attachment(id: $id, name: $name, type: $type, url: $url, datas: $datas, mimetype: $mimetype, index_content: $index_content)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Attachment &&
        o.id == id &&
        o.name == name &&
        o.type == type &&
        o.url == url &&
        o.datas == datas &&
        o.mimetype == mimetype &&
        o.index_content == index_content;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        url.hashCode ^
        datas.hashCode ^
        mimetype.hashCode ^
        index_content.hashCode;
  }
}
