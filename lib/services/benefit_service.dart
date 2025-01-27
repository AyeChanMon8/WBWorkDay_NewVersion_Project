
import 'package:dio/dio.dart';
import '../constants/globals.dart';
import '../models/employee_benefit.dart';
import '../services/odoo_service.dart';
class BenefitService extends OdooService {
  Dio dioClient = Dio();
  @override
  Future<BenefitService> init() async {
    print('EmployeeService has been initialize');
    dioClient = await client();
    return this;
  }

  Future<List<EmployeeBenefit>> fetchEmployeeBenefit(String empID, String offset) async {
    //List<dynamic> empIds = await getEmployeeList(int.tryParse(empID));
    String url = Globals.baseURL +
        "/employee.job.benefit.line?filters=[('emp_benefit_id','='," + empID.toString() + ")]&limit="+Globals.pag_limit.toString()+"&offset="+offset+"&order=id asc";
    Response response = await dioClient.get(url);
    List<EmployeeBenefit> employee_benefit_list = <EmployeeBenefit>[];
    if (response.statusCode == 200) {
      print(response.toString());
      if (response.data['count'] != 0) {
        var list = response.data['results'];
        list.forEach((v) {
          employee_benefit_list.add(EmployeeBenefit.fromMap(v));
        });
      }
    }
    return employee_benefit_list;
  }
}
