import 'dart:convert';

class Reminder {
  dynamic? id;
  dynamic? description;
  String contents;
  dynamic? name;
  dynamic? lastReminder;
  List<AttachmentID>? attachment_ids;
  String create_date;
  bool selected;
  bool has_read;
  dynamic? noti_id;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  Reminder(
      {this.id = 0,
      this.description,
      this.contents = '',
      this.name,
      this.lastReminder,
      this.attachment_ids,
      this.create_date = '',
      this.selected = false,
      this.has_read = false,
      this.noti_id});

  Reminder copyWith({
    dynamic? id,
    dynamic? description,
    String? contents,
    dynamic? name,
    dynamic? lastReminder,
    List<AttachmentID>? attachment_ids,
    String? create_date,
    bool? selected,
    bool? has_read,
    dynamic? noti_id,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (description == null || identical(description, this.description)) &&
        (contents == null || identical(contents, this.contents)) &&
        (name == null || identical(name, this.name)) &&
        (lastReminder == null || identical(lastReminder, this.lastReminder)) &&
        (attachment_ids == null ||
            identical(attachment_ids, this.attachment_ids)) &&
        (create_date == null || identical(create_date, this.create_date)) &&
        (selected == null || identical(selected, this.selected)) &&
        (has_read == null || identical(has_read, this.has_read)) &&
        (noti_id == null || identical(noti_id, this.noti_id))) {
      return this;
    }

    return new Reminder(
        id: id ?? this.id,
        description: description ?? this.description,
        contents: contents ?? this.contents,
        name: name ?? this.name,
        lastReminder: lastReminder ?? this.lastReminder,
        attachment_ids: attachment_ids ?? this.attachment_ids,
        create_date: create_date ?? this.create_date,
        selected: selected ?? this.selected,
        has_read: has_read ?? this.has_read,
        noti_id: noti_id ?? this.noti_id);
  }

  @override
  String toString() {
    return 'Reminder{id: $id, description: $description,contents: $contents,name: $name,lastReminder: $lastReminder,attachment_ids: $attachment_ids,create_date: $create_date,selected: $selected,has_read: $has_read,noti_id: $noti_id}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reminder &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          description == other.description &&
          contents == other.contents &&
          name == other.name &&
          lastReminder == other.lastReminder &&
          attachment_ids == other.attachment_ids &&
          create_date == other.create_date &&
          selected == other.selected &&
          has_read == other.has_read &&
          noti_id == other.noti_id);

  @override
  int get hashCode =>
      id.hashCode ^
      description.hashCode ^
      contents.hashCode ^
      name.hashCode ^
      lastReminder.hashCode ^
      attachment_ids.hashCode ^
      create_date.hashCode ^
      selected.hashCode ^
      has_read.hashCode ^
      noti_id.hashCode;

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return new Reminder(
      id: map['id'],
      description: map['description'],
      contents: map['contents'],
      name: map['name'],
      lastReminder: map['last_reminder'],
      attachment_ids: List<AttachmentID>.from(
         map['attachment_ids']?.map((x) => AttachmentID.fromMap(x))),
      create_date: map['create_date'] ?? "",
      selected: map['selected']?? false,
      has_read: map['has_read'],
      noti_id: map['noti_id'],
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'description': this.description,
      'contents': this.contents,
      'name': this.name,
      'last_reminder': this.lastReminder,
      'attachment_ids': this.attachment_ids,
      'create_date': this.create_date,
      'selected': this.selected,
      'has_read': this.has_read,
      'noti_id': this.noti_id
    } as Map<String, dynamic>;
  }

//</editor-fold>
}

// class Reminder {
//   dynamic id;
//   dynamic description;
//   String contents;
//   dynamic name;
//   dynamic lastReminder;
//   List<AttachmentID> attachment_ids;
//   String create_date;
//   bool selected;
//   bool has_read;
//   dynamic noti_id;
//   Reminder(
//       {this.id,
//       this.description,
//       this.attachment_ids,
//       this.contents,
//       this.name,
//       this.lastReminder,
//       this.create_date,
//       this.selected = false,
//       this.has_read,
//       this.noti_id});

//   Reminder copyWith(
//       {dynamic id,
//       dynamic description,
//       List<AttachmentID> attachment_ids,
//       String contents,
//       dynamic name,
//       dynamic lastReminder,
//       String create_date,
//       bool selected,
//       bool has_read,
//       dynamic noti_id}) {
//     return Reminder(
//         id: id ?? this.id,
//         description: description ?? this.description,
//         attachment_ids: attachment_ids ?? this.attachment_ids,
//         contents: contents ?? this.contents,
//         name: name ?? this.name,
//         lastReminder: lastReminder ?? this.lastReminder,
//         create_date: create_date ?? this.create_date,
//         selected: selected ?? this.selected,
//         has_read: has_read ?? this.has_read,
//         noti_id: noti_id ?? this.noti_id);
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'description': description,
//       'attachment_ids': attachment_ids?.map((x) => x?.toMap())?.toList(),
//       'contents': contents,
//       'name': name,
//       'last_reminder': lastReminder,
//       'create_date': create_date,
//       'has_read': has_read,
//       'noti_id': noti_id
//     };
//   }

//   factory Reminder.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return Reminder(
//         id: map['id'],
//         description: map['description'],
//         contents: map['contents'],
//         attachment_ids: List<AttachmentID>.from(
//             map['attachment_ids']?.map((x) => AttachmentID.fromMap(x))),
//         name: map['name'],
//         lastReminder: map['last_reminder'],
//         create_date: map['create_date'],
//         has_read: map['has_read'] ?? false,
//         noti_id: map['noti_id']);
//   }

//   String toJson() => json.encode(toMap());

//   factory Reminder.fromJson(String source) =>
//       Reminder.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Reminder(id: $id, description: $description, attachment_ids: $attachment_ids, contents: $contents, name: $name, lastReminder: $lastReminder,create_date: $create_date,has_read: $has_read,noti_id: $noti_id )';
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         description.hashCode ^
//         attachment_ids.hashCode ^
//         contents.hashCode ^
//         name.hashCode ^
//         lastReminder.hashCode ^
//         create_date.hashCode ^
//         noti_id.hashCode;
//   }
// }


class AttachmentID {
  int id;
  String name;
  String attach_file;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  AttachmentID({
    this.id = 0,
    this.name = '',
    this.attach_file = ''
  });

  AttachmentID copyWith({
    int? id,
    String? name,
    String? attach_file
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (attach_file == null || identical(attach_file, this.attach_file))) {
      return this;
    }

    return new AttachmentID(
      id: id ?? this.id,
      name: name ?? this.name,
      attach_file: attach_file ?? this.attach_file
    );
  }

  @override
  String toString() {
    return 'AttachmentID{id: $id, name: $name,attach_file: $attach_file}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttachmentID &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          attach_file == other.attach_file &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ attach_file.hashCode;

  factory AttachmentID.fromMap(Map<String, dynamic> map) {
    return new AttachmentID(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
      attach_file: map['attach_file'] ?? ""
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
      'attach_file': this.attach_file
    } as Map<String, dynamic>;
  }

//</editor-fold>
}

// class AttachmentID {
//   int id;
//   String name;
//   String attach_file;
//   AttachmentID({this.id, this.name, this.attach_file});

//   AttachmentID copyWith({int id, String attach_file, String name}) {
//     return AttachmentID(
//         id: id ?? this.id,
//         attach_file: attach_file ?? this.attach_file,
//         name: name ?? this.name);
//   }

//   Map<String, dynamic> toMap() {
//     return {'id': id, 'attach_file': attach_file, 'name': name};
//   }

//   factory AttachmentID.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return AttachmentID(
//         id: map['id'] ?? 0,
//         attach_file: map['attach_file'] ?? [],
//         name: map['name'] ?? '');
//   }

//   String toJson() => json.encode(toMap());

//   factory AttachmentID.fromJson(String source) =>
//       AttachmentID.fromMap(json.decode(source));

//   @override
//   String toString() =>
//       'AttachmentID(id: $id, attach_file: $attach_file, name: $name)';

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is AttachmentID &&
//         o.id == id &&
//         o.attach_file == attach_file &&
//         o.name == name;
//   }

//   @override
//   int get hashCode => id.hashCode ^ attach_file.hashCode ^ name.hashCode;
// }
