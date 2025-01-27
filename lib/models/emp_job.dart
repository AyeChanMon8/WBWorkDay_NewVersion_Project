// // @dart=2.9

// class Emp_job {
//   int _id;
//   String _name;
//   int _job_id;
//   String _job_name;

//   String get job_name => _job_name;

//   String get name => _name;
//   int get job_id => _job_id;

//   int get id => _id;

//   Emp_job({
//     int id,
//     String name,int jobId,String jobName}) {
//     _id = id;
//     _name = name;
//     _job_id=jobId;
//     _job_name = jobName;
//   }

//   Emp_job.fromJson(dynamic map) {
//     _id = map['id'] ;
//     _name =  map['name'];
//     _job_name = map['job_position'] ;
//     _job_id =  map['job_id'];

//   }

// }

import 'dart:convert';

class Emp_job {

  final int id;
  final String name;
  final int job_id;
  final String job_name;
  Emp_job({
    this.id = 0,
    this.name = '',
    this.job_id = 0,
    this.job_name = ''
  });

  Emp_job copyWith({
    int? id,
    String? name,
    int? job_id,
    String? job_name
  }) {
    return Emp_job(
      id: id ?? this.id,
      name: name ?? this.name,
      job_id: job_id ?? this.job_id,
      job_name: job_name ?? this.job_name
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'job_id': job_id,
      'job_name': job_name
    };
  }

  factory Emp_job.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Emp_job(
      id: map['id'],
      name: map['name'],
      job_id: map['job_id'],
      job_name: map['job_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Emp_job.fromJson(String source) =>
      Emp_job.fromMap(json.decode(source));

  @override
  String toString() => 'Emp_job(id: $id, name: $name, job_id: $job_id, job_name: $job_name)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Emp_job && o.id == id && o.name == name && o.job_id == job_id && o.job_name == job_name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ job_id.hashCode ^ job_name.hashCode;
}
