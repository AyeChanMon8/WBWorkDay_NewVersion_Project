import 'dart:convert';

class PMSHODForceRankingDetailModel {
  HODEmployee? hodEmployee;
  List<HODForceRankingGroupId>? forceRankingGroupId;

  PMSHODForceRankingDetailModel(
      {this.hodEmployee,
      this.forceRankingGroupId,
      });

  PMSHODForceRankingDetailModel copyWith({
    HODEmployee? hodEmployee,
    List<HODForceRankingGroupId>? forceRankingGroupId
  }) {
    return PMSHODForceRankingDetailModel(
      hodEmployee: hodEmployee ?? this.hodEmployee,
      forceRankingGroupId: forceRankingGroupId ?? this.forceRankingGroupId
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hod_employee': hodEmployee?.toMap(),
      'force_ranking_group_id':
          forceRankingGroupId?.map((x) => x?.toMap())?.toList(),
    };
  }

  PMSHODForceRankingDetailModel.name();

  factory PMSHODForceRankingDetailModel.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return PMSHODForceRankingDetailModel(
      hodEmployee: HODEmployee.fromMap(map['hod_employee']),
      forceRankingGroupId: List<HODForceRankingGroupId>.from(
          map['force_ranking_group_id']
              ?.map((x) => HODForceRankingGroupId.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory PMSHODForceRankingDetailModel.fromJson(String source) =>
      PMSHODForceRankingDetailModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'PMSHODForceRankingDetailModel(hodEmployee: $hodEmployee, forceRankingGroupId: $forceRankingGroupId)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PMSHODForceRankingDetailModel &&
        o.hodEmployee == hodEmployee &&
        o.forceRankingGroupId == forceRankingGroupId;
  }

  @override
  int get hashCode =>
      hodEmployee.hashCode ^
      forceRankingGroupId.hashCode;
}

class HODEmployee {
  final int id;
  final String name;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const HODEmployee({
    this.id = 0,
    this.name = '',
  });

  HODEmployee copyWith({
    int? id,
    String? name,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name))) {
      return this;
    }

    return new HODEmployee(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'HODEmployee{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HODEmployee &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  factory HODEmployee.fromMap(Map<String, dynamic> map) {
    return new HODEmployee(
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

class HODForceRankingGroupId {
  dynamic? id;
  int? forceTemplateId;
  dynamic name;
  late String state;
  List<HODRankingEmployee>? rankingEmployee;
  List<ManagerForceRankingTemplate>? managerForceRankingTemplate;
  dynamic midFromDate;
  dynamic midToDate;
  dynamic endFromDate;
  dynamic endToDate;
  dynamic dateStart;
  dynamic dateEnd;
  dynamic dateRangeName;
  bool? alreadySentBack;
  bool? isRatingMatch;
  HODForceRankingGroupId(
      {this.id,
      this.forceTemplateId,
      this.name,
      this.state = '',
      this.rankingEmployee,
      this.managerForceRankingTemplate,
      this.midFromDate,
      this.midToDate,
      this.endFromDate,
      this.endToDate,
      this.dateStart,
      this.dateEnd,
      this.dateRangeName,
      this.alreadySentBack,
      this.isRatingMatch
      });

  HODForceRankingGroupId copyWith({
    dynamic? id,
  int? forceTemplateId,
  dynamic name,
  String? state,
  List<HODRankingEmployee>? rankingEmployee,
  List<ManagerForceRankingTemplate>? managerForceRankingTemplate,
  dynamic midFromDate,
  dynamic midToDate,
  dynamic endFromDate,
  dynamic endToDate,
  dynamic dateStart,
  dynamic dateEnd,
  dynamic dateRangeName,
  bool? alreadySentBack,
  bool? isRatingMatch,
  }) {
    return HODForceRankingGroupId(
      id: id ?? this.id,
      forceTemplateId: forceTemplateId ?? this.forceTemplateId,
      name: name ?? this.name,
      state: state ?? this.state,
      rankingEmployee: rankingEmployee ?? this.rankingEmployee,
      managerForceRankingTemplate: managerForceRankingTemplate ?? this.managerForceRankingTemplate,
      midFromDate: midFromDate ?? this.midFromDate,
      midToDate: midToDate ?? this.midToDate,
      endFromDate: endFromDate ?? this.endFromDate,
      endToDate: endToDate ?? this.endToDate,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      dateRangeName: dateRangeName ?? this.dateRangeName,
      alreadySentBack: alreadySentBack ?? this.alreadySentBack,
      isRatingMatch: isRatingMatch ?? this.isRatingMatch
    );
  }

  HODForceRankingGroupId.name();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'force_template_id': forceTemplateId,
      'name': name,
      'state': state,
      'employees': rankingEmployee?.map((x) => x?.toMap())?.toList(),
      'manager_force_ranking_template': managerForceRankingTemplate?.map((x) => x?.toMap())?.toList(),
      'mid_from_date': midFromDate,
      'mid_to_date': midToDate,
      'end_from_date': endFromDate,
      'end_to_date': endToDate,
      'date_start': dateStart,
      'date_end': dateEnd,
      'date_range_name': dateRangeName,
      'already_sent_back': alreadySentBack,
      'is_rating_match': isRatingMatch
    };
  }

  factory HODForceRankingGroupId.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return HODForceRankingGroupId(
      id: map['id'],
      forceTemplateId: map['force_template_id'] ?? 0,
      name: map['name']??"",
      state: map['state'] ?? "",
      rankingEmployee: List<HODRankingEmployee>.from(
          map['employees']?.map((x) => HODRankingEmployee.fromMap(x))),
      managerForceRankingTemplate: List<ManagerForceRankingTemplate>.from(
          map['manager_force_ranking_template']?.map((x) => ManagerForceRankingTemplate.fromMap(x))),
      midFromDate: map['mid_from_date'],
      midToDate: map['mid_to_date'],
      endFromDate: map['end_from_date'],
      endToDate: map['end_to_date'],
      dateStart: map['date_start'],
      dateEnd: map['date_end'],
      dateRangeName: map['date_range_name'],
      alreadySentBack: map['already_sent_back'],
      isRatingMatch: map['is_rating_match']
    );
  }

  String toJson() => json.encode(toMap());

  factory HODForceRankingGroupId.fromJson(String source) =>
      HODForceRankingGroupId.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HODForceRankingGroupId(id: $id, forceTemplateId: $forceTemplateId, name: $name, state: $state, rankingEmployee: $rankingEmployee,managerForceRankingTemplate: $managerForceRankingTemplate, midFromDate: $midFromDate, midToDate: $midToDate, endFromDate: $endFromDate, endToDate: $endToDate,dateStart: $dateStart,dateEnd: $dateEnd,dateRangeName: $dateRangeName,alreadySentBack: $alreadySentBack,isRatingMatch: $isRatingMatch )';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HODForceRankingGroupId &&
        o.id == id &&
        o.forceTemplateId == forceTemplateId &&
        o.name == name &&
        o.state == state &&
        o.rankingEmployee == rankingEmployee &&
        o.managerForceRankingTemplate == managerForceRankingTemplate &&
        o.midFromDate == midFromDate &&
        o.midToDate == midToDate &&
        o.endFromDate == endFromDate &&
        o.endToDate == endToDate &&
        o.dateStart == dateStart &&
        o.dateEnd == dateEnd &&
        o.dateRangeName == dateRangeName &&
        o.alreadySentBack == alreadySentBack &&
        o.isRatingMatch == isRatingMatch;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        forceTemplateId.hashCode ^
        name.hashCode ^
        state.hashCode ^
        rankingEmployee.hashCode ^
        managerForceRankingTemplate.hashCode ^
        midFromDate.hashCode ^
        midToDate.hashCode ^
        endFromDate.hashCode ^
        endToDate.hashCode ^
        dateStart.hashCode ^
        dateEnd.hashCode ^
        dateRangeName.hashCode ^
        alreadySentBack.hashCode ^
        isRatingMatch.hashCode;
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

class HODRankingEmployee {
  int ?rankingId;
  int? id;
  String? name;
  dynamic managerRating;
  dynamic hodRating;
  dynamic hasManagerForceRank;
  dynamic mgrFinalEvaluation;
  bool? isRatingMatch;
  dynamic remark;
  HODRankingEmployee(
      {this.rankingId,
      this.id,
      this.name,
      this.managerRating,
      this.hodRating,
      this.hasManagerForceRank,
      this.mgrFinalEvaluation,
      this.isRatingMatch,
      this.remark,
      });

  HODRankingEmployee copyWith({
    int ?rankingId,
  int? id,
  String? name,
  dynamic managerRating,
  dynamic hodRating,
  dynamic hasManagerForceRank,
  dynamic mgrFinalEvaluation,
  bool? isRatingMatch,
  dynamic remark,
  }) {
    return HODRankingEmployee(
      rankingId: rankingId ?? this.rankingId,
      id: id ?? this.id,
      name: name ?? this.name,
      managerRating: managerRating ?? this.managerRating,
      hodRating: hodRating ?? this.hodRating,
      hasManagerForceRank: hasManagerForceRank ?? this.hasManagerForceRank,
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
      'has_manager_force_rank': hasManagerForceRank,
      'mgr_final_evaluation': mgrFinalEvaluation,
      'is_rating_match': isRatingMatch,
      'remark': remark
    };
  }

  factory HODRankingEmployee.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return HODRankingEmployee(
      rankingId: map['ranking_id'],
      id: map['id'],
      name: map['name'],
      managerRating: map['manager_rating'],
      hodRating: map['hod_rating'],
      hasManagerForceRank: map['has_manager_force_rank'],
      mgrFinalEvaluation: map['mgr_final_evaluation'],
      isRatingMatch: map['is_rating_match'],
      remark: map['remark'] ?? ""
    );
  }

  String toJson() => json.encode(toMap());

  factory HODRankingEmployee.fromJson(String source) =>
      HODRankingEmployee.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HODRankingEmployee(rankingId: $rankingId, id: $id, name: $name, managerRating: $managerRating, hodRating: $hodRating, hasManagerForceRank: $hasManagerForceRank, mgrFinalEvaluation: $mgrFinalEvaluation, isRatingMatch: $isRatingMatch, remark: $remark)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HODRankingEmployee &&
        o.rankingId == rankingId &&
        o.id == id &&
        o.name == name &&
        o.managerRating == managerRating &&
        o.hodRating == hodRating &&
        o.hasManagerForceRank == hasManagerForceRank &&
        o.mgrFinalEvaluation == mgrFinalEvaluation &&
        o.isRatingMatch == isRatingMatch &&
        o.remark == remark;
  }

  void setHODManagerRate(String rate) {
    hodRating = rate;
  }
  void setRemark(String remark) {
    remark = remark;
  }

  @override
  int get hashCode {
    return rankingId.hashCode ^
        id.hashCode ^
        name.hashCode ^
        managerRating.hashCode ^
        hodRating.hashCode ^
        hasManagerForceRank.hashCode ^
        mgrFinalEvaluation.hashCode ^
        isRatingMatch.hashCode ^
        remark.hashCode;
  }
}

class ManagerForceRankingTemplate {
  int? managerRankingId;
  int? id;
  String? name;
  dynamic forceRankingGroupId;
  dynamic forceRankingGroupName;
  ManagerForceRankingTemplate(
      {this.managerRankingId,
      this.id,
      this.name,
      this.forceRankingGroupId,
      this.forceRankingGroupName
      });

  ManagerForceRankingTemplate copyWith({
    int? managerRankingId,
  int? id,
  String? name,
  dynamic? forceRankingGroupId,
  dynamic? forceRankingGroupName,
  }) {
    return ManagerForceRankingTemplate(
      managerRankingId: managerRankingId ?? this.managerRankingId,
      id: id ?? this.id,
      name: name ?? this.name,
      forceRankingGroupId: forceRankingGroupId ?? this.forceRankingGroupId,
      forceRankingGroupName: forceRankingGroupName ?? this.forceRankingGroupName
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'manager_ranking_id': managerRankingId,
      'id': id,
      'name': name,
      'force_ranking_group_id': forceRankingGroupId,
      'force_ranking_group_name': forceRankingGroupName
    };
  }

  factory ManagerForceRankingTemplate.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return ManagerForceRankingTemplate(
      managerRankingId: map['manager_ranking_id'],
      id: map['id'],
      name: map['name'],
      forceRankingGroupId: map['force_ranking_group_id'],
      forceRankingGroupName: map['force_ranking_group_name']
    );
  }

  String toJson() => json.encode(toMap());

  factory ManagerForceRankingTemplate.fromJson(String source) =>
      ManagerForceRankingTemplate.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ManagerForceRankingTemplate(managerRankingId: $managerRankingId, id: $id, name: $name, forceRankingGroupId: $forceRankingGroupId, forceRankingGroupName: $forceRankingGroupName)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ManagerForceRankingTemplate &&
        o.managerRankingId == managerRankingId &&
        o.id == id &&
        o.name == name &&
        o.forceRankingGroupId == forceRankingGroupId &&
        o.forceRankingGroupName == forceRankingGroupName;
  }

  @override
  int get hashCode {
    return managerRankingId.hashCode ^
        id.hashCode ^
        name.hashCode ^
        forceRankingGroupId.hashCode ^
        forceRankingGroupName.hashCode;
  }
}