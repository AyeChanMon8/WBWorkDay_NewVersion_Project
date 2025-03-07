import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:winbrother_hr_app/constants/globals.dart';
import 'package:winbrother_hr_app/controllers/pms_list_controller.dart';
import 'package:winbrother_hr_app/models/pms_detail_model.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/routes/app_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PmsPage extends StatefulWidget {
  const PmsPage({super.key});

  @override
  _PmsPageState createState() => _PmsPageState();

}
class _PmsPageState extends State<PmsPage> {
  final PmsListController controller = Get.put(PmsListController());
  bool pending = true;
  bool approved = true;
  bool rejected = true;
  final box = GetStorage();
  // @override
  // void initState() {
  //   super.initState();
  //   controller.offset.value = 0;
  // }
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    String userImage = box.read('emp_image');
    var limit = Globals.pag_limit;
    return Scaffold(
      body: GetBuilder<PmsListController>(
        init: PmsListController(),
        builder:(controller) => RefreshIndicator(
          onRefresh: controller.getPmsList,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {

               if (!controller.isLoading.value && scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                if(controller.pmsDetailModels.length>=Globals.pag_limit){
                  controller.offset.value +=limit;
                  controller.isLoading.value = true;
                  _loadData();
                }

              }
            //   if (!controller.isLoading.value && scrollInfo.metrics.pixels ==
            //     scrollInfo.metrics.maxScrollExtent) {
            //   print("*****BottomOfPmsList*****");
            //   if(controller.pmsDetailModels.length>=10){
            //     controller.offset.value +=Globals.pag_limit;
            //     controller.isLoading.value = true;
            //     _loadData();
            //   }
            //   // start loading data

            // }
            return true;
            },
            child: Obx(() =>  ListView.builder(
            shrinkWrap: true,
            itemCount: controller.pmsDetailModels.length,
            itemBuilder: (BuildContext context, int index) {
              PMSDetailModel pmsDetailModel = controller.pmsDetailModels[index];

              // var deadLine = AppUtils.changeDateFormat(pmsDetailModel.deadline);
              return InkWell(
                onTap: (){
                  Get.toNamed(Routes.PMS_DETAILS_PAGE,arguments: pmsDetailModel);
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
                                const SizedBox(height: 5,),
                                Text(pmsDetailModel.templateId!.name,style: TextStyle(color: Colors.deepPurple[700]),),
                                // SizedBox(height: 5,),
                                // Text(pmsDetailModel.compTemplateId.name,style: TextStyle(color: Colors.deepPurple[700]),),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Text('Deadline : ${
                                //     DateFormat("dd/MM/yyyy").format(
                                //         DateTime.parse(pmsDetailModel.deadline))
                                //   }',style: TextStyle(color: Colors.deepPurple[700]),),
                                //Text('Deadline : ${deadLine}',style: TextStyle(color: Colors.deepPurple[700]),),
                                const SizedBox(height: 5,),
                                Text('Period : ${pmsDetailModel.dateRangeId!.name}',style: TextStyle(color: Colors.deepPurple[700]),),
                                const SizedBox(height: 5,),
                                Container(
                                  padding: const EdgeInsets.only(left: 10,right: 10,bottom: 3,top: 3),
                                  decoration: BoxDecoration(
                                    color: pmsDetailModel.state != 'mid_year_hr_approve' && pmsDetailModel.state != 'year_end_hr_approve' ? pmsDetailModel.state == 'sent_to_employee'? Colors.yellow[700] : Colors.blue : Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  //child: Text(pmsDetailModel.state == 'sent_to_employee'?'Draft':pmsDetailModel.state == 'acknowledge'?'Acknowledge':pmsDetailModel.state == 'mid_year_manager_approve'||pmsDetailModel.state == 'year_end_manager_approve'?'Approved':pmsDetailModel.state == 'mid_year_dotted_manager_approve'||pmsDetailModel.state == 'year_end_dotted_manager_approve'?"Manager Approved":pmsDetailModel.state == 'mid_year_hr_approve'||pmsDetailModel.state == 'year_end_hr_approve'?"HR Approved":"Submit",style: TextStyle(color: Colors.white),),
                                  child:Text(pmsDetailModel.state.toString()),
                                ),
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
      // SingleChildScrollView(
      //   child: Container(
      //     child: Column(
      //       children: [
      //         Container(
      //             padding: const EdgeInsets.only(left: 0, top: 10),
      //             child: listViewWidget(context))
      //       ],
      //     ),
      //   ),
      // ),
    ))) );
  }

  Future _loadData() async {
    print("****loadmore****");
    controller.getPmsList();
  }

  Widget listViewWidget(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Container(
      child: Obx(()=>NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!controller.isLoading.value && scrollInfo.metrics.pixels ==
                scrollInfo.metrics.maxScrollExtent) {
              print("*****BottomOfPmsList*****");
              if(controller.pmsDetailModels.length>=10){
                controller.offset.value +=Globals.pag_limit;
                controller.isLoading.value = true;
                _loadData();
              }
              // start loading data

            }
            return true;
          },
          child:ListView.builder(
            shrinkWrap: true,
            itemCount: controller.pmsDetailModels.length,
            itemBuilder: (BuildContext context, int index) {
              PMSDetailModel pmsDetailModel = controller.pmsDetailModels[index];

              // var deadLine = AppUtils.changeDateFormat(pmsDetailModel.deadline);
              return InkWell(
                onTap: (){
                  Get.toNamed(Routes.PMS_DETAILS_PAGE,arguments: pmsDetailModel);
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
                                const SizedBox(height: 5,),
                                Text(pmsDetailModel.templateId!.name,style: TextStyle(color: Colors.deepPurple[700]),),
                                // SizedBox(height: 5,),
                                // Text(pmsDetailModel.compTemplateId.name,style: TextStyle(color: Colors.deepPurple[700]),),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Text('Deadline : ${
                                //     DateFormat("dd/MM/yyyy").format(
                                //         DateTime.parse(pmsDetailModel.deadline))
                                //   }',style: TextStyle(color: Colors.deepPurple[700]),),
                                //Text('Deadline : ${deadLine}',style: TextStyle(color: Colors.deepPurple[700]),),
                                const SizedBox(height: 5,),
                                Text('Period : ${pmsDetailModel.dateRangeId!.name}',style: TextStyle(color: Colors.deepPurple[700]),),
                                const SizedBox(height: 5,),
                                Container(
                                  padding: const EdgeInsets.only(left: 10,right: 10,bottom: 3,top: 3),
                                  decoration: BoxDecoration(
                                    color: pmsDetailModel.state != 'mid_year_hr_approve' && pmsDetailModel.state != 'year_end_hr_approve' ? pmsDetailModel.state == 'sent_to_employee'? Colors.yellow[700] : Colors.blue : Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  //child: Text(pmsDetailModel.state == 'sent_to_employee'?'Draft':pmsDetailModel.state == 'acknowledge'?'Acknowledge':pmsDetailModel.state == 'mid_year_manager_approve'||pmsDetailModel.state == 'year_end_manager_approve'?'Approved':pmsDetailModel.state == 'mid_year_dotted_manager_approve'||pmsDetailModel.state == 'year_end_dotted_manager_approve'?"Manager Approved":pmsDetailModel.state == 'mid_year_hr_approve'||pmsDetailModel.state == 'year_end_hr_approve'?"HR Approved":"Submit",style: TextStyle(color: Colors.white),),
                                  child:Text(pmsDetailModel.state.toString()),
                                ),
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
          )),),
    );
  }
}