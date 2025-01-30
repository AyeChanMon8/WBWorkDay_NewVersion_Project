//import 'package:easy_localization/easy_localization.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:dio/dio.dart';
// import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:winbrother_hr_app/controllers/payslip_controller.dart';
import 'package:winbrother_hr_app/localization.dart';
import 'package:winbrother_hr_app/models/payslip.dart';
import 'package:winbrother_hr_app/my_class/my_app_bar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import 'package:winbrother_hr_app/my_class/theme.dart';
import 'package:winbrother_hr_app/utils/app_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PaySlipPage extends StatefulWidget {
  @override
  _PaySlipPageState createState() => _PaySlipPageState();
}

class _PaySlipPageState extends State<PaySlipPage> {
  int pindex = 0;

  final box = GetStorage();

  String image = "";

  String basic = "";

  String inc = "";

  String ot = "";

  String otdt = "";

  String ins = "";

  String unpaid = "";

  String eloan = "";

  String tloan = "";

  String ssb = "";

  String gross = "";

  String ict = "";

  String net = "";

  var format = NumberFormat('#,###.#');

  final PayslipController controller = Get.find();

  List<Category_list> category = [];

  @override
  void initState() {
    super.initState();
    //  _getImageSize();
  }

  getCategoryList() {
    List<Category_list> categoryList = [];
    categoryList = controller.paySlips[pindex].categoryList!;
    Category_list? deduction;
    Category_list? net;
    for (var i = 0; i < categoryList.length; i++) {
      switch (categoryList[i].name) {
        case 'Deduction':
          {
            deduction = categoryList[i];
          }
          break;
        case 'Net':
          {
            net = categoryList[i];
          }
          break;
        case 'Leave Deduction':
          {
            category.add(categoryList[i]);
            // category.add(deduction);
            // category.add(net);
          }
          break;
        default:
          category.add(categoryList[i]);
      }
      print("categoryName ${categoryList[i].name}");
    }
    category.add(deduction!);
    category.add(net!);
    print("category $category");
  }

  Widget payslipLineWidget(BuildContext contexxt) {
    getCategoryList();
    // _getImageSize();
    return Column(
      children: [
        Divider(
          thickness: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                'Description',
                //controller.paySlips[pindex].categoryList[index].lineList[ind].name,
                style: TextStyle(
                    color: Color.fromRGBO(58, 47, 112, 1),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: Text(
                'Amount (MMK)',
                style: TextStyle(
                    color: Color.fromRGBO(58, 47, 112, 1),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            )
          ],
        ),
        Divider(
          thickness: 1,
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          //controller: scrollController,
          shrinkWrap: true,
          itemCount: category
              .length, //controller.paySlips[pindex].categoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Container(
                        //     child: Text(
                        //       category[index].name,
                        //       // controller.paySlips[pindex].categoryList[index].name,
                        //       style: maintitleBoldStyle(),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height:30),
                        ListView.builder(
                          //controller: scrollController,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: category[index].lineList?.length ??
                              0, // controller.paySlips[pindex].categoryList[index].lineList.length,
                          itemBuilder: (BuildContext context, int ind) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          category[index].lineList![ind].name,
                                          //controller.paySlips[pindex].categoryList[index].lineList[ind].name,
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  58, 47, 112, 1)),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          AppUtils.addThousnadSperator(
                                            category[index].lineList![ind].total,
                                            //controller.paySlips[pindex].categoryList[index].lineList[ind].total
                                          ),
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  58, 47, 112, 1)),
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  )),
                                ),
                                // SizedBox(
                                //   height: 5,
                                // ),
                                (index == category.length - 1 &&
                                        ind ==
                                            category[index].lineList!.length - 1)
                                    ? SizedBox()
                                    : Divider(
                                        thickness: 1,
                                      ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    pindex = Get.arguments;

    final labels = AppLocalizations.of(context);
    DateTime tempDate = new DateFormat("yyyy-MM-dd")
        .parse(controller.paySlips[pindex].dateFrom);
    String date = DateFormat("MMMM yyyy").format(tempDate);
    String user_image = box.read('emp_image');
    String usercompany = box.read('emp_company_name');
    return Scaffold(
      appBar:PreferredSize(preferredSize: Size.fromHeight(60),child:  appbar(context, labels?.paySlip, user_image),),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            children: [
              controller.paySlips[pindex].company_logo != null &&
                      controller.paySlips[pindex].company_logo != false
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: Image.memory(
                                base64Decode(
                                    controller.paySlips[pindex].company_logo),
                                width: 300,
                                height: 100,
                                fit: BoxFit.contain)),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: 
                            // ElevatedButton(
                            //   child: Icon(Icons.download_sharp),
                            //   onPressed: _createPDF,
                            // ),
                            IconButton(
                              icon: Icon(
                                Icons.download_sharp,
                              ),
                              onPressed: () {
                                _createPDF();
                                //Get.toNamed(Routes.BOTTOM_NAVIGATION, arguments: "leave");
                              })
                          ),
                        ),
                      ],
                    )
                  : Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        child: Icon(Icons.download_sharp),
                        onPressed: _createPDF,
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  usercompany,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(58, 47, 112, 1),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Salary Slip- ${controller.paySlips[pindex].employeeId!.name} - $date',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(58, 47, 112, 1),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Table(
                border: TableBorder.all(color: Colors.black26),
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Description',
                          style:
                              TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                          '[' +
                              controller.paySlips[pindex].pin.toString() +
                              '] ' +
                              controller.paySlips[pindex].employeeId!.name,
                          style:
                              TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Designation',
                          style:
                              TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                          controller.paySlips[pindex].employeeId!.jobId!.name,
                          style:
                              TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                    ),
                  ]),
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('Reference',
                            style: TextStyle(
                                color: Color.fromRGBO(58, 47, 112, 1))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                            controller.paySlips[pindex].slip_number.toString(),
                            style: TextStyle(
                                color: Color.fromRGBO(58, 47, 112, 1))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('Bank Account',
                            style: TextStyle(
                                color: Color.fromRGBO(58, 47, 112, 1))),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                            controller.paySlips[pindex].bank_account_number !=
                                        false &&
                                    controller.paySlips[pindex]
                                            .bank_account_number !=
                                        null
                                ? controller
                                    .paySlips[pindex].bank_account_number
                                    .toString()
                                : "",
                            style: TextStyle(
                                color: Color.fromRGBO(58, 47, 112, 1))),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              payslipLineWidget(context),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'Authorized Signature',
                    style: TextStyle(
                        fontSize: 16, color: Color.fromRGBO(58, 47, 112, 1)),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat("yyyy-MM-dd").format(DateTime.now()),
                        style:
                            TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                    SizedBox(
                      height: 5,
                    ),
                    Text(DateFormat("HH:mm").format(DateTime.now()),
                        style:
                            TextStyle(color: Color.fromRGBO(58, 47, 112, 1))),
                  ],
                ),
              ),
              //        FooterView(
              //   children:<Widget>[
              //     new Padding(
              //       padding: new EdgeInsets.only(top:200.0),
              //       child: Center(
              //         child: new Text('Scrollable View'),
              //       ),
              //     ),
              //   ],
              //   footer: new Footer(
              //     child: Padding(
              //       padding: new EdgeInsets.all(10.0),
              //       child: Text('I am a Customizable footer!!')
              //     ),
              //   ),
              //   flex: 1, //default flex is 2
              // ),
            ],
          ),
        ),
        // child: Container(
        //   margin: EdgeInsets.only(left: 20, top: 20, right: 20),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Align(
        //         alignment: Alignment.centerRight,
        //         child: FlatButton(
        //           child: Icon(
        //             Icons.download_sharp
        //           ),
        //           onPressed: _createPDF,
        //         ),
        //       ),
        //       Container(
        //         child: Center(
        //           child: Text(
        //             usercompany,
        //             // "July Payroll",
        //             style: TextStyle(
        //                 fontSize: 20,
        //                 color: Color.fromRGBO(58, 47, 112, 1),
        //                 fontWeight: FontWeight.bold),
        //           ),
        //         ),
        //       ),
        //       Container(
        //         child: Center(
        //           child: Text(
        //             'Salary Slip-' +
        //                 date,
        //             // "July Payroll",
        //             style: TextStyle(
        //                 fontSize: 20,
        //                 color: Color.fromRGBO(58, 47, 112, 1),
        //                 fontWeight: FontWeight.bold),
        //           ),
        //         ),
        //       ),
        //       Container(
        //         margin: EdgeInsets.only(top: 40),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Container(
        //               child: Text(
        //                 labels.payrollPeriod,
        //                 style: subtitleStyle(),
        //               ),
        //             ),
        //             Container(
        //               child: Text(
        //                 AppUtils.removeNullString(controller.paySlips[pindex].month.toString())+"-"+AppUtils.removeNullString(controller.paySlips[pindex].year),
        //                 style: subtitleStyle(),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //       Container(
        //         margin: EdgeInsets.only(top: 20),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Container(
        //               child: Text(
        //                 'Period',
        //                 style: subtitleStyle(),
        //               ),
        //             ),
        //             Container(
        //               child: Text(
        //                 (controller.paySlips[pindex].dateFrom+"/"+controller.paySlips[pindex].dateTo),
        //                 style: subtitleStyle(),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //       Divider(
        //         thickness: 1,
        //       ),
        //       Container(
        //         margin: EdgeInsets.only(top: 20),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             // Container(
        //             //   child: Text(
        //             //     labels?.employeeName,
        //             //     style: subtitleStyle(),
        //             //   ),
        //             // ),
        //             Container(
        //               child: Text(
        //                 (controller.paySlips[pindex].employeeId.name),
        //                 style: subtitleStyle(),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //       Container(
        //         margin: EdgeInsets.only(top: 20),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [

        //             Container(
        //               child: Text(
        //                 (controller.paySlips[pindex].employeeId.jobId.name),
        //                 style: subtitleStyle(),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //       Container(
        //         margin: EdgeInsets.only(top: 20),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             // Container(
        //             //   child: Text(
        //             //     labels?.department,
        //             //     style: subtitleStyle(),
        //             //   ),
        //             // ),
        //             Container(
        //               child: Text(
        //                 (controller
        //                     .paySlips[pindex].employeeId.departmentId.name),
        //                 style: subtitleStyle(),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),

        //       // SizedBox(
        //       //   height: 10,
        //       // ),
        //       // Divider(
        //       //   thickness: 1,
        //       // ),
        //       SizedBox(
        //         height: 10,
        //       ),

        //       SizedBox(
        //         height: 10,
        //       ),
        //       Divider(
        //         thickness: 1,
        //       ),
        //       SizedBox(
        //         height: 10,
        //       ),

        //
      ),
      //     bottomNavigationBar: BottomAppBar(
      //       elevation: 0,
      //       color: Colors.transparent,
      //   child: Container(
      //      height: 40,
      //      padding: EdgeInsets.only(left: 30),
      //     child: Column(
      //       children: <Widget>[
      //         Row(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisSize: MainAxisSize.max,
      //             children: <Widget>[
      //               Text(DateFormat("yyyy-MM-dd").format(DateTime.now()),style: TextStyle(
      //                     color: Color.fromRGBO(58, 47, 112, 1))),
      //             ]),
      //         Row(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //             mainAxisSize: MainAxisSize.max,
      //             children: <Widget>[
      //               Text(DateFormat("HH:mm").format(DateTime.now()),style: TextStyle(
      //                     color: Color.fromRGBO(58, 47, 112, 1)))
      //             ]),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  Future<void> _createPDF() async {
    String empusercompany = box.read('emp_company_name');
    int empUserCompanyId = int.parse(box.read('emp_company'));
    DateTime tempDate1 = new DateFormat("yyyy-MM-dd")
        .parse(controller.paySlips[pindex].dateFrom);
    String paySlipDate = DateFormat("MMMM yyyy").format(tempDate1);
    List<Category_list> categoryList = [];
    categoryList = controller.paySlips[pindex].categoryList!;
    String file_name =
        controller.paySlips[pindex].employeeId!.name + paySlipDate;
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyyMMdd');
    var timeFormatter = new DateFormat('HHmmss');
    String formattedDate = formatter.format(now);
    String formattedTime = timeFormatter.format(now);
    String fileName = file_name.replaceAll(RegExp(r"\s+"), "") +
        "" +
        formattedDate +
        "" +
        formattedTime +
        '.pdf';
    PdfDocument document = PdfDocument();

    final page = document.pages.add();
    final Size pageSize = page.getClientSize();
    // PdfBitmap image = PdfBitmap(controller.paySlips[pindex].company_logo.toList());

    // row6.cells[0].value = PdfBitmap(controller.paySlips[pindex].company_logo.bodyBytes.toList());
    // grid6.applyBuiltInStyle(PdfGridBuiltInStyle.listTable4Accent5);
    //Draw grid in a new page created
    // grid6.draw(
    //     page: page,
    //     bounds: Rect.fromLTWH(0, 0, page.getClientSize().width,
    //         page.getClientSize().height));

    controller.paySlips[pindex].company_logo != null &&
            controller.paySlips[pindex].company_logo != false
        ? empUserCompanyId == 11
            ? page.graphics.drawImage(
                PdfBitmap.fromBase64String(
                    controller.paySlips[pindex].company_logo),
                Rect.fromLTWH(
                    (page.getClientSize().width / 2) - 200, 0, 400, 57),
              )
            : empUserCompanyId == 7 ||
                    empUserCompanyId == 3 ||
                    empUserCompanyId == 9
                ? page.graphics.drawImage(
                    PdfBitmap.fromBase64String(
                        controller.paySlips[pindex].company_logo),
                    Rect.fromLTWH(
                        (page.getClientSize().width / 2) - 50, 0, 100, 100),
                  )
                : page.graphics.drawImage(
                    PdfBitmap.fromBase64String(
                        controller.paySlips[pindex].company_logo),
                    Rect.fromLTWH(
                        (page.getClientSize().width / 2) - 130, 0, 280, 85),
                  )
        : SizedBox();

    // page.graphics.drawImage(
    // PdfBitmap.fromBase64String(controller.paySlips[pindex].company_logo),
    // Rect.fromLTWH(
    //     (page.getClientSize().width/2)-150, 0, 300, 100),
    // );

    double companyNameHeight =
        controller.paySlips[pindex].company_logo != null &&
                controller.paySlips[pindex].company_logo != false
            ? 120
            : 0;
    page.graphics.drawString(
        empusercompany, PdfStandardFont(PdfFontFamily.timesRoman, 20),
        format: PdfStringFormat(alignment: PdfTextAlignment.center),
        bounds: Rect.fromLTWH(
            0, companyNameHeight, pageSize.width, pageSize.height));

    double salarySlipHeight =
        controller.paySlips[pindex].company_logo != null &&
                controller.paySlips[pindex].company_logo != false
            ? 160
            : 40;

    page.graphics.drawString(
        'Salary Slip- ' +
            controller.paySlips[pindex].employeeId!.name +
            ' - ' +
            paySlipDate,
        PdfStandardFont(PdfFontFamily.timesRoman, 20),
        bounds: Rect.fromLTWH(
            0, salarySlipHeight, pageSize.width, pageSize.height));

    //Create a second PdfGrid in the same page
    final PdfGrid grid2 = PdfGrid();

    //Add columns to second grid
    grid2.columns.add(count: 4);

    //Add rows to grid
    PdfGridRow row11 = grid2.rows.add();
    row11.cells[0].value = 'Description';
    row11.cells[1].value = '[' +
        controller.paySlips[pindex].pin.toString() +
        '] ' +
        controller.paySlips[pindex].employeeId!.name;
    row11.cells[2].value = 'Designation';
    row11.cells[3].value = controller.paySlips[pindex].employeeId!.jobId!.name;
    PdfGridRow row12 = grid2.rows.add();
    row12.cells[0].value = 'Reference';
    row12.cells[1].value = controller.paySlips[pindex].slip_number.toString();
    row12.cells[2].value = 'Bank Account';
    row12.cells[3].value =
        controller.paySlips[pindex].bank_account_number != false &&
                controller.paySlips[pindex].bank_account_number != null
            ? controller.paySlips[pindex].bank_account_number.toString()
            : "";

    grid2.style = PdfGridStyle(
        cellPadding: PdfPaddings(left: 8, right: 8, top: 4, bottom: 4),
        backgroundBrush: PdfBrushes.white,
        textBrush: PdfBrushes.black,
        font: PdfStandardFont(PdfFontFamily.timesRoman, 16));
    //Draw the grid in PDF document page
    grid2.columns[0].width = 100;
    grid2.columns[2].width = 100;
    double tableHeaderHeight =
        controller.paySlips[pindex].company_logo != null &&
                controller.paySlips[pindex].company_logo != false
            ? 215
            : 90;

    grid2.draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, tableHeaderHeight, pageSize.width, pageSize.height));
    final PdfPen linePen = PdfPen(PdfColor(255, 255, 255), width: 1);
    final PdfBorders borders = PdfBorders(left: linePen, right: linePen);
    final PdfGrid grid = PdfGrid();
    grid.columns.add(count: 2);
    PdfGridRow row = grid.rows.add();

    //Add the rows to the grid
    row.cells[0].value = 'Description';
    row.cells[1].value = 'Amount (MMK)';
    row.cells[1].style.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.right);

    for (int i = 0; i < category.length; i++) {
      for (int j = 0; j < category[i].lineList!.length; j++) {
        row = grid.rows.add();
        row.cells[0].value = category[i].lineList![j].name;
        row.cells[1].value =
            AppUtils.addThousnadSperator(category[i].lineList![j].total)
                .toString();
        row.cells[1].style.stringFormat =
            PdfStringFormat(alignment: PdfTextAlignment.right);
      }
    }
    grid.style = PdfGridStyle(
      cellPadding: PdfPaddings(left: 4, right: 4, top: 4, bottom: 4),
      backgroundBrush: PdfBrushes.white,
      textBrush: PdfBrushes.black,
      font: PdfStandardFont(PdfFontFamily.timesRoman, 16),
    );

    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow headerRow = grid.rows[i];
      for (int j = 0; j < headerRow.cells.count; j++) {
        headerRow.cells[j].style.borders = borders;
      }
    }
    //Draw the grid
    double tableHeight = controller.paySlips[pindex].company_logo != null &&
            controller.paySlips[pindex].company_logo != false
        ? 310
        : 220;

    grid.draw(
        page: page,
        bounds: Rect.fromLTWH(0, tableHeight, pageSize.width, pageSize.height));

    double signatureHeight = controller.paySlips[pindex].company_logo != null &&
            controller.paySlips[pindex].company_logo != false
        ? 670
        : 640;
    page.graphics.drawString(
        "Authorized Signature", PdfStandardFont(PdfFontFamily.timesRoman, 16),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds:
            Rect.fromLTWH(0, signatureHeight, pageSize.width, pageSize.height));

    //Create the footer with specific bounds
    PdfPageTemplateElement footer = PdfPageTemplateElement(
      Rect.fromLTWH(0, 0, document.pageSettings.size.width, 50),
    );

    //Create the composite field with page number page count
    PdfCompositeField compositeField = PdfCompositeField(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        text: DateFormat("yyyy-MM-dd").format(DateTime.now()));
    compositeField.bounds = footer.bounds;
    compositeField.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.left);

    //Add the composite field in footer
    compositeField.draw(
      footer.graphics,
      Offset(0, 20 - PdfStandardFont(PdfFontFamily.timesRoman, 19).height),
    );

    PdfCompositeField compositeField1 = PdfCompositeField(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)),
        text: DateFormat("HH:mm").format(DateTime.now()));
    compositeField1.bounds = footer.bounds;
    compositeField1.stringFormat =
        PdfStringFormat(alignment: PdfTextAlignment.left);
    //Add the composite field in footer
    compositeField1.draw(
      footer.graphics,
      Offset(0, 50 - PdfStandardFont(PdfFontFamily.timesRoman, 19).height),
    );

    //Add the footer at the bottom of the document
    document.template.bottom = footer;

    var dio = Dio();

    final List<int> bytes =await document.save() as List<int>;
    document.dispose();

     if (Platform.isAndroid) {
      // var status = await Permission.storage.status;
      // if (!status.isGranted) {
      //   print("request");
      //   await Permission.storage.request();
      // }
      // the downloads folder path
      // String path = await ExtStorage.getExternalStoragePublicDirectory(
      //     ExtStorage.DIRECTORY_DOWNLOADS);
      String path = '';
      final directory = await getExternalStorageDirectory();

        if (directory == null) {
          print('Could not get external storage directory');
          return;
        }

        final downloadFolder = Directory('${directory.path}/Download');
        if (!await downloadFolder.exists()) {
          await downloadFolder.create(recursive: true);
        }
      // Directory? externalDirectory = Directory('/storage/emulated/0/Download');
      // if (externalDirectory != null) {
        path = downloadFolder.path;
        String fullPath = "$path/$fileName";
        File file = File(fullPath);
        await file.writeAsBytes(bytes, flush: true);
        // await requestManageExternalStoragePermission();
  final result = await OpenFile.open(fullPath);
        // OpenFile.open(fullPath);
      // } else {
      //   print('External Storage Directory not available');
      // }
    } else {
      var path = await getApplicationDocumentsDirectory();
      final file = new File('${path?.path}/$fileName');
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open('${path?.path}/$fileName');
    }
  }

  //  void _getImageSize() {
  //   final Image image = Image.memory(base64Decode(controller.paySlips[pindex].company_logo)).width; // Replace with your image path

  //   image.image.resolve(ImageConfiguration()).addListener(
  //     ImageStreamListener((ImageInfo imageInfo, bool synchronousCall) {
  //       setState(() {
  //         _imageWidth = imageInfo.image.width.toDouble();
  //         _imageHeight = imageInfo.image.height.toDouble();
  //       });
  //     }),
  //   );
  // }

  Future<void> requestManageExternalStoragePermission() async {
  if (Platform.isAndroid && await Permission.manageExternalStorage.isDenied) {
    var status = await Permission.manageExternalStorage.request();

    if (status.isGranted) {
      print("Permission granted.");
    } else {
      print("Permission denied.");
      // Redirect the user to app settings to enable the permission
      await openAppSettings();
    }
  }
}
}
