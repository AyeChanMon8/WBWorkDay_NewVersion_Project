import 'dart:convert';

/// folder_id : 5
/// folder_name : "HR"

// class Document_folder {
//   int _folderId;
//   String _folderName;

//   int get folderId => _folderId;
//   String get folderName => _folderName;

//   Document_folder({int folderId, String folderName}) {
//     _folderId = folderId;
//     _folderName = folderName;
//   }

//   Document_folder.fromJson(dynamic json) {
//     _folderId = json["folder_id"];
//     _folderName = json["folder_name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["folder_id"] = _folderId;
//     map["folder_name"] = _folderName;
//     return map;
//   }
// }

class Document_folder {
  final int folderId;
  final String folderName;
  Document_folder({
    this.folderId = 0,
    this.folderName = '',
  });

  Document_folder copyWith({
    int? folderId,
    String? folderName,
  }) {
    return Document_folder(
      folderId: folderId ?? this.folderId,
      folderName: folderName ?? this.folderName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'folder_id': folderId,
      'folder_name': folderName,
    };
  }

  factory Document_folder.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Document_folder(
      folderId: map['folder_id'],
      folderName: map['folder_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Document_folder.fromJson(String source) =>
      Document_folder.fromMap(json.decode(source));

  @override
  String toString() => 'Document_folder(folderId: $folderId, folderName: $folderName)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Document_folder && o.folderId == folderId && o.folderName == folderName;
  }

  @override
  int get hashCode => folderId.hashCode ^ folderName.hashCode;
}
