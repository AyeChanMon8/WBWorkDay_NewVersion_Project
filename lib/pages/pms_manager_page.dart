import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/constants/globals.dart';
import 'package:winbrother_hr_app/controllers/pms_list_controller.dart';
import 'package:winbrother_hr_app/models/pms_detail_model.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PmsManagerPage extends StatefulWidget {
  const PmsManagerPage({super.key});

  @override
  _PmsManagerPageState createState() => _PmsManagerPageState();
}
class _PmsManagerPageState extends State<PmsManagerPage> {
  final PmsListController controller = Get.put(PmsListController());
  bool pending = true;
  bool approved = true;
  bool rejected = true;
  final box = GetStorage();
  @override
  void initState() {
    super.initState();
    controller.offset.value = 0;
  }
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [

              Container(
                  padding: const EdgeInsets.only(left: 0, top: 10),
                  child: listViewWidget(context))
            ],
          ),
        ),
      ),
    );
  }
  Future _loadData() async {
    print("****loadmore****");
    controller.getPmsApprovalList();
  }
  Widget listViewWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    String role = box.read('role_category');
    controller.getPmsApprovalList();
    return Container(
        child: Obx(()=>NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!controller.isLoading.value && scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                print("*****BottomOfPmsList*****");
                if(controller.pmsManagerDetailModels.length>=10){
                  // start loading data
                  controller.offset.value +=Globals.pag_limit;
                  controller.isLoading.value = true;
                  _loadData();
                }
              }
              return true;
            },
            child:ListView.builder(
              shrinkWrap: true,
              itemCount: controller.pmsManagerDetailModels.value.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                PMSDetailModel pmsDetailModel = controller.pmsManagerDetailModels.value[index];
                return InkWell(
                  onTap: (){
                    Get.toNamed(Routes.PMS_Manager_DETAILS_PAGE,arguments: pmsDetailModel);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                    child: Column(
                      children: [
                        pmsDetailModel.isRatingMatch == false || pmsDetailModel.isRatingMatch == null ? 
                          Align(alignment: Alignment.centerRight, child: Padding(padding: const EdgeInsets.only(right: 8, bottom: 5),
                          child: Image.asset("assets/images/send_back_icon.png",
                          width: 18,
                          height: 18,),))
                          : const SizedBox(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(pmsDetailModel.name!,style: TextStyle(color: backgroundIconColor,fontWeight: FontWeight.bold),),
                                  const SizedBox(height: 20,),
                                  Text(pmsDetailModel.employeeId!.name,style: TextStyle(color: Colors.deepPurple[700]),),
                                  // SizedBox(height: 10,),
                                  // Text(pmsDetailModel.compTemplateId.name,style: TextStyle(color: Colors.deepPurple[700]),),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  //  Text('Deadline : ${
                                  //  AppUtils.changeDateFormat(pmsDetailModel.deadline)
                                  //
                                  // }',style: TextStyle(color: Colors.deepPurple[700]),),
                                  const SizedBox(height: 10,),
                                  Text('Period : ${pmsDetailModel.dateRangeId!.name}',style: TextStyle(color: Colors.deepPurple[700]),),
                                  const SizedBox(height: 20,),
                                  Container(
                                   padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10,top: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(pmsDetailModel.state.toString(),style: const TextStyle(color: Colors.white),)
                                  ),
                                  // pmsDetailModel.state == 'mid_year_self_assessment'|| pmsDetailModel.state == 'year_end_self_assessment' ?
                                  // Container(
                                  //   padding: EdgeInsets.only(left: 10,right: 10,bottom: 3,top: 3),
                                  //   decoration: BoxDecoration(
                                  //     color: pmsDetailModel.state == 'mid_year_self_assessment'|| pmsDetailModel.state == 'year_end_self_assessment'? Colors.grey : Colors.green,
                                  //     borderRadius: BorderRadius.circular(10),
                                  //   ),
                                  //   child: Text(pmsDetailModel.state == 'mid_year_self_assessment'|| pmsDetailModel.state == 'year_end_self_assessment' ?'To Manager Approve':'Manager Approved',style: TextStyle(color: Colors.white),),
                                  // ):
                                  // Container(
                                  //   padding: EdgeInsets.only(left: 10,right: 10,bottom: 3,top: 3),
                                  //   decoration: BoxDecoration(
                                  //     color: pmsDetailModel.state == 'mid_year_manager_approve'|| pmsDetailModel.state == 'year_end_manager_approve'? Colors.grey : Colors.green,
                                  //     borderRadius: BorderRadius.circular(10),
                                  //   ),
                                  //   child: Text(pmsDetailModel.state == 'mid_year_manager_approve'|| pmsDetailModel.state == 'year_end_manager_approve'?'To Dotted Manager Approve':'Dotted Manager Approved',style: TextStyle(color: Colors.white),),
                                  // ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
        ));
  }
}
