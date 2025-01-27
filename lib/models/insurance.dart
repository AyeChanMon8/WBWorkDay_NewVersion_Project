import 'dart:convert';
import 'dart:ffi';

import '../models/company.dart';
import '../models/department.dart';
import '../models/insurance_type.dart';
import '../models/job.dart';
import '../models/partner.dart';

class Insurance {
  int id;
  String name;
  String image_1920;
  String job_title;
  Department? department_id;
  Job? job_id;
  String work_location;
  String mobile_phone;
  String work_email;
  Company? company_id;
  Partner? parent_id;
  String ssb_no;
  String ssb_issue_date;
  String ssb_temporary_card;
  String ssb_temporary_card_no;
  String smart_card;
  String smart_card_issue_date;
  String smart_card_no;
  String fingerprint_id;
  String insurance_no;
  String insurance_company;
  InsuranceType? insurance_type_id;
  double employee_insurance;
  double employer_insurance;
  String insurance_start_date;
  String insurance_end_date;
  String insurance_tax_exemption;
  Insurance(
      {this.id = 0,
      this.name = '',
      this.image_1920 = '',
      this.job_title = '',
      this.department_id,
      this.job_id,
      this.work_location = '',
      this.mobile_phone = '',
      this.work_email = '',
      this.company_id,
      this.parent_id,
      this.ssb_no = '',
      this.ssb_issue_date = '',
      this.ssb_temporary_card = '',
      this.ssb_temporary_card_no = '',
      this.smart_card = '',
      this.smart_card_issue_date = '',
      this.smart_card_no = '',
      this.fingerprint_id = '',
      this.insurance_no = '',
      this.insurance_company = '',
      this.insurance_type_id,
      this.employee_insurance = 0.0,
      this.employer_insurance = 0.0,
      this.insurance_start_date = '',
      this.insurance_end_date = '',
      this.insurance_tax_exemption = ''});

  Insurance copyWith(
      {int? id,
      String? name,
      String? image_1920,
      String? job_title,
      Department? department_id,
      Job? job_id,
      String? work_location,
      String? mobile_phone,
      String? work_email,
      Company? company_id,
      Partner? parent_id,
      String? ssb_no,
      String? ssb_issue_date,
      String? ssb_temporary_card,
      String? ssb_temporary_card_no,
      String? smart_card,
      String? smart_card_issue_date,
      String? smart_card_no,
      String? fingerprint_id,
      String? insurance_no,
      String? insurance_company,
      InsuranceType? insurance_type_id,
      double? employee_insurance,
      double? employer_insurance,
      String? insurance_start_date,
      String? insurance_end_date,
      String? insurance_tax_exemption}) {
    return Insurance(
      id: id ?? this.id,
      name: name ?? this.name,
      image_1920: image_1920 ?? this.image_1920,
      job_title: job_title ?? this.job_title,
      department_id: department_id ?? this.department_id,
      job_id: job_id ?? this.job_id,
      work_location: work_location ?? this.work_location,
      mobile_phone: mobile_phone ?? this.mobile_phone,
      work_email: work_email ?? this.work_email,
      company_id: company_id ?? this.company_id,
      parent_id: parent_id ?? this.parent_id,
      ssb_no: ssb_no ?? this.ssb_no,
      ssb_issue_date: ssb_issue_date ?? this.ssb_issue_date,
      ssb_temporary_card: ssb_temporary_card ?? this.ssb_temporary_card,
      ssb_temporary_card_no: ssb_temporary_card_no ?? this.ssb_temporary_card_no,
      smart_card: smart_card ?? this.smart_card,
      smart_card_issue_date: smart_card_issue_date ?? this.smart_card_issue_date,
      smart_card_no: smart_card_no ?? this.smart_card_no,
      fingerprint_id: fingerprint_id ?? this.fingerprint_id,
      insurance_no: insurance_no ?? this.insurance_no,
      insurance_company: insurance_company ?? this.insurance_company,
      insurance_type_id: insurance_type_id ?? this.insurance_type_id,
      employee_insurance: employee_insurance ?? this.employee_insurance,
      employer_insurance: employer_insurance ?? this.employer_insurance,
      insurance_start_date: insurance_start_date ?? this.insurance_start_date,
      insurance_end_date: insurance_end_date ?? this.insurance_end_date,
      insurance_tax_exemption: insurance_tax_exemption ?? this.insurance_tax_exemption,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image_1920': image_1920,
      'job_title': job_title,
      'department_id': department_id,
      'job_id': job_id,
      'work_location': work_location,
      'mobile_phone': mobile_phone,
      'work_email': work_email,
      'company_id': company_id,
      'parent_id': parent_id,
      'ssb_no': ssb_no,
      'ssb_issue_date': ssb_issue_date,
      'ssb_temporary_card': ssb_temporary_card,
      'ssb_temporary_card_no': ssb_temporary_card_no,
      'smart_card': smart_card,
      'smart_card_issue_date': smart_card_issue_date,
      'smart_card_no': smart_card_no,
      'fingerprint_id': fingerprint_id,
      'insurance_no': insurance_no,
      'insurance_company': insurance_company,
      'insurance_type_id': insurance_type_id,
      'employee_insurance': employee_insurance,
      'employer_insurance': employer_insurance,
      'insurance_start_date': insurance_start_date,
      'insurance_end_date': insurance_end_date,
      'insurance_tax_exemption': insurance_tax_exemption,
    };
  }

  factory Insurance.fromMap(Map<String, dynamic> map) {
    // if (map == null) return null;

    return Insurance(
      id: map['id'],
      name: map['name'],
      image_1920: map['image_1920'],
      job_title: map['job_title'],
      department_id: Department.fromMap(map['department_id']),
      job_id: Job.fromMap(map['job_id']),
      work_location: map['work_location'],
      mobile_phone: map['mobile_phone'],
      work_email: map['work_email'],
      company_id: Company.fromMap(map['company_id']),
      parent_id: Partner.fromMap(map['parent_id']),
      ssb_no: map['ssb_no'],
      ssb_issue_date: map['ssb_issue_date'],
      ssb_temporary_card: map['ssb_temporary_card'],
      ssb_temporary_card_no: map['ssb_temporary_card_no'],
      smart_card: map['smart_card'],
      smart_card_issue_date: map['smart_card_issue_date'],
      smart_card_no: map['smart_card_no'],
      fingerprint_id: map['fingerprint_id'],
      insurance_no: map['insurance_no'],
      insurance_company: map['insurance_company'],
      insurance_type_id: InsuranceType.fromMap(map['insurance_type_id']),
      employee_insurance: map['employee_insurance'],
      employer_insurance: map['employer_insurance'],
      insurance_start_date: map['insurance_start_date'],
      insurance_end_date: map['insurance_end_date'],
      insurance_tax_exemption: map['insurance_tax_exemption'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Insurance.fromJson(String source) =>
      Insurance.fromMap(json.decode(source));

  @override
  String toString() => 'Insurance(id: $id, name: $name,image_1920: $image_1920, job_title: $job_title,department_id: $department_id, job_id: $job_id,work_location: $work_location, mobile_phone: $mobile_phone,work_email: $work_email, company_id: $company_id,parent_id: $parent_id, ssb_no: $ssb_no,ssb_issue_date: $ssb_issue_date, ssb_temporary_card: $ssb_temporary_card,ssb_temporary_card_no: $ssb_temporary_card_no, smart_card: $smart_card,smart_card_issue_date: $smart_card_issue_date, ssb_temporary_card: $ssb_temporary_card,ssb_temporary_card_no: $ssb_temporary_card_no, smart_card: $smart_card, smart_card_no: $smart_card_no, fingerprint_id: $fingerprint_id, insurance_no: $insurance_no, insurance_company: $insurance_company, insurance_type_id: $insurance_type_id, employee_insurance: $employee_insurance, employer_insurance: $employer_insurance, insurance_start_date: $insurance_start_date, insurance_end_date: $insurance_end_date, insurance_tax_exemption: $insurance_tax_exemption)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Insurance && o.id == id && o.name == name && o.image_1920 == image_1920 && o.job_title == job_title
    && o.department_id == department_id && o.job_id == job_id && o.work_location == work_location && o.mobile_phone == mobile_phone && o.work_email == work_email && o.company_id == company_id
    && o.parent_id == parent_id && o.ssb_no == ssb_no && o.ssb_issue_date == ssb_issue_date && o.ssb_temporary_card == ssb_temporary_card && o.ssb_temporary_card_no == ssb_temporary_card_no && o.smart_card == smart_card
    && o.smart_card_no == smart_card_no && o.fingerprint_id == fingerprint_id && o.insurance_no == insurance_no && o.insurance_company == insurance_company && o.insurance_type_id == insurance_type_id && o.employee_insurance == employee_insurance
    && o.employer_insurance == employer_insurance && o.insurance_start_date == insurance_start_date && o.insurance_end_date == insurance_end_date && o.insurance_tax_exemption == insurance_tax_exemption;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image_1920.hashCode ^ job_title.hashCode ^ department_id.hashCode ^ job_id.hashCode ^
  work_location.hashCode ^ mobile_phone.hashCode ^ work_email.hashCode ^ company_id.hashCode ^ parent_id.hashCode ^ ssb_no.hashCode ^ ssb_issue_date.hashCode ^ ssb_temporary_card.hashCode
  ^ ssb_temporary_card_no.hashCode ^ smart_card.hashCode ^ smart_card_no.hashCode ^ fingerprint_id.hashCode ^ insurance_no.hashCode ^ insurance_company.hashCode
  ^ insurance_type_id.hashCode ^ employee_insurance.hashCode ^ employer_insurance.hashCode ^ insurance_start_date.hashCode ^ insurance_end_date.hashCode ^ insurance_tax_exemption.hashCode;
}

// class Insurance {
//   int id;
//   String name;
//   String image_1920;
//   String job_title;
//   Department department_id;
//   Job job_id;
//   String work_location;
//   String mobile_phone;
//   String work_email;
//   Company company_id;
//   Partner parent_id;
//   String ssb_no;
//   String ssb_issue_date;
//   String ssb_temporary_card;
//   String ssb_temporary_card_no;
//   String smart_card;
//   String smart_card_issue_date;
//   String smart_card_no;
//   String fingerprint_id;
//   String insurance_no;
//   String insurance_company;
//   InsuranceType insurance_type_id;
//   double employee_insurance;
//   double employer_insurance;
//   String insurance_start_date;
//   String insurance_end_date;
//   String insurance_tax_exemption;
//   Insurance({
//     this.id,
//     this.name,
//     this.image_1920,
//     this.job_title,
//     this.department_id,
//     this.job_id,
//     this.work_location,
//     this.mobile_phone,
//     this.work_email,
//     this.company_id,
//     this.parent_id,
//     this.ssb_no,
//     this.ssb_issue_date,
//     this.ssb_temporary_card,
//     this.ssb_temporary_card_no,
//     this.smart_card,
//     this.smart_card_issue_date,
//     this.smart_card_no,
//     this.fingerprint_id,
//     this.insurance_no,
//     this.insurance_company,
//     this.employee_insurance,
//     this.employer_insurance,
//     this.insurance_start_date,
//     this.insurance_end_date,
//     this.insurance_tax_exemption,
//   });

//   Insurance copyWith({
//     int id,
//     String name,
//     String image_1920,
//     String job_title,
//     Department department_id,
//     Job job_id,
//     String work_location,
//     String mobile_phone,
//     String work_email,
//     Company company_id,
//     Partner parent_id,
//     String ssb_no,
//     String ssb_issue_date,
//     String ssb_temporary_card,
//     String ssb_temporary_card_no,
//     String smart_card,
//     String smart_card_issue_date,
//     String smart_card_no,
//     String fingerprint_id,
//     String insurance_no,
//     String insurance_company,
//     double employee_insurance,
//     double employer_insurance,
//     String insurance_start_date,
//     String insurance_end_date,
//     String insurance_tax_exemption,
//   }) {
//     return Insurance(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       image_1920: image_1920 ?? this.image_1920,
//       job_title: job_title ?? this.job_title,
//       department_id: department_id ?? this.department_id,
//       job_id: job_id ?? this.job_id,
//       work_location: work_location ?? this.work_location,
//       mobile_phone: mobile_phone ?? this.mobile_phone,
//       work_email: work_email ?? this.work_email,
//       company_id: company_id ?? this.company_id,
//       parent_id: parent_id ?? this.parent_id,
//       ssb_no: ssb_no ?? this.ssb_no,
//       ssb_issue_date: ssb_issue_date ?? this.ssb_issue_date,
//       ssb_temporary_card: ssb_temporary_card ?? this.ssb_temporary_card,
//       ssb_temporary_card_no:
//           ssb_temporary_card_no ?? this.ssb_temporary_card_no,
//       smart_card: smart_card ?? this.smart_card,
//       smart_card_issue_date:
//           smart_card_issue_date ?? this.smart_card_issue_date,
//       smart_card_no: smart_card_no ?? this.smart_card_no,
//       fingerprint_id: fingerprint_id ?? this.fingerprint_id,
//       insurance_no: insurance_no ?? this.insurance_no,
//       insurance_company: insurance_company ?? this.insurance_company,
//       employee_insurance: employee_insurance ?? this.employee_insurance,
//       employer_insurance: employer_insurance ?? this.employer_insurance,
//       insurance_start_date: insurance_start_date ?? this.insurance_start_date,
//       insurance_end_date: insurance_end_date ?? this.insurance_end_date,
//       insurance_tax_exemption:
//           insurance_tax_exemption ?? this.insurance_tax_exemption,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'image_1920': image_1920,
//       'job_title': job_title,
//       'department_id': department_id?.toMap(),
//       'job_id': job_id?.toMap(),
//       'work_location': work_location,
//       'mobile_phone': mobile_phone,
//       'work_email': work_email,
//       'company_id': company_id?.toMap(),
//       'parent_id': parent_id?.toMap(),
//       'ssb_no': ssb_no,
//       'ssb_issue_date': ssb_issue_date,
//       'ssb_temporary_card': ssb_temporary_card,
//       'ssb_temporary_card_no': ssb_temporary_card_no,
//       'smart_card': smart_card,
//       'smart_card_issue_date': smart_card_issue_date,
//       'smart_card_no': smart_card_no,
//       'fingerprint_id': fingerprint_id,
//       'insurance_no': insurance_no,
//       'insurance_company': insurance_company,
//       'employee_insurance': employee_insurance,
//       'employer_insurance': employer_insurance,
//       'insurance_start_date': insurance_start_date,
//       'insurance_end_date': insurance_end_date,
//       'insurance_tax_exemption': insurance_tax_exemption,
//     };
//   }

//   factory Insurance.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return Insurance(
//       id: map['id'] ?? 0,
//       name: map['name'] ?? '',
//       image_1920: map['image_1920'] ?? '',
//       job_title: map['job_title'] ?? '',
//       department_id: Department.fromMap(map['department_id']) ?? 0,
//       job_id: Job.fromMap(map['job_id']) ?? 0,
//       work_location: map['work_location'] ?? '',
//       mobile_phone: map['mobile_phone'] ?? '',
//       work_email: map['work_email'] ?? '',
//       company_id: Company.fromMap(map['company_id']) ?? 0,
//       parent_id: Partner.fromMap(map['parent_id']) ?? 0,
//       ssb_no: map['ssb_no'] ?? '',
//       ssb_issue_date: map['ssb_issue_date'] ?? '',
//       ssb_temporary_card: map['ssb_temporary_card'] ?? '',
//       ssb_temporary_card_no: map['ssb_temporary_card_no'] ?? '',
//       smart_card: map['smart_card'] ?? '',
//       smart_card_issue_date: map['smart_card_issue_date'] ?? '',
//       smart_card_no: map['smart_card_no'] ?? '',
//       fingerprint_id: map['fingerprint_id'] ?? '',
//       insurance_no: map['insurance_no'] ?? '',
//       insurance_company: map['insurance_company'] ?? '',
//       employee_insurance: map['employee_insurance'] ?? 0.0,
//       employer_insurance: map['employer_insurance'] ?? 0.0,
//       insurance_start_date: map['insurance_start_date'] ?? '',
//       insurance_end_date: map['insurance_end_date'] ?? '',
//       insurance_tax_exemption: map['insurance_tax_exemption'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Insurance.fromJson(String source) =>
//       Insurance.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Insurance(id: $id, name: $name, image_1920: $image_1920, job_title: $job_title, department_id: $department_id, job_id: $job_id, work_location: $work_location, mobile_phone: $mobile_phone, work_email: $work_email, company_id: $company_id, parent_id: $parent_id, ssb_no: $ssb_no, ssb_issue_date: $ssb_issue_date, ssb_temporary_card: $ssb_temporary_card, ssb_temporary_card_no: $ssb_temporary_card_no, smart_card: $smart_card, smart_card_issue_date: $smart_card_issue_date, smart_card_no: $smart_card_no, fingerprint_id: $fingerprint_id, insurance_no: $insurance_no, insurance_company: $insurance_company, employee_insurance: $employee_insurance, employer_insurance: $employer_insurance, insurance_start_date: $insurance_start_date, insurance_end_date: $insurance_end_date, insurance_tax_exemption: $insurance_tax_exemption)';
//   }

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is Insurance &&
//         o.id == id &&
//         o.name == name &&
//         o.image_1920 == image_1920 &&
//         o.job_title == job_title &&
//         o.department_id == department_id &&
//         o.job_id == job_id &&
//         o.work_location == work_location &&
//         o.mobile_phone == mobile_phone &&
//         o.work_email == work_email &&
//         o.company_id == company_id &&
//         o.parent_id == parent_id &&
//         o.ssb_no == ssb_no &&
//         o.ssb_issue_date == ssb_issue_date &&
//         o.ssb_temporary_card == ssb_temporary_card &&
//         o.ssb_temporary_card_no == ssb_temporary_card_no &&
//         o.smart_card == smart_card &&
//         o.smart_card_issue_date == smart_card_issue_date &&
//         o.smart_card_no == smart_card_no &&
//         o.fingerprint_id == fingerprint_id &&
//         o.insurance_no == insurance_no &&
//         o.insurance_company == insurance_company &&
//         o.employee_insurance == employee_insurance &&
//         o.employer_insurance == employer_insurance &&
//         o.insurance_start_date == insurance_start_date &&
//         o.insurance_end_date == insurance_end_date &&
//         o.insurance_tax_exemption == insurance_tax_exemption;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         name.hashCode ^
//         image_1920.hashCode ^
//         job_title.hashCode ^
//         department_id.hashCode ^
//         job_id.hashCode ^
//         work_location.hashCode ^
//         mobile_phone.hashCode ^
//         work_email.hashCode ^
//         company_id.hashCode ^
//         parent_id.hashCode ^
//         ssb_no.hashCode ^
//         ssb_issue_date.hashCode ^
//         ssb_temporary_card.hashCode ^
//         ssb_temporary_card_no.hashCode ^
//         smart_card.hashCode ^
//         smart_card_issue_date.hashCode ^
//         smart_card_no.hashCode ^
//         fingerprint_id.hashCode ^
//         insurance_no.hashCode ^
//         insurance_company.hashCode ^
//         employee_insurance.hashCode ^
//         employer_insurance.hashCode ^
//         insurance_start_date.hashCode ^
//         insurance_end_date.hashCode ^
//         insurance_tax_exemption.hashCode;
//   }
// }
