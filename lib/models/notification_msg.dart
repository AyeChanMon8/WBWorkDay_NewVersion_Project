

import 'dart:convert';


class NotificationMsg {
  int id;
  String contents;
  String headings;
  String subTitle;
  bool selected;
  bool has_read;
  String create_date;
  String message_type;
  NotificationMsg({
     this.id = 0,
     this.contents = '',
     this.headings = '',
     this.subTitle = '',
     this.message_type = '',
     this.has_read =  false,
     this.create_date = '',
    this.selected = false,
  });

  NotificationMsg copyWith({
    int? id,
    String? contents,
    String? headings,
    String? subTitle,
    String? message_type,
    bool? read,
    String? reason,
    String? create_date,
    bool? selected
  }) {
    return NotificationMsg(
      id: id ?? this.id,
      contents: contents ?? this.contents,
      headings: headings ?? this.headings,
      subTitle: subTitle ?? this.subTitle,
      message_type: message_type ?? this.message_type,
      has_read: has_read ?? this.has_read,
      create_date: create_date ?? this.create_date,
      selected: selected ?? this.selected
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'contents': contents,
      'headings': headings,
      'subTitle': subTitle,
      'message_type': message_type,
      'has_read': has_read,
      'create_date': create_date,
    };
  }

  factory NotificationMsg.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return NotificationMsg(
      id: map['id'] ?? 0,
      contents: map['contents'] ?? '',
      headings: map['headings'] ?? '',
      subTitle: map['subTitle'] ?? '',
      message_type: map['message_type'] ?? 'noti',
      has_read: map['has_read'] ?? false,
      create_date: map['create_date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationMsg.fromJson(String source) =>
      NotificationMsg.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationMsg(id: $id, contents: $contents, headings: $headings,message_type:$message_type, read: $has_read,  create_date: $create_date)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NotificationMsg &&
        o.id == id &&
        o.contents == contents &&
        o.headings == headings &&
        o.subTitle == subTitle &&
        o.message_type == message_type &&
        o.has_read == has_read &&
        o.create_date == create_date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        contents.hashCode ^
        headings.hashCode ^
        message_type.hashCode ^
        subTitle.hashCode ^
        has_read.hashCode ^
        create_date.hashCode;
  }
}
