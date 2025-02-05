import 'dart:convert';

import '../models/key_performance_attachment_ids.dart';
import '../models/pms_attachments.dart';
import '../models/rating_config.dart';

/// id : 15
/// name : "PE014"
/// state : "draft"
/// employee_id : {"id":6115,"name":"Ahr Yu"}
/// template_id : {"id":3,"name":"Sales Team"}
/// comp_template_id : {"id":2,"name":"A3 – Acceptability (လက်ခံနိုင်မှု)"}
/// mid_from_date : null
/// mid_to_date : null
/// end_from_date : null
/// end_to_date : null
/// date_range_id : {"id":5,"name":"2020-2021 Objective"}
/// date_start : "2020-10-01"
/// date_end : "2021-09-30"
/// deadline : "2021-01-16"
/// key_performance_ids : [{"id":58,"name":"Car","description":"Driving skil","weightage":0,"employee_rate":0,"employee_remark":null,"manager_rate":0,"manager_remark":null},{"id":59,"name":"Sales Amount","description":"Sale","weightage":0,"employee_rate":0,"employee_remark":null,"manager_rate":0,"manager_remark":null},{"id":60,"name":"Marketing","description":"Marketing","weightage":0,"employee_rate":0,"employee_remark":null,"manager_rate":0,"manager_remark":null}]
/// competencies_ids : [{"id":46,"name":"Teamwork","description":"Interacts effectively and builds respectful relationships within and between units and among individuals.","score":0,"comment":null},{"id":47,"name":"Adherence to Policy","description":"Follows rules of conduct, safety rules, other regulations, and adheres to company policies and procedures.","score":0,"comment":null},{"id":48,"name":"Execuation (PDCA)","description":"Carrying out of a plan, order, or course of action.","score":0,"comment":null},{"id":49,"name":"Management","description":"The process of dealing with or controlling things or people.","score":0,"comment":null},{"id":50,"name":"Collaboration","description":"The action of working with someone to produce something","score":0,"comment":null},{"id":51,"name":"360-degree feedback","description":"feedback from an employee's subordinates, colleagues, and supervisor(s)","score":0,"comment":null}]

class PMSDetailModel {
  int? id;
  String? name;
  String? state;
  Employee_id? employeeId;
  Template_id? templateId;
  Comp_template_id? compTemplateId;
  String? midFromDate;
  String? midToDate;
  String? endFromDate;
  String? endToDate;
  Date_range_id? dateRangeId;
  String? dateStart;
  String? dateEnd;
  // String _deadline;
  List<Key_performance_ids>? keyPerformanceIds;
  // List<KeyPerformanceAttachmentIds> _keyPerformanceAttachmentIds;
  List<Competencies_ids>? competenciesIds;
  Employee_id? job_id;
  double? competency_score;
  double? mid_competency_score;
  // double _kpi;
  // double _mid_kpi;
  int? what_final_rating;
  dynamic how_final_rating;
  dynamic final_rating;
  // bool _is_submitted;
  FinalRating? final_evaluation_rating;
  String? final_evaluation_description;
  FinalEvaluation? final_evaluation;
  dynamic mgrMidForceRanking;
  dynamic mgrAnnualForceRanking;
  HODForceRanking? hodMidForceRanking;
  HODForceRanking? hodAnnualForceRanking;
  bool? isRatingMatch;

  PMSDetailModel(
      {this.id = 0,
      this.name = '',
      this.state = '',
      this.employeeId,
      this.templateId,
      this.compTemplateId,
      this.midFromDate = '',
      this.midToDate = '',
      this.endFromDate = '',
      this.endToDate = '',
      this.dateRangeId,
      this.dateStart = '',
      this.dateEnd = '',
      // String _deadline;
      this.keyPerformanceIds,
      // List<KeyPerformanceAttachmentIds> _keyPerformanceAttachmentIds;
      this.competenciesIds,
      this.job_id,
      this.competency_score = 0.0,
      this.mid_competency_score = 0.0,
      // double _kpi;
      // double _mid_kpi;
      this.what_final_rating = 0,
      this.how_final_rating = 0,
      // bool _is_submitted;
      this.final_evaluation_rating,
      this.final_evaluation_description = '',
      this.final_rating,
      this.final_evaluation,
      this.mgrMidForceRanking,
      this.mgrAnnualForceRanking,
      this.hodMidForceRanking,
      this.hodAnnualForceRanking,
      this.isRatingMatch = true
      });

  PMSDetailModel copyWith({
    int? id,
    String? name,
    String? state,
    Employee_id? employeeId,
    Template_id? templateId,
    Comp_template_id? compTemplateId,
    String? midFromDate,
    String? midToDate,
    String? endFromDate,
    String? endToDate,
    Date_range_id? dateRangeId,
    String? dateStart,
    String? dateEnd,
    // String _deadline;
    List<Key_performance_ids>? keyPerformanceIds,
    // List<KeyPerformanceAttachmentIds> _keyPerformanceAttachmentIds;
    List<Competencies_ids>? competenciesIds,
    Employee_id? job_id,
    double? competency_score,
    double? mid_competency_score,
    // double _kpi;
    // double _mid_kpi;
    int? what_final_rating,
    int? how_final_rating,
    // bool _is_submitted;
    FinalRating? final_evaluation_rating,
    String? final_evaluation_description,
    FinalEvaluation? final_evaluation,
    dynamic mgrMidForceRanking,
    dynamic mgrAnnualForceRanking,
    HODForceRanking? hodMidForceRanking,
    HODForceRanking? hodAnnualForceRanking,
    bool? isRatingMatch,
    dynamic final_rating
  }) {
    return PMSDetailModel(
      id: id ?? this.id,
      name: name ?? this.name,
      state: state ?? this.state,
      employeeId: employeeId ?? this.employeeId,
      templateId: templateId ?? this.templateId,
      compTemplateId: compTemplateId ?? this.compTemplateId,
      midFromDate: midFromDate ?? this.midFromDate,
      midToDate: midToDate ?? this.midToDate,
      endFromDate: endFromDate ?? this.endFromDate,
      endToDate: endToDate ?? this.endToDate,
      dateRangeId: dateRangeId ?? this.dateRangeId,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      keyPerformanceIds: keyPerformanceIds ?? this.keyPerformanceIds,
      competenciesIds: competenciesIds ?? this.competenciesIds,
      job_id: job_id ?? this.job_id,
      competency_score: competency_score ?? this.competency_score,
      mid_competency_score: mid_competency_score ?? this.mid_competency_score,
      what_final_rating: what_final_rating ?? this.what_final_rating,
      how_final_rating: how_final_rating ?? this.how_final_rating,
      final_evaluation_rating:
          final_evaluation_rating ?? this.final_evaluation_rating,
      final_evaluation_description:
          final_evaluation_description ?? this.final_evaluation_description,
      final_evaluation: final_evaluation ?? this.final_evaluation,
      mgrMidForceRanking: mgrMidForceRanking ?? this.mgrMidForceRanking,
      mgrAnnualForceRanking: mgrAnnualForceRanking ?? this.mgrAnnualForceRanking,
      hodMidForceRanking: hodMidForceRanking ?? this.hodMidForceRanking,
      hodAnnualForceRanking: hodAnnualForceRanking ?? this.hodAnnualForceRanking,
      isRatingMatch: isRatingMatch ?? this.isRatingMatch,
      final_rating: final_rating ?? this.final_rating
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'state': state,
      'employee_id': employeeId?.toMap(),
      'performance_template_id': templateId?.toMap(),
      'competencies_template_id': compTemplateId?.toMap(),
      'mid_from_date': midFromDate,
      'mid_to_date': midToDate,
      'end_from_date': endFromDate,
      'end_to_date': endToDate,
      'date_range_id': dateRangeId?.toMap(),
      'date_start': dateStart,
      'date_end': dateEnd,
      'key_performance_ids':
          keyPerformanceIds?.map((x) => x?.toMap())?.toList(),
      'key_competencies_ids': competenciesIds?.map((x) => x?.toMap())?.toList(),
      'job_id': job_id?.toMap(),
      'competency_score': competency_score,
      'mid_competency_score': mid_competency_score,
      'what_final_rating': what_final_rating,
      'how_final_rating': how_final_rating,
      'final_evaluation_rating': final_evaluation_rating?.toMap(),
      'final_evaluation_description': final_evaluation_description,
      'final_evaluation': final_evaluation?.toMap(),
      'mgr_mid_force_ranking': mgrMidForceRanking,
      'mgr_anual_force_ranking': mgrAnnualForceRanking,
      'hod_mid_force_ranking': hodMidForceRanking?.toMap(),
      'hod_anual_force_ranking': hodAnnualForceRanking?.toMap(),
      'is_rating_match': isRatingMatch,
      'final_rating': final_rating
    };
  }

  PMSDetailModel.name();

  factory PMSDetailModel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return PMSDetailModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
      state: map['state'] ?? "",
      employeeId: Employee_id.fromMap(map['employee_id']),
      templateId: Template_id.fromMap(map['performance_template_id']),
      compTemplateId: Comp_template_id.fromMap(map['competencies_template_id']),
      midFromDate: map['mid_from_date'] ?? "",
      midToDate: map['mid_to_date'] ?? "",
      endFromDate: map['end_from_date'] ?? "",
      endToDate: map['end_to_date'] ?? "",
      dateRangeId: Date_range_id.fromMap(map['date_range_id']),
      dateStart: map['date_start'] ?? "",
      dateEnd: map['date_end'] ?? "",
      keyPerformanceIds: List<Key_performance_ids>.from(
          map['key_performance_ids']
              ?.map((x) => Key_performance_ids.fromMap(x))),
      competenciesIds: List<Competencies_ids>.from(
          map['key_competencies_ids']?.map((x) => Competencies_ids.fromMap(x))),
      job_id: Employee_id.fromMap(map['job_id']),
      competency_score: map['competency_score']?? 0.0,
      mid_competency_score: map['mid_competency_score']??0.0,
      what_final_rating: map['what_final_rating']?? 0,
      how_final_rating: map['how_final_rating']?? 0,
      // final_evaluation_rating:
      //     FinalRating.fromMap(map['final_evaluation_rating']),
      
      final_evaluation_rating: map['final_evaluation_rating'] != null
      ? FinalRating.fromMap(map['final_evaluation_rating'])
      : null,

      final_evaluation_description: map['final_evaluation_description']?? "",
      // final_evaluation:
      //     FinalEvaluation.fromMap(map['final_evaluation']),
      
      final_evaluation: map['final_evaluation'] != null
      ? FinalEvaluation.fromMap(map['final_evaluation'])
      : null,
      mgrMidForceRanking: map['mgr_mid_force_ranking'],
      mgrAnnualForceRanking: map['mgr_anual_force_ranking'],
      // hodMidForceRanking:
      //     HODForceRanking.fromMap(map['hod_mid_force_ranking']),
      
      hodMidForceRanking: map['hod_mid_force_ranking'] != null
      ? HODForceRanking.fromMap(map['hod_mid_force_ranking'])
      : null,

      // hodAnnualForceRanking:
      //     HODForceRanking.fromMap(map['hod_anual_force_ranking']),

      hodAnnualForceRanking: map['hod_anual_force_ranking'] != null
      ? HODForceRanking.fromMap(map['hod_anual_force_ranking'])
      : null,
      isRatingMatch: map['is_rating_match'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PMSDetailModel.fromJson(String source) =>
      PMSDetailModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'PMSDetailModel(id: $id, name: $name,state: $state, employeeId: $employeeId,templateId: $templateId, compTemplateId: $compTemplateId,midFromDate: $midFromDate, midToDate: $midToDate,endFromDate: $endFromDate, endToDate: $endToDate,dateRangeId: $dateRangeId, dateStart: $dateStart,dateEnd: $dateEnd, keyPerformanceIds: $keyPerformanceIds,competenciesIds: $competenciesIds, job_id: $job_id,competency_score: $competency_score, mid_competency_score: $mid_competency_score,what_final_rating: $what_final_rating, how_final_rating: $how_final_rating, final_evaluation_rating: $final_evaluation_rating,final_evaluation_description: $final_evaluation_description,final_evaluation: $final_evaluation,mgrMidForceRanking: $mgrMidForceRanking,mgrAnnualForceRanking: $mgrAnnualForceRanking,hodMidForceRanking: $hodMidForceRanking,hodAnnualForceRanking: $hodAnnualForceRanking,isRatingMatch: $isRatingMatch)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PMSDetailModel &&
        o.id == id &&
        o.name == name &&
        o.state == state &&
        o.employeeId == employeeId &&
        o.templateId == templateId &&
        o.compTemplateId == compTemplateId &&
        o.midFromDate == midFromDate &&
        o.midToDate == midToDate &&
        o.endFromDate == endFromDate &&
        o.endToDate == endToDate &&
        o.dateRangeId == dateRangeId &&
        o.dateStart == dateStart &&
        o.dateEnd == dateEnd &&
        o.keyPerformanceIds == keyPerformanceIds &&
        o.competenciesIds == competenciesIds &&
        o.job_id == job_id &&
        o.competency_score == competency_score &&
        o.mid_competency_score == mid_competency_score &&
        o.what_final_rating == what_final_rating &&
        o.how_final_rating == how_final_rating &&
        o.final_evaluation_rating == final_evaluation_rating &&
        o.final_evaluation_description == final_evaluation_description &&
        o.final_evaluation == final_evaluation &&
        o.final_rating == final_rating &&
        o.mgrMidForceRanking == mgrMidForceRanking &&
        o.mgrAnnualForceRanking == mgrAnnualForceRanking &&
        o.hodMidForceRanking == hodMidForceRanking &&
        hodAnnualForceRanking == hodAnnualForceRanking &&
        o.isRatingMatch == isRatingMatch;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      state.hashCode ^
      employeeId.hashCode ^
      templateId.hashCode ^
      compTemplateId.hashCode ^
      midFromDate.hashCode ^
      midToDate.hashCode ^
      endFromDate.hashCode ^
      endToDate.hashCode ^
      dateRangeId.hashCode ^
      dateStart.hashCode ^
      dateEnd.hashCode ^
      keyPerformanceIds.hashCode ^
      competenciesIds.hashCode ^
      job_id.hashCode ^
      competency_score.hashCode ^
      mid_competency_score.hashCode ^
      what_final_rating.hashCode ^
      how_final_rating.hashCode ^
      final_evaluation_rating.hashCode ^
      final_evaluation_description.hashCode ^
      final_evaluation.hashCode ^
      final_rating.hashCode ^
      mgrMidForceRanking.hashCode ^
      mgrAnnualForceRanking.hashCode ^
      hodMidForceRanking.hashCode ^
      hodAnnualForceRanking.hashCode ^
      isRatingMatch.hashCode;

  String startDate() {
    if (endFromDate != null &&
        DateTime.now().isAfter(DateTime.parse(midFromDate!)))
      return endFromDate!;
    else if (midFromDate != null) {
      return midFromDate!;
    }
    return dateStart!;
  }

  String endDate() {
    if (endToDate != null && DateTime.now().isAfter(DateTime.parse(midToDate!)))
      return endToDate!;
    else if (midToDate != null) {
      return midToDate!;
    }
    return dateEnd!;
  }
}

// class PMSDetailModel {
//   int _id;
//   String _name;
//   String _state;
//   Employee_id _employeeId;
//   Template_id _templateId;
//   Comp_template_id _compTemplateId;
//   String _midFromDate;
//   String _midToDate;
//   String _endFromDate;
//   String _endToDate;
//   Date_range_id _dateRangeId;
//   String _dateStart;
//   String _dateEnd;
//   // String _deadline;
//   List<Key_performance_ids> _keyPerformanceIds;
//   // List<KeyPerformanceAttachmentIds> _keyPerformanceAttachmentIds;
//   List<Competencies_ids> _competenciesIds;
//   Employee_id _job_id;
//   double _competency_score;
//   double _mid_competency_score;
//   // double _kpi;
//   // double _mid_kpi;
//   int _what_final_rating;
//   int _how_final_rating;
//   // bool _is_submitted;
//   FinalRating _final_evaluation_rating;
//   String _final_evaluation_description;

//   int get id => _id;
//   // bool get is_submitted => _is_submitted;
//   String get name => _name;
//   String get state => _state;
//   Employee_id get employeeId => _employeeId;
//   Template_id get templateId => _templateId;
//   Comp_template_id get compTemplateId => _compTemplateId;
//   String get midFromDate => _midFromDate;
//   String get midToDate => _midToDate;
//   String get endFromDate => _endFromDate;
//   String get endToDate => _endToDate;
//   Date_range_id get dateRangeId => _dateRangeId;
//   String get dateStart => _dateStart;
//   String get dateEnd => _dateEnd;
//   // String get deadline => _deadline ?? '';
//   List<Key_performance_ids> get keyPerformanceIds => _keyPerformanceIds;
//   // List<KeyPerformanceAttachmentIds> get keyPerformanceAttachmentIds =>
//   //     _keyPerformanceAttachmentIds;
//   List<Competencies_ids> get competenciesIds => _competenciesIds;
//   // double get kpi => _kpi;
//   // double get mid_kpi => _mid_kpi;
//   double get competency_score => _competency_score;
//   double get mid_competency_score => _mid_competency_score;
//   int get how_final_rating => _how_final_rating;
//   int get what_final_rating => _what_final_rating;
//   Employee_id get job_id => _job_id;
//   FinalRating get final_evaluation_rating => _final_evaluation_rating;
//   String get final_evaluation_description => _final_evaluation_description;

//   PMSDetailModel(
//       {int id,
//       String name,
//       String state,
//       Employee_id employeeId,
//       Template_id templateId,
//       Comp_template_id compTemplateId,
//       String midFromDate,
//       String midToDate,
//       String endFromDate,
//       String endToDate,
//       Date_range_id dateRangeId,
//       String dateStart,
//       String dateEnd,
//       // String deadline,
//       List<Key_performance_ids> keyPerformanceIds,
//       List<Competencies_ids> competenciesIds,
//       // double kpi,
//       // double mid_kpi,
//       double competency_score,
//       double mid_competency_score,
//       int what_final_rating,
//       int how_final_rating,
//       FinalRating final_evaluation_rating,
//       String final_evaluation_description}) {
//     _id = id;
//     _name = name;
//     _state = state;
//     _employeeId = employeeId;
//     _templateId = templateId;
//     _compTemplateId = compTemplateId;
//     _midFromDate = midFromDate;
//     _midToDate = midToDate;
//     _endFromDate = endFromDate;
//     _endToDate = endToDate;
//     _dateRangeId = dateRangeId;
//     _dateStart = dateStart;
//     _dateEnd = dateEnd;
//     // _deadline = deadline;
//     _keyPerformanceIds = keyPerformanceIds;
//     // _keyPerformanceAttachmentIds = keyPerformanceAttachmentIds;
//     _competenciesIds = competenciesIds;
//     // _kpi = kpi;
//     // _mid_kpi = mid_kpi;
//     _competency_score = competency_score;
//     _mid_competency_score = mid_competency_score;
//     _what_final_rating = what_final_rating;
//     _how_final_rating = how_final_rating;
//     _final_evaluation_rating = final_evaluation_rating;
//     _final_evaluation_description = final_evaluation_description;
//   }

//   PMSDetailModel.name();

//   PMSDetailModel.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"] ?? '';
//     _state = json["state"] ?? "draft";
//     _employeeId = json["employee_id"] != null
//         ? Employee_id.fromJson(json["employee_id"])
//         : null;
//     _templateId = json["performance_template_id"] != null
//         ? Template_id.fromJson(json["performance_template_id"])
//         : null;
//     _compTemplateId = json["competencies_template_id"] != null
//         ? Comp_template_id.fromJson(json["competencies_template_id"])
//         : null;
//     _midFromDate = json["mid_from_date"];
//     _midToDate = json["mid_to_date"];
//     _endFromDate = json["end_from_date"];
//     _endToDate = json["end_to_date"];
//     _dateRangeId = json["date_range_id"] != null
//         ? Date_range_id.fromJson(json["date_range_id"])
//         : null;
//     _dateStart = json["date_start"];
//     _dateEnd = json["date_end"];
//     // _deadline = json["deadline"];

//     _competency_score = json["competency_score"];
//     _mid_competency_score = json["mid_competency_score"];
//     // _kpi = json["kpi"];
//     // _mid_kpi = json["mid_kpi"];
//     _what_final_rating = json["what_final_rating"];
//     _how_final_rating = json["how_final_rating"];
//     // _is_submitted = json["is_submitted"] == null ? false : json["is_submitted"];
//     _job_id =
//         json["job_id"] != null ? Employee_id.fromJson(json["job_id"]) : null;

//     if (json["key_performance_ids"] != null) {
//       _keyPerformanceIds = [];
//       json["key_performance_ids"].forEach((v) {
//         _keyPerformanceIds.add(Key_performance_ids.fromJson(v));
//       });
//     }
//     // if (json["key_performance_attachment_ids"] != null) {
//     //   _keyPerformanceAttachmentIds = [];
//     //   json["key_performance_attachment_ids"].forEach((v) {
//     //     _keyPerformanceAttachmentIds.add(KeyPerformanceAttachmentIds.fromMap(v));
//     //   });
//     // }else{
//     //   _keyPerformanceAttachmentIds = [];
//     // }
//     if (json["key_competencies_ids"] != null) {
//       _competenciesIds = [];
//       json["key_competencies_ids"].forEach((v) {
//         _competenciesIds.add(Competencies_ids.fromJson(v));
//       });
//     }
//     // _final_evaluation_rating = json['final_evaluation_rating'];
//     _final_evaluation_rating = json["final_evaluation_rating"] != null
//         ? FinalRating.fromJson(json["final_evaluation_rating"])
//         : null;
//     _final_evaluation_description = json['final_evaluation_description'];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     map["state"] = _state;
//     if (_employeeId != null) {
//       map["employee_id"] = _employeeId.toJson();
//     }
//     if (_templateId != null) {
//       map["performance_template_id"] = _templateId.toJson();
//     }
//     if (_compTemplateId != null) {
//       map["competencies_template_id"] = _compTemplateId.toJson();
//     }
//     map["mid_from_date"] = _midFromDate;
//     map["mid_to_date"] = _midToDate;
//     map["end_from_date"] = _endFromDate;
//     map["end_to_date"] = _endToDate;
//     if (_dateRangeId != null) {
//       map["date_range_id"] = _dateRangeId.toJson();
//     }
//     map["what_final_rating"] = _what_final_rating;
//     map["date_start"] = _dateStart;
//     map["date_end"] = _dateEnd;
//     // map["deadline"] = _deadline;
//     if (_keyPerformanceIds != null) {
//       map["key_performance_ids"] =
//           _keyPerformanceIds.map((v) => v.toJson()).toList();
//     }
//     // if (_keyPerformanceAttachmentIds != null) {
//     //   map["key_performance_attachment_ids"] =
//     //       _keyPerformanceAttachmentIds.map((v) => v.toMap()).toList();
//     // }
//     if (_competenciesIds != null) {
//       map["key_competencies_ids"] =
//           _competenciesIds.map((v) => v.toJson()).toList();
//     }
//     if (_final_evaluation_rating != null) {
//       map["final_evaluation_rating"] = _final_evaluation_rating.toJson();
//     }
//     map["_final_evaluation_description"] = _final_evaluation_description;
//     return map;
//   }

//   String startDate() {
//     if (endFromDate != null &&
//         DateTime.now().isAfter(DateTime.parse(midFromDate)))
//       return endFromDate;
//     else if (midFromDate != null) {
//       return midFromDate;
//     }
//     return dateStart;
//   }

//   String endDate() {
//     if (endToDate != null && DateTime.now().isAfter(DateTime.parse(midToDate)))
//       return endToDate;
//     else if (midToDate != null) {
//       return midToDate;
//     }
//     return dateEnd;
//   }
// }

/// id : 46
/// name : "Teamwork"
/// description : "Interacts effectively and builds respectful relationships within and between units and among individuals."
/// score : 0
/// comment : null

class Competencies_ids {
  int id;
  String name;
  String description;
  double score;
  dynamic comment;
  Rating? rating;
  Rating? employee_rating;
  AssessRating? employee_assessment_rating;
  AssessRating? manager_assessment_rating;
  Competencies_ids(
      {this.id = 0,
      this.name = '',
      this.description = '',
      this.score = 0.0,
      this.comment,
      this.rating,
      this.employee_rating,
      this.employee_assessment_rating,
      this.manager_assessment_rating});

  Competencies_ids copyWith({
    int? id,
    String? name,
    String? description,
    double? score,
    dynamic comment,
    Rating? rating,
    Rating? employee_rating,
    AssessRating? employee_assessment_rating,
    AssessRating? manager_assessment_rating
  }) {
    return Competencies_ids(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        score: score ?? this.score,
        comment: comment ?? this.comment,
        rating: rating ?? this.rating,
        employee_rating: employee_rating ?? this.employee_rating,
        employee_assessment_rating: employee_assessment_rating ?? this.employee_assessment_rating,
        manager_assessment_rating: manager_assessment_rating ?? this.manager_assessment_rating);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'score': score,
      'comment': comment,
      'rating': rating?.toMap(),
      'employee_rating': employee_rating?.toMap(),
      'employee_assessment': employee_assessment_rating?.toMap(),
      'manager_assessment': manager_assessment_rating?.toMap(),
    };
  }

  factory Competencies_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Competencies_ids(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      score: map['score'],
      comment: map['comment'],
      rating: Rating.fromMap(map['rating']),
      employee_rating: Rating.fromMap(map['employee_rating']),
      // employee_assessment_rating: AssessRating.fromMap(map['employee_assessment']),
      
      employee_assessment_rating: map['employee_assessment'] != null 
    ? AssessRating.fromMap(map['employee_assessment']) 
    : null,
      // manager_assessment_rating: AssessRating.fromMap(map['manager_assessment']),

      manager_assessment_rating: map['manager_assessment'] != null 
    ? AssessRating.fromMap(map['manager_assessment']) 
    : null,
    );
  }

  void setScore(double score) {
    score = score;
  }

  void setComment(String comment) {
    comment = comment;
  }

  String toJson() => json.encode(toMap());

  factory Competencies_ids.fromJson(String source) =>
      Competencies_ids.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Competencies_ids(id: $id, name: $name, description: $description, score: $score, comment: $comment, rating: $rating, employee_rating: $employee_rating,employee_assessment_rating: $employee_assessment_rating,manager_assessment_rating: $manager_assessment_rating )';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Competencies_ids &&
        o.id == id &&
        o.name == name &&
        o.description == description &&
        o.score == score &&
        o.comment == comment &&
        o.rating == rating &&
        o.employee_rating == employee_rating &&
        o.employee_assessment_rating == employee_assessment_rating &&
        o.manager_assessment_rating == manager_assessment_rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        score.hashCode ^
        comment.hashCode ^
        rating.hashCode ^
        employee_rating.hashCode ^
        employee_assessment_rating.hashCode ^
        manager_assessment_rating.hashCode;
  }
}

// class Competencies_ids {
//   int _id;
//   String _name;
//   String _description;
//   double _score;
//   dynamic _comment;
//   Rating _rating;
//   Rating _employee_rating;

//   int get id => _id;
//   String get name => _name;
//   String get description => _description;
//   double get score => _score;
//   Rating get rating => _rating;
//   Rating get employee_rating => _employee_rating;
//   void setScore(double score) {
//     _score = score;
//   }

//   dynamic get comment => _comment ?? '';
//   void setComment(String comment) {
//     _comment = comment;
//   }

//   Competencies_ids({
//     int id,
//     String name,
//     String description,
//     double score,
//     dynamic comment,
//     Rating rating,
//     Rating employee_rating,
//   }) {
//     _id = id;
//     _name = name;
//     _description = description;
//     _score = score;
//     _comment = comment;
//     _rating = rating;
//     _employee_rating = employee_rating;
//   }

//   Competencies_ids.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     _description = json["description"];
//     _score = json["score"];
//     _comment = json["comment"];
//     _rating = json["rating"] != null ? Rating.fromJson(json["rating"]) : null;
//     _employee_rating = json["employee_rating"] != null
//         ? Rating.fromJson(json["employee_rating"])
//         : null;
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     map["description"] = _description;
//     map["score"] = _score;
//     map["comment"] = _comment;
//     if (_rating != null) {
//       map["rating"] = _rating.toJson();
//     }
//     if (_employee_rating != null) {
//       map["employee_rating"] = _employee_rating.toJson();
//     }
//     return map;
//   }
// }

/// id : 58
/// name : "Car"
/// description : "Driving skil"
/// weightage : 0
/// employee_rate : 0
/// employee_remark : null
/// manager_rate : 0
/// manager_remark : null

class Key_performance_ids {
  int id;
  String name;
  String description;
  int weightage;
  double employeeRate;
  dynamic? employeeRemark;
  double managerRate;
  dynamic? managerRemark;
  Rating? employeeRating;
  AssessRating? employeeAssessmentRating;
  Rating? managerRating;
  List<PMSattachments>? attachmentIds;
  AssessRating? managerAssessmentRating;
  Key_performance_ids(
      {this.id = 0,
      this.name = '',
      this.description = '',
      this.weightage = 0,
      this.employeeRate = 0.0,
      this.employeeRemark,
      this.managerRate = 0.0,
      this.managerRemark,
      this.employeeRating,
      this.managerRating,
      this.attachmentIds,
      this.employeeAssessmentRating,
      this.managerAssessmentRating
      });

  Key_performance_ids copyWith({
    int? id,
    String? name,
    String? description,
    int? weightage,
    double? employeeRate,
    dynamic? employeeRemark,
    double? managerRate,
    dynamic? managerRemark,
    Rating? employeeRating,
    Rating? managerRating,
    List<PMSattachments>? attachmentIds,
    AssessRating? employeeAssessmentRating,
    AssessRating? managerAssessmentRating
  }) {
    return Key_performance_ids(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      weightage: weightage ?? this.weightage,
      employeeRate: employeeRate ?? this.employeeRate,
      employeeRemark: employeeRemark ?? this.employeeRemark,
      managerRate: managerRate ?? this.managerRate,
      managerRemark: managerRemark ?? this.managerRemark,
      employeeRating: employeeRating ?? this.employeeRating,
      managerRating: managerRating ?? this.managerRating,
      attachmentIds: attachmentIds ?? this.attachmentIds,
      employeeAssessmentRating: employeeAssessmentRating ?? this.employeeAssessmentRating,
      managerAssessmentRating: managerAssessmentRating ?? this.managerAssessmentRating
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'weightage': weightage,
      'employee_remark': employeeRemark,
      'manager_remark': managerRemark,
      'employee_rating': employeeRating?.toMap(),
      'manager_rating': managerRating?.toMap(),
      'attachment_ids': attachmentIds?.map((x) => x?.toMap())?.toList(),
      'employee_assessment': employeeAssessmentRating?.toMap(),
      'manager_assessment': managerAssessmentRating?.toMap(),
    };
  }

  factory Key_performance_ids.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Key_performance_ids(
      id: map['id'],
      name: map['name'],
      description: map['description']??"",
      weightage: map['weightage'],
      employeeRemark: map['employee_remark'],
      managerRemark: map['manager_remark'],
      employeeRating: Rating.fromMap(map['employee_rating']),
      managerRating: Rating.fromMap(map['manager_rating']),
      // attachmentIds: List<PMSattachments>.from(
      //     map['attachment_ids']?.map((x) => PMSattachments.fromMap(x))), 
      attachmentIds: map['attachment_ids'] == null ? null : List<PMSattachments>.from(
          map['attachment_ids']?.map((x) => PMSattachments.fromMap(x))),
      // employeeAssessmentRating: AssessRating.fromMap(map['employee_assessment']),
      employeeAssessmentRating: map['employee_assessment'] != null 
    ? AssessRating.fromMap(map['employee_assessment']) 
    : null,
      // managerAssessmentRating: AssessRating.fromMap(map['manager_assessment']),
      managerAssessmentRating: map['manager_assessment'] != null 
    ? AssessRating.fromMap(map['manager_assessment']) 
    : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Key_performance_ids.fromJson(String source) =>
      Key_performance_ids.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Key_performance_ids(id: $id, name: $name, description: $description, weightage: $weightage, employeeRemark: $employeeRemark, managerRemark: $managerRemark, employeeRating: $employeeRating, managerRating: $managerRating, attachmentIds: $attachmentIds,employeeAssessmentRating: $employeeAssessmentRating,managerAssessmentRating: $managerAssessmentRating)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Key_performance_ids &&
        o.id == id &&
        o.name == name &&
        o.description == description &&
        o.weightage == weightage &&
        o.employeeRemark == employeeRemark &&
        o.managerRemark == managerRemark &&
        o.employeeRating == employeeRating &&
        o.managerRating == managerRating &&
        o.attachmentIds == attachmentIds &&
        o.employeeAssessmentRating == employeeAssessmentRating &&
        o.managerAssessmentRating == managerAssessmentRating;
  }

    void setemployeeRate(double rate) {
    employeeRate = rate;
  }

  void setemployeeRemark(String remark) {
    employeeRemark = remark;
  }

  void setManagerRate(double rate) {
    managerRate = rate;
  }

  void setManagerRemark(String remark) {
    managerRemark = remark;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        weightage.hashCode ^
        employeeRemark.hashCode ^
        managerRemark.hashCode ^
        employeeRating.hashCode ^
        managerRating.hashCode ^
        attachmentIds.hashCode ^
        employeeAssessmentRating.hashCode ^
        managerAssessmentRating.hashCode;
  }
}

// class Key_performance_ids {
//   int _id;
//   String _name;
//   String _description;
//   int _weightage;
//   double _employeeRate;
//   dynamic _employeeRemark;
//   double _managerRate;
//   dynamic _managerRemark;
//   Rating _employeeRating;
//   Rating _managerRating;
//   List<PMSattachments> _attachmentIds;

//   int get id => _id;
//   String get name => _name;
//   String get description => _description;
//   int get weightage => _weightage;
//   double get employeeRate => _employeeRate;
//   Rating get employeeRating => _employeeRating;
//   Rating get managerRating => _managerRating;
//   List<PMSattachments> get attachmentIds => _attachmentIds;
//   void setemployeeRate(double rate) {
//     _employeeRate = rate;
//   }

//   dynamic get employeeRemark => _employeeRemark ?? '';
//   void setemployeeRemark(String remark) {
//     _employeeRemark = remark;
//   }

//   double get managerRate => _managerRate;
//   void setManagerRate(double rate) {
//     _managerRate = rate;
//   }

//   dynamic get managerRemark => _managerRemark ?? '';
//   void setManagerRemark(String remark) {
//     _managerRemark = remark;
//   }

//   Key_performance_ids(
//       {int id,
//       String name,
//       String description,
//       int weightage,
//       double employeeRate,
//       dynamic employeeRemark,
//       double managerRate,
//       dynamic managerRemark,
//       List<PMSattachments> attachmentIds,
//       Rating employeeRating,
//       Rating managerRating}) {
//     _id = id;
//     _name = name;
//     _description = description;
//     _weightage = weightage;
//     _employeeRate = employeeRate;
//     _employeeRemark = employeeRemark;
//     _managerRate = managerRate;
//     _managerRemark = managerRemark;
//     _attachmentIds = attachmentIds;
//     _employeeRating = employeeRating;
//     _managerRating = managerRating;
//   }

//   Key_performance_ids.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//     _description = json["description"];
//     _weightage = json["weightage"];
//     _employeeRemark = json["employee_remark"];
//     _managerRemark = json["manager_remark"];
//     _employeeRating = json["employee_rating"] != null
//         ? Rating.fromJson(json["employee_rating"])
//         : null;
//     _managerRating = json["manager_rating"] != null
//         ? Rating.fromJson(json["manager_rating"])
//         : null;
//     if (json["attachment_ids"] != null) {
//       _attachmentIds = [];
//       json["attachment_ids"].forEach((v) {
//         _attachmentIds.add(PMSattachments.fromJson(v));
//       });
//     }
//     // if (json["attachment_ids"] != null) {
//     //   _attachmentIds = [];
//     //   json["attachment_ids"].forEach((v) {
//     //     print("attData");
//     //     print(v);
//     //     if(v=="false"||v==false){
//     //       print("falseData");
//     //     }else{
//     //       _attachmentIds.add(v);
//     //     }

//     //   });
//     // }
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     map["description"] = _description;
//     map["weightage"] = _weightage;
//     map["employee_remark"] = _employeeRemark;
//     map["manager_remark"] = _managerRemark;
//     // map["attachment_ids"] = _attachmentIds;
//     if (_attachmentIds != null) {
//       map["attachment_ids"] = _attachmentIds.map((v) => v.toJson()).toList();
//     }
//     if (_employeeRating != null) {
//       map["employee_rating"] = _employeeRating.toJson();
//     }
//     if (_managerRating != null) {
//       map["manager_rating"] = _managerRating.toJson();
//     }
//     return map;
//   }
// }

class Date_range_id {
  final int id;
  final String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Date_range_id({
    this.id = 0,
    this.name = '',
  });

  Date_range_id copyWith({
    int? id,
    String? name,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new Date_range_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'Date_range_id{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Date_range_id &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory Date_range_id.fromMap(Map<String, dynamic> map) {
    return new Date_range_id(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}

// class Date_range_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name ?? '';

//   Date_range_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Date_range_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }
// }

/// id : 2
/// name : "A3 – Acceptability (လက်ခံနိုင်မှု)"

class Comp_template_id {
  final int id;
  final String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Comp_template_id({
    this.id = 0,
    this.name = '',
  });

  Comp_template_id copyWith({
    int? id,
    String? name,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new Comp_template_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'Comp_template_id{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Comp_template_id &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory Comp_template_id.fromMap(Map<String, dynamic> map) {
    return new Comp_template_id(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}

// class Comp_template_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Comp_template_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Comp_template_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"] ?? "";
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }
// }

/// id : 3
/// name : "Sales Team"

class Template_id {
  final int id;
  final String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Template_id({
    this.id = 0,
    this.name = '',
  });

  Template_id copyWith({
    int? id,
    String? name,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new Template_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'Template_id{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Template_id &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory Template_id.fromMap(Map<String, dynamic> map) {
    return new Template_id(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}

// class Template_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Template_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Template_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"] ?? '';
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }
// }

/// id : 6115
/// name : "Ahr Yu"

class Employee_id {
  final int id;
  final String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Employee_id({
    this.id = 0,
    this.name = '',
  });

  Employee_id copyWith({
    int? id,
    String? name,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new Employee_id(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'Employee_id{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Employee_id &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory Employee_id.fromMap(Map<String, dynamic> map) {
    return new Employee_id(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}


class AssessRating {
  int id;
  String description;
  String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  AssessRating({this.id = 0, this.description = '', this.name = ''});

  AssessRating copyWith({int? id, String? description, String? name}) {
    if ((id == null || identical(id, this.id)) &&
        (description == null ||
            identical(description, this.description)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new AssessRating(
      id: id ?? this.id,
      description: description ?? this.description,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'AssessRating{id: $id,description: $description, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssessRating &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          description == other.description &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ description.hashCode ^ name.hashCode;

  factory AssessRating.fromMap(Map<String, dynamic> map) {
    return new AssessRating(
      id: map['id']??0,
      description: map['description'] ?? "",
      name: map['name'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'description': this.description,
      'name': this.name,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}
// class AssessRating {
//   int? id;
//   String? description;
//   String? name;

// //<editor-fold desc="Data Methods" defaultstate="collapsed">

//   AssessRating({
//     this.id,
//     this.description,
//     this.name,
//   });

//   AssessRating copyWith({
//     int? id,
//     String? description,
//     String? name,
//   }) {
//     if ((id == null || identical(id, this.id)) &&
//         (name == null || identical(name, this.name)) &&
//         (description == null || identical(description, this.description))) {
//       return this;
//     }

//     return new AssessRating(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       description: description ?? this.description
//     );
//   }

//   @override
//   String toString() {
//     return 'AssessRating{id: $id, name: $name,description: $description}';
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is AssessRating &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           name == other.name &&
//           description == other.description);

//   @override
//   int get hashCode => id.hashCode ^ name.hashCode;

//   factory AssessRating.fromMap(Map<String, dynamic> map) {
//     return new AssessRating(
//       id: map['id'] ?? 0,
//       description: map['description'] ?? "",
//       name: map['name'] ?? "",
//     );
//   }

//   Map<String, dynamic> toMap() {
//     // ignore: unnecessary_cast
//     return {
//       'id': this.id,
//       'description': this.description,
//       'name': this.name,
//     } as Map<String, dynamic>;
//   }

// //</editor-fold>
// }

class HODForceRanking {
  final int id;
  final String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const HODForceRanking({
    this.id = 0,
    this.name = '',
  });

  HODForceRanking copyWith({
    int? id,
    String? name,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new HODForceRanking(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'HODForceRanking{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HODForceRanking &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory HODForceRanking.fromMap(Map<String, dynamic> map) {
    return new HODForceRanking(
      id: map['id'] ?? 0,
      name: map['name'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'name': this.name,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}

// class Employee_id {
//   int _id;
//   String _name;

//   int get id => _id;
//   String get name => _name;

//   Employee_id({int id, String name}) {
//     _id = id;
//     _name = name;
//   }

//   Employee_id.fromJson(dynamic json) {
//     _id = json["id"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["name"] = _name;
//     return map;
//   }
// }

class Rating {
  int id;
  String rating_description;
  String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  Rating({this.id = 0, this.rating_description = '', this.name = ''});

  Rating copyWith({int? id, String? rating_description, String? name}) {
    if ((id == null || identical(id, this.id)) &&
        (rating_description == null ||
            identical(rating_description, this.rating_description)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new Rating(
      id: id ?? this.id,
      rating_description: rating_description ?? this.rating_description,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'Rating{id: $id,rating_description: $rating_description, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Rating &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          rating_description == other.rating_description &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ rating_description.hashCode ^ name.hashCode;

  factory Rating.fromMap(Map<String, dynamic> map) {
    return new Rating(
      id: map['id']??0,
      rating_description: map['rating_description'] ?? "",
      name: map['name'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'rating_description': this.rating_description,
      'name': this.name,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}

class FinalEvaluation {
  int id;
  int point;
  String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  FinalEvaluation({this.id = 0, this.point = 0, this.name = ''});

  FinalEvaluation copyWith({int? id, int? point, String? name}) {
    if ((id == null || identical(id, this.id)) &&
        (point == null ||
            identical(point, this.point)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return FinalEvaluation(
      id: id ?? this.id,
      point: point ?? this.point,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'FinalEvaluation{id: $id,point: $point, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinalEvaluation &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          point == other.point &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ point.hashCode ^ name.hashCode;

  factory FinalEvaluation.fromMap(Map<String, dynamic> map) {
    return new FinalEvaluation(
      id: map['id']??0,
      point: map['point'] ?? 0,
      name: map['name'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'point': this.point,
      'name': this.name,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}

// class Rating {
//   int _id;
//   String _rating_description;
//   String _name;

//   int get id => _id;
//   String get rating_description => _rating_description;
//   String get name => _name;

//   Rating({int id, String rating_description, String name}) {
//     _id = id;
//     _rating_description = rating_description;
//     _name = name;
//   }

//   Rating.fromJson(dynamic json) {
//     _id = json["id"];
//     _rating_description = json["rating_description"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["rating_description"] = _rating_description;
//     map["name"] = _name;
//     return map;
//   }
// }

class FinalRating {
  int id;
  String final_description;
  String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  FinalRating({
    this.id = 0,
    this.final_description = '',
    this.name = '',
  });

  FinalRating copyWith({
    int? id,
    String? final_description,
    String? name,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (final_description == null ||
            identical(final_description, this.final_description)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new FinalRating(
      id: id ?? this.id,
      final_description: final_description ?? this.final_description,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'FinalRating{id: $id,final_description: $final_description, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinalRating &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          final_description == other.final_description &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ final_description.hashCode ^ name.hashCode;

  factory FinalRating.fromMap(Map<String, dynamic> map) {
    return new FinalRating(
      id: map['id'] ?? 0,
      final_description: map['final_description'] ?? "",
      name: map['name'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'final_description': this.final_description,
      'name': this.name,
    } as Map<String, dynamic>;
  }

//</editor-fold>
}

// class FinalRating {
//   int _id;
//   String _final_description;
//   String _name;

//   int get id => _id;
//   String get final_description => _final_description;
//   String get name => _name;

//   FinalRating({int id, String final_description, String name}) {
//     _id = id;
//     _final_description = final_description;
//     _name = name;
//   }

//   FinalRating.fromJson(dynamic json) {
//     _id = json["id"];
//     _final_description = json["final_description"];
//     _name = json["name"];
//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map["id"] = _id;
//     map["final_description"] = _final_description;
//     map["name"] = _name;
//     return map;
//   }
// }