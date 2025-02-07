import 'dart:convert';

class PMSForceRankingDetailModel {
  Approve_manager? approveManager;
  List<ForceRankingGroupId>? forceRankingGroupId;

  PMSForceRankingDetailModel(
      {this.approveManager,
      this.forceRankingGroupId,
      });

  PMSForceRankingDetailModel copyWith({
    Approve_manager? approveManager,
    List<ForceRankingGroupId>? forceRankingGroupId
  }) {
    return PMSForceRankingDetailModel(
      approveManager: approveManager ?? this.approveManager,
      forceRankingGroupId: forceRankingGroupId ?? this.forceRankingGroupId
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'approve_manager': approveManager?.toMap(),
      'force_ranking_group_id':
          forceRankingGroupId?.map((x) => x?.toMap())?.toList(),
    };
  }

  PMSForceRankingDetailModel.name();

  factory PMSForceRankingDetailModel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return PMSForceRankingDetailModel(
      approveManager: Approve_manager.fromMap(map['approve_manager']),
      forceRankingGroupId: List<ForceRankingGroupId>.from(
          map['force_ranking_group_id']
              ?.map((x) => ForceRankingGroupId.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PMSForceRankingDetailModel.fromJson(String source) =>
      PMSForceRankingDetailModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'PMSForceRankingDetailModel(approveManager: $approveManager, forceRankingGroupId: $forceRankingGroupId)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PMSForceRankingDetailModel &&
        o.approveManager == approveManager &&
        o.forceRankingGroupId == forceRankingGroupId;
  }

  @override
  int get hashCode =>
      approveManager.hashCode ^
      forceRankingGroupId.hashCode;
}

class Approve_manager {
  final int id;
  final String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Approve_manager({
    this.id = 0,
    this.name = '',
  });

  Approve_manager copyWith({
    int? id,
    String? name,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new Approve_manager(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'Approve_manager{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Approve_manager &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory Approve_manager.fromMap(Map<String, dynamic> map) {
    return new Approve_manager(
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

class ForceRankingGroupId {
  dynamic? id;
  int? forceTemplateId;
  dynamic name;
  late String state;
  List<RankingEmployee>? rankingEmployee;
  dynamic midFromDate;
  dynamic midToDate;
  dynamic endFromDate;
  dynamic endToDate;
  dynamic dateStart;
  dynamic dateEnd;
  dynamic dateRangeName;
  ForceRankingGroupId(
      {this.id,
      this.forceTemplateId,
      this.name,
      this.state = '',
      this.rankingEmployee,
      this.midFromDate,
      this.midToDate,
      this.endFromDate,
      this.endToDate,
      this.dateStart,
      this.dateEnd,
      this.dateRangeName,
      });

  ForceRankingGroupId copyWith({
    dynamic? id,
  int? forceTemplateId,
  dynamic name,
  String? state,
  List<RankingEmployee>? rankingEmployee,
  dynamic midFromDate,
  dynamic midToDate,
  dynamic endFromDate,
  dynamic endToDate,
  dynamic dateStart,
  dynamic dateEnd,
  dynamic dateRangeName
  }) {
    return ForceRankingGroupId(
      id: id ?? this.id,
      forceTemplateId: forceTemplateId ?? this.forceTemplateId,
      name: name ?? this.name,
      state: state ?? this.state,
      rankingEmployee: rankingEmployee ?? this.rankingEmployee,
      midFromDate: midFromDate ?? this.midFromDate,
      midToDate: midToDate ?? this.midToDate,
      endFromDate: endFromDate ?? this.endFromDate,
      endToDate: endToDate ?? this.endToDate,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      dateRangeName: dateRangeName ?? this.dateRangeName
    );
  }

  ForceRankingGroupId.name();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'force_template_id': forceTemplateId,
      'name': name,
      'state': state,
      'employees': rankingEmployee?.map((x) => x?.toMap())?.toList(),
      'mid_from_date': midFromDate,
      'mid_to_date': midToDate,
      'end_from_date': endFromDate,
      'end_to_date': endToDate,
      'date_start': dateStart,
      'date_end': dateEnd,
      'date_range_name': dateRangeName
    };
  }

  factory ForceRankingGroupId.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return ForceRankingGroupId(
      id: map['id'],
      forceTemplateId: map['force_template_id'] ?? 0,
      name: map['name']??"",
      state: map['state'] ?? "",
      rankingEmployee: List<RankingEmployee>.from(
          map['employees']?.map((x) => RankingEmployee.fromMap(x))),
      midFromDate: map['mid_from_date'],
      midToDate: map['mid_to_date'],
      endFromDate: map['end_from_date'],
      endToDate: map['end_to_date'],
      dateStart: map['date_start'],
      dateEnd: map['date_end'],
      dateRangeName: map['date_range_name']
    );
  }

  String toJson() => json.encode(toMap());

  factory ForceRankingGroupId.fromJson(String source) =>
      ForceRankingGroupId.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ForceRankingGroupId(id: $id, forceTemplateId: $forceTemplateId, name: $name, state: $state, rankingEmployee: $rankingEmployee, midFromDate: $midFromDate, midToDate: $midToDate, endFromDate: $endFromDate, endToDate: $endToDate,dateStart: $dateStart,dateEnd: $dateEnd,dateRangeName: $dateRangeName)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ForceRankingGroupId &&
        o.id == id &&
        o.forceTemplateId == forceTemplateId &&
        o.name == name &&
        o.state == state &&
        o.rankingEmployee == rankingEmployee &&
        o.midFromDate == midFromDate &&
        o.midToDate == midToDate &&
        o.endFromDate == endFromDate &&
        o.endToDate == endToDate &&
        o.dateStart == dateStart &&
        o.dateEnd == dateEnd &&
        o.dateRangeName == dateRangeName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        forceTemplateId.hashCode ^
        name.hashCode ^
        state.hashCode ^
        rankingEmployee.hashCode ^
        midFromDate.hashCode ^
        midToDate.hashCode ^
        endFromDate.hashCode ^
        endToDate.hashCode ^
        dateStart.hashCode ^
        dateEnd.hashCode ^
        dateRangeName.hashCode;
  }

  String startDate() {
    if (endFromDate != null &&
        DateTime.now().isAfter(DateTime.parse(midFromDate)))
      return endFromDate;
    else if (midFromDate != null) {
      return midFromDate;
    }
    return dateStart;
  }

  String endDate() {
    if (endToDate != null && DateTime.now().isAfter(DateTime.parse(midToDate)))
      return endToDate;
    else if (midToDate != null) {
      return midToDate;
    }
    return dateEnd;
  }
}

class RankingEmployee {
  int ?rankingId;
  int? id;
  String? name;
  dynamic managerRating;
  dynamic hodRating;
  dynamic hasMgrAssessment;
  dynamic mgrFinalEvaluation;
  bool? isRatingMatch;
  dynamic remark;
  RankingEmployee(
      {this.rankingId,
      this.id,
      this.name,
      this.managerRating,
      this.hodRating,
      this.hasMgrAssessment,
      this.mgrFinalEvaluation,
      this.isRatingMatch,
      this.remark,
      });

  RankingEmployee copyWith({
    int ?rankingId,
  int? id,
  String? name,
  dynamic managerRating,
  dynamic hodRating,
  dynamic hasMgrAssessment,
  dynamic mgrFinalEvaluation,
  bool? isRatingMatch,
  dynamic remark,
  }) {
    return RankingEmployee(
      rankingId: rankingId ?? this.rankingId,
      id: id ?? this.id,
      name: name ?? this.name,
      managerRating: managerRating ?? this.managerRating,
      hodRating: hodRating ?? this.hodRating,
      hasMgrAssessment: hasMgrAssessment ?? this.hasMgrAssessment,
      mgrFinalEvaluation: mgrFinalEvaluation ?? this.mgrFinalEvaluation,
      isRatingMatch: isRatingMatch ?? this.isRatingMatch,
      remark: remark ?? this.remark
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ranking_id': rankingId,
      'id': id,
      'name': name,
      'manager_rating': managerRating,
      'hod_rating': hodRating,
      'has_mgr_assessment': hasMgrAssessment,
      'mgr_final_evaluation': mgrFinalEvaluation,
      'is_rating_match': isRatingMatch,
      'remark': remark
    };
  }

  factory RankingEmployee.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return RankingEmployee(
      rankingId: map['ranking_id'],
      id: map['id'],
      name: map['name'],
      managerRating: map['manager_rating'],
      hodRating: map['hod_rating'],
      hasMgrAssessment: map['has_mgr_assessment'],
      mgrFinalEvaluation: map['mgr_final_evaluation'],
      isRatingMatch: map['is_rating_match'],
      remark: map['remark']
    );
  }

  String toJson() => json.encode(toMap());

  factory RankingEmployee.fromJson(String source) =>
      RankingEmployee.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RankingEmployee(rankingId: $rankingId, id: $id, name: $name, managerRating: $managerRating, hodRating: $hodRating, hasMgrAssessment: $hasMgrAssessment, mgrFinalEvaluation: $mgrFinalEvaluation, isRatingMatch: $isRatingMatch, remark: $remark)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RankingEmployee &&
        o.rankingId == rankingId &&
        o.id == id &&
        o.name == name &&
        o.managerRating == managerRating &&
        o.hodRating == hodRating &&
        o.hasMgrAssessment == hasMgrAssessment &&
        o.mgrFinalEvaluation == mgrFinalEvaluation &&
        o.isRatingMatch == isRatingMatch &&
        o.remark == remark;
  }

  @override
  int get hashCode {
    return rankingId.hashCode ^
        id.hashCode ^
        name.hashCode ^
        managerRating.hashCode ^
        hodRating.hashCode ^
        hasMgrAssessment.hashCode ^
        mgrFinalEvaluation.hashCode ^
        isRatingMatch.hashCode ^
        remark.hashCode;
  }

  void setForceManagerRate(String rate) {
    managerRating = rate;
  }

  void setRemark(String remark){
    remark = remark;
  }
}