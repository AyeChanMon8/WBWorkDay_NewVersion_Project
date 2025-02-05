import 'dart:convert';
import '../models/announcement_department.dart';
import '../models/announcement_employee.dart';
import '../models/announcement_position.dart';
import '../models/attachment.dart';
import '../models/company.dart';

class Announcement {
  int id;
  String name;
  String announcement_reason;
  String state;
  String requested_date;
  List<Attachment>? attachment_id;
  Company? company_id;
  bool is_announcement;
  String announcement_type;
  List<AnnouncementEmployee>? employee_ids;
  List<AnnouncementDepartment>? department_ids;
  List<AnnouncementPosition>? position_ids;
  String announcement;
  String date_start;
  String date_end;
  Announcement({
    this.id = 0,
    this.name = '',
    this.announcement_reason = '',
    this.state = '',
    this.requested_date = '',
    this.attachment_id,
    this.company_id,
    this.is_announcement = false,
    this.announcement_type = '',
    this.employee_ids,
    this.department_ids,
    this.position_ids,
    this.announcement = '',
    this.date_start = '',
    this.date_end = '',
  });

  Announcement copyWith({
    int? id,
    String? name,
    String? announcement_reason,
    String? state,
    String? requested_date,
    required List<Attachment> attachment_id,
    required Company company_id,
    bool? is_announcement,
    String? announcement_type,
    required List<AnnouncementEmployee> employee_ids,
    required List<AnnouncementDepartment> department_ids,
    required List<AnnouncementPosition> position_ids,
    String? announcement,
    String? date_start,
    String? date_end,
  }) {
    return Announcement(
      id: id ?? this.id,
      name: name ?? this.name,
      announcement_reason: announcement_reason ?? this.announcement_reason,
      state: state ?? this.state,
      requested_date: requested_date ?? this.requested_date,
      attachment_id: attachment_id ?? this.attachment_id,
      company_id: company_id ?? this.company_id,
      is_announcement: is_announcement ?? this.is_announcement,
      announcement_type: announcement_type ?? this.announcement_type,
      employee_ids: employee_ids ?? this.employee_ids,
      department_ids: department_ids ?? this.department_ids,
      position_ids: position_ids ?? this.position_ids,
      announcement: announcement ?? this.announcement,
      date_start: date_start ?? this.date_start,
      date_end: date_end ?? this.date_end,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'announcement_reason': announcement_reason,
      'state': state,
      'requested_date': requested_date,
      'attachment_id': attachment_id?.map((x) => x?.toMap())?.toList(),
      'company_id': company_id?.toMap(),
      'is_announcement': is_announcement,
      'announcement_type': announcement_type,
      'employee_ids': employee_ids?.map((x) => x?.toMap())?.toList(),
      'department_ids': department_ids?.map((x) => x?.toMap())?.toList(),
      'position_ids': position_ids?.map((x) => x?.toMap())?.toList(),
      'announcement': announcement,
      'date_start': date_start,
      'date_end': date_end,
    };
  }

  factory Announcement.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Announcement(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
      announcement_reason: map['announcement_reason'] ?? "",
      state: map['state'] ?? "",
      requested_date: map['requested_date'] ?? "",
      attachment_id: map['attachment_id'] == null
          ? null
          : List<Attachment>.from(
              map['attachment_id']?.map((x) => Attachment.fromMap(x))),
      company_id: Company.fromMap(map['company_id']),
      is_announcement: map['is_announcement']?? false,
      announcement_type: map['announcement_type'] ?? "",
      employee_ids: map['employee_ids'] == null
          ? null
          : List<AnnouncementEmployee>.from(
              map['employee_ids']?.map((x) => AnnouncementEmployee.fromMap(x))),
      department_ids: map['department_ids'] == null
          ? null
          : List<AnnouncementDepartment>.from(map['department_ids']
              ?.map((x) => AnnouncementDepartment.fromMap(x))),
      // position_ids: List<AnnouncementPosition>.from(
      //     map['position_ids']?.map((x) => AnnouncementPosition.fromMap(x))),
      announcement: map['announcement'] ?? "",
      date_start: map['date_start'] ?? "",
      date_end: map['date_end'] ?? "",
      position_ids: map['position_ids'] == null
          ? null
          : List<AnnouncementPosition>.from(
              map['position_ids']?.map((x) => AnnouncementPosition.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Announcement.fromJson(String source) =>
      Announcement.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Announcement(id: $id, name: $name, announcement_reason: $announcement_reason, state: $state, requested_date: $requested_date, attachment_id: $attachment_id, company_id: $company_id, is_announcement: $is_announcement, announcement_type: $announcement_type, employee_ids: $employee_ids, department_ids: $department_ids, position_ids: $position_ids, announcement: $announcement, date_start: $date_start, date_end: $date_end)';
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        announcement_reason.hashCode ^
        state.hashCode ^
        requested_date.hashCode ^
        attachment_id.hashCode ^
        company_id.hashCode ^
        is_announcement.hashCode ^
        announcement_type.hashCode ^
        employee_ids.hashCode ^
        department_ids.hashCode ^
        position_ids.hashCode ^
        announcement.hashCode ^
        date_start.hashCode ^
        date_end.hashCode;
  }
}
