
import 'dart:convert';

/// job grade : ""
/// salary level : ""
/// wage : 0.0

// class Employee_jobinfo {
//   String _job_grade;
//   String _salary_level;
//   double _wage;
//   String _salary_level_name;
//   String _job_grade_name;

//   String get job_grade => _job_grade;
//   String get salary_level => _salary_level;
//   double get wage => _wage;
//   String get salary_level_name => _salary_level_name;
//   String get job_grade_name => _job_grade_name;

//   Employee_jobinfo({
//       String job_grade,
//       String salary_level,
//       double wage,String job_grade_name,
//     String salary_level_name}){
//     _job_grade = job_grade;
//     _salary_level = salary_level;
//     _wage = wage;
//     _job_grade_name = job_grade_name;
//     _salary_level_name = salary_level_name;
// }

//   Employee_jobinfo.fromJson(dynamic json) {
//     _job_grade = json['job_grade'].toString();
//     _salary_level = json['salary_level'].toString();
//     _wage = json['wage'];
//     _salary_level_name = json['salary_level_name'].toString();
//     _job_grade_name = json['job_grade_name'].toString();

//   }

//   Map<String, dynamic> toJson() {
//     var map = <String, dynamic>{};
//     map['job_grade'] = _job_grade;
//     map['salary-level'] = _salary_level;
//     map['wage'] = _wage;
//     return map;
//   }

// }

class Employee_jobinfo {

  final String job_grade;
  final String salary_level;
  final double wage;
  final String salary_level_name;
  final String job_grade_name;
  Employee_jobinfo({
    this.job_grade = '',
    this.salary_level = '',
    this.wage = 0.0,
    this.salary_level_name = '',
    this.job_grade_name = ''
  });

  Employee_jobinfo copyWith({
    String? job_grade,
    String? salary_level,
    double? wage,
    String? salary_level_name,
    String? job_grade_name,
  }) {
    return Employee_jobinfo(
      job_grade: job_grade ?? this.job_grade,
      salary_level: salary_level?? this.salary_level,
      wage: wage ?? this.wage,
      salary_level_name: salary_level_name ?? this.salary_level_name,
      job_grade_name: job_grade_name ?? this.job_grade_name
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'job_grade': job_grade,
      'salary_level': salary_level,
      'wage': wage,
      'salary_level_name': salary_level_name,
      'job_grade_name': job_grade_name
    };
  }

  factory Employee_jobinfo.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Employee_jobinfo(
      job_grade: map['job_grade'],
      salary_level: map['salary_level'],
      wage: map['wage'],
      salary_level_name: map['salary_level_name'],
      job_grade_name: map['job_grade_name']
    );
  }

  String toJson() => json.encode(toMap());

  factory Employee_jobinfo.fromJson(String source) =>
      Employee_jobinfo.fromMap(json.decode(source));

  @override
  String toString() => 'Employee_jobinfo(job_grade: $job_grade, salary_level: $salary_level, wage: $wage, salary_level_name: $salary_level_name, job_grade_name: $job_grade_name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Employee_jobinfo && o.job_grade == job_grade && o.salary_level == salary_level && o.wage == wage && o.salary_level_name == salary_level_name && o.job_grade_name == job_grade_name;
  }

  @override
  int get hashCode => job_grade.hashCode ^ salary_level.hashCode ^ wage.hashCode ^ salary_level_name.hashCode ^ job_grade_name.hashCode;
}