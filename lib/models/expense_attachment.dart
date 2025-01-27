

import 'dart:convert';

/// expense_line_id : 172
/// attachments : ["base64","base64","base64"]

// class Expense_attachment {
//   int _expenseLineId;
//   List<String> _attachments;
//   bool _attachment_exist;

//   int get expenseLineId => _expenseLineId;
//   List<String> get attachments => _attachments;

//   Expense_attachment({
//       int expenseLineId, 
//       List<String> attachments,bool attachment_exist}){
//     _expenseLineId = expenseLineId;
//     _attachments = attachments;
//     _attachment_exist = attachment_exist;
// }

//   Expense_attachment.fromJson(dynamic json) {
//     _expenseLineId = json['expense_line_id'];
//     _attachment_exist = json['attachment_exist'];
//     if (json["attachments"] != null) {
//       _attachments = [];
//       json["attachments"].forEach((v) {
//         print("attData");
//         print(v);
//         if(v=="false"||v==false){
//           print("falseData");
//         }else{
//           _attachments.add(v);
//         }

//       });
//     }

//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map['expense_line_id'] = _expenseLineId;
//     map['attachments'] = _attachments;
//     return map;
//   }

// }

class Expense_attachment {

  final int expenseLineId;
  final List<String> attachments;
  final bool attachment_exist;
  Expense_attachment({
    this.expenseLineId = 0,
    required this.attachments,
    this.attachment_exist = false,
  });

  Expense_attachment copyWith({
    int? expenseLineId,
    List<String>? attachments,
    bool? attachment_exist,
  }) {
    return Expense_attachment(
      expenseLineId: expenseLineId ?? this.expenseLineId,
      attachments: attachments ?? this.attachments,
      attachment_exist: attachment_exist ?? this.attachment_exist,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expenseLineId': expenseLineId,
      'attachments': attachments?.map((x) => x)?.toList(),
      'attachment_exist': attachment_exist
    };
  }

  factory Expense_attachment.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Expense_attachment(
      expenseLineId: map['expense_line_id'],
      attachment_exist: map['attachment_exist']?? false,
      attachments: [ map['attachments'][0]],
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense_attachment.fromJson(String source) =>
      Expense_attachment.fromMap(json.decode(source));

  @override
  String toString() => 'Expense_attachment(expenseLineId: $expenseLineId, attachment_exist: $attachment_exist, attachments: $attachments)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Expense_attachment && o.expenseLineId == expenseLineId && o.attachment_exist == attachment_exist && o.attachments == attachments;
  }

  @override
  int get hashCode => expenseLineId.hashCode ^ attachment_exist.hashCode ^ attachments.hashCode;
}