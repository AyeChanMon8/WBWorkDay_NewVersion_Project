// /*
// *  dashboard_widget.dart
// *  WB-prototype(V-3)
// *
// *  Created by .
// *  Copyright © 2018 . All rights reserved.
//     */

// import 'package:flutter/material.dart';
// import 'package:flutter_shell/styles/values.dart';

// class DashboardWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         constraints: BoxConstraints.expand(),
//         decoration: BoxDecoration(
//           color: Color.fromARGB(255, 251, 251, 251),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               height: 17,
//               child: Image.asset(
//                 "assets/images/noti-bar.png",
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Container(
//               height: 343,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Positioned(
//                     top: 0,
//                     right: 0,
//                     child: Image.asset(
//                       "assets/images/path-48.png",
//                       fit: BoxFit.none,
//                     ),
//                   ),
//                   Positioned(
//                     left: 0,
//                     top: 30,
//                     right: 1,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Align(
//                           alignment: Alignment.topRight,
//                           child: Container(
//                             width: 291,
//                             height: 45,
//                             margin: EdgeInsets.only(right: 39),
//                             child: Row(
//                               children: [
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Container(
//                                     width: 213,
//                                     height: 26,
//                                     margin: EdgeInsets.only(top: 16),
//                                     child: Stack(
//                                       alignment: Alignment.center,
//                                       children: [
//                                         Positioned(
//                                           left: 2,
//                                           right: 0,
//                                           child: Text(
//                                             "Welcome, Han Tun Zaw",
//                                             textAlign: TextAlign.left,
//                                             style: TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 255, 255, 255),
//                                               fontFamily: "Roboto",
//                                               fontWeight: FontWeight.w700,
//                                               fontSize: 20,
//                                             ),
//                                           ),
//                                         ),
//                                         Positioned(
//                                           left: 0,
//                                           right: 20,
//                                           bottom: 0,
//                                           child: Container(
//                                             height: 1,
//                                             decoration: BoxDecoration(
//                                               color: Color.fromARGB(
//                                                   255, 216, 183, 7),
//                                             ),
//                                             child: Container(),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Spacer(),
//                                 Container(
//                                   width: 45,
//                                   height: 45,
//                                   child: Image.asset(
//                                     "assets/images/ellipse-7-2.png",
//                                     fit: BoxFit.none,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Container(
//                           height: 218,
//                           margin: EdgeInsets.only(top: 50),
//                           decoration: BoxDecoration(
//                             color: AppColors.primaryBackground,
//                             boxShadow: [
//                               Shadows.secondaryShadow,
//                             ],
//                           ),
//                           child: Container(),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Positioned(
//                     top: 149,
//                     child: Stack(
//                       alignment: Alignment.centerRight,
//                       children: [
//                         Positioned(
//                           right: 28,
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Container(
//                                 width: 85,
//                                 height: 68,
//                                 child: Column(
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment.stretch,
//                                   children: [
//                                     Container(
//                                       height: 48,
//                                       margin:
//                                           EdgeInsets.only(left: 18, right: 19),
//                                       child: Image.asset(
//                                         "assets/images/icon-feather-plus-circle.png",
//                                         fit: BoxFit.none,
//                                       ),
//                                     ),
//                                     Spacer(),
//                                     Text(
//                                       "Create Request",
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                         color: AppColors.primaryText,
//                                         fontFamily: "Roboto",
//                                         fontWeight: FontWeight.w700,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Align(
//                                 alignment: Alignment.bottomLeft,
//                                 child: Container(
//                                   width: 50,
//                                   height: 67,
//                                   margin: EdgeInsets.only(left: 24),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.stretch,
//                                     children: [
//                                       Container(
//                                         height: 45,
//                                         margin:
//                                             EdgeInsets.only(left: 1, right: 4),
//                                         child: Image.asset(
//                                           "assets/images/icon-awesome-check-circle-2.png",
//                                           fit: BoxFit.none,
//                                         ),
//                                       ),
//                                       Spacer(),
//                                       Text(
//                                         "Approval",
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color: AppColors.primaryText,
//                                           fontFamily: "Roboto",
//                                           fontWeight: FontWeight.w700,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Spacer(),
//                               Container(
//                                 width: 103,
//                                 height: 66,
//                                 margin: EdgeInsets.only(top: 1),
//                                 child: Column(
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment.stretch,
//                                   children: [
//                                     Align(
//                                       alignment: Alignment.topCenter,
//                                       child: Container(
//                                         width: 45,
//                                         height: 45,
//                                         child: Stack(
//                                           alignment: Alignment.center,
//                                           children: [
//                                             Positioned(
//                                               top: 0,
//                                               child: Container(
//                                                 width: 45,
//                                                 height: 45,
//                                                 decoration: BoxDecoration(
//                                                   color: AppColors
//                                                       .secondaryElement,
//                                                   borderRadius:
//                                                       Radii.k22pxRadius,
//                                                 ),
//                                                 child: Container(),
//                                               ),
//                                             ),
//                                             Positioned(
//                                               top: 7,
//                                               child: Image.asset(
//                                                 "assets/images/icon-ionic-ios-finger-print.png",
//                                                 fit: BoxFit.none,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     Spacer(),
//                                     Text(
//                                       "Attendance Report",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         color: AppColors.primaryText,
//                                         fontFamily: "Roboto",
//                                         fontWeight: FontWeight.w700,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Positioned(
//                           left: 0,
//                           right: 0,
//                           bottom: 0,
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Align(
//                                 alignment: Alignment.bottomLeft,
//                                 child: Container(
//                                   width: 102,
//                                   height: 67,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.stretch,
//                                     children: [
//                                       Align(
//                                         alignment: Alignment.topCenter,
//                                         child: Container(
//                                           width: 45,
//                                           height: 45,
//                                           child: Stack(
//                                             alignment: Alignment.center,
//                                             children: [
//                                               Positioned(
//                                                 top: 0,
//                                                 child: Container(
//                                                   width: 45,
//                                                   height: 45,
//                                                   decoration: BoxDecoration(
//                                                     color: AppColors
//                                                         .secondaryElement,
//                                                     borderRadius:
//                                                         Radii.k22pxRadius,
//                                                   ),
//                                                   child: Container(),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top: 16,
//                                                 child: Image.asset(
//                                                   "assets/images/bxs-user-detail.png",
//                                                   fit: BoxFit.none,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       Spacer(),
//                                       Opacity(
//                                         opacity: 0.7,
//                                         child: Text(
//                                           "Attendance Report",
//                                           textAlign: TextAlign.left,
//                                           style: TextStyle(
//                                             color: AppColors.primaryText,
//                                             fontFamily: "Roboto",
//                                             fontWeight: FontWeight.w700,
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Spacer(),
//                               Align(
//                                 alignment: Alignment.bottomLeft,
//                                 child: Container(
//                                   width: 102,
//                                   height: 66,
//                                   margin: EdgeInsets.only(bottom: 2),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.stretch,
//                                     children: [
//                                       Align(
//                                         alignment: Alignment.topCenter,
//                                         child: Container(
//                                           width: 45,
//                                           height: 45,
//                                           child: Stack(
//                                             alignment: Alignment.center,
//                                             children: [
//                                               Positioned(
//                                                 top: 0,
//                                                 child: Container(
//                                                   width: 45,
//                                                   height: 45,
//                                                   decoration: BoxDecoration(
//                                                     color: AppColors
//                                                         .secondaryElement,
//                                                     borderRadius:
//                                                         Radii.k22pxRadius,
//                                                   ),
//                                                   child: Container(),
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top: 13,
//                                                 child: Image.asset(
//                                                   "assets/images/bx-git-repo-forked.png",
//                                                   fit: BoxFit.none,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       Spacer(),
//                                       Opacity(
//                                         opacity: 0.7,
//                                         child: Text(
//                                           "Organization Chart",
//                                           textAlign: TextAlign.left,
//                                           style: TextStyle(
//                                             color: AppColors.primaryText,
//                                             fontFamily: "Roboto",
//                                             fontWeight: FontWeight.w700,
//                                             fontSize: 12,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 230,
//               margin: EdgeInsets.only(top: 9),
//               decoration: BoxDecoration(
//                 color: AppColors.primaryBackground,
//                 boxShadow: [
//                   Shadows.secondaryShadow,
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Container(
//                       margin: EdgeInsets.only(left: 18, top: 10),
//                       child: Text(
//                         "Announcements",
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                           color: AppColors.primaryText,
//                           fontFamily: "Roboto",
//                           fontWeight: FontWeight.w700,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Opacity(
//                     opacity: 0.21598,
//                     child: Container(
//                       height: 2,
//                       margin: EdgeInsets.only(top: 6),
//                       decoration: BoxDecoration(
//                         color: AppColors.secondaryElement,
//                       ),
//                       child: Container(),
//                     ),
//                   ),
//                   Container(
//                     height: 45,
//                     margin: EdgeInsets.only(left: 39, top: 21, right: 18),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Container(
//                             width: 45,
//                             height: 45,
//                             child: Image.asset(
//                               "assets/images/ellipse-8.png",
//                               fit: BoxFit.none,
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Container(
//                             width: 121,
//                             height: 32,
//                             margin: EdgeInsets.only(left: 15, top: 8),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Text(
//                                     "Announcements 1",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       color: AppColors.primaryText,
//                                       fontFamily: "Roboto",
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ),
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Opacity(
//                                     opacity: 0.5,
//                                     child: Text(
//                                       "From Project Manager",
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                         color: AppColors.primaryText,
//                                         fontFamily: "Roboto",
//                                         fontWeight: FontWeight.w700,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Spacer(),
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Container(
//                             width: 7,
//                             height: 15,
//                             margin: EdgeInsets.only(top: 20),
//                             child: Image.asset(
//                               "assets/images/icon-ionic-ios-arrow-forward-2.png",
//                               fit: BoxFit.none,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Opacity(
//                     opacity: 0.2,
//                     child: Container(
//                       height: 1,
//                       margin: EdgeInsets.only(left: 1, top: 21),
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 216, 183, 7),
//                       ),
//                       child: Container(),
//                     ),
//                   ),
//                   Container(
//                     height: 45,
//                     margin: EdgeInsets.only(left: 39, top: 11, right: 18),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Container(
//                             width: 45,
//                             height: 45,
//                             child: Image.asset(
//                               "assets/images/ellipse-8-11.png",
//                               fit: BoxFit.none,
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Container(
//                             width: 98,
//                             height: 32,
//                             margin: EdgeInsets.only(left: 15, top: 6),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Text(
//                                     "Announcements 2",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       color: AppColors.primaryText,
//                                       fontFamily: "Roboto",
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ),
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Opacity(
//                                     opacity: 0.5,
//                                     child: Text(
//                                       "From admin",
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                         color: AppColors.primaryText,
//                                         fontFamily: "Roboto",
//                                         fontWeight: FontWeight.w700,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Spacer(),
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Container(
//                             width: 7,
//                             height: 15,
//                             margin: EdgeInsets.only(top: 15),
//                             child: Image.asset(
//                               "assets/images/icon-ionic-ios-arrow-forward-2.png",
//                               fit: BoxFit.none,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Spacer(),
//                   Opacity(
//                     opacity: 0.2,
//                     child: Container(
//                       height: 1,
//                       margin: EdgeInsets.only(left: 1, bottom: 7),
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 216, 183, 7),
//                       ),
//                       child: Container(),
//                     ),
//                   ),
//                   Container(
//                     height: 18,
//                     margin: EdgeInsets.only(left: 34, right: 18, bottom: 8),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Align(
//                           alignment: Alignment.bottomLeft,
//                           child: Text(
//                             "All announcements ",
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               color: AppColors.primaryText,
//                               fontFamily: "Roboto",
//                               fontWeight: FontWeight.w700,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                         Spacer(),
//                         Align(
//                           alignment: Alignment.bottomLeft,
//                           child: Container(
//                             margin: EdgeInsets.only(right: 11, bottom: 1),
//                             child: Opacity(
//                               opacity: 0.6,
//                               child: Text(
//                                 "9",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: AppColors.primaryText,
//                                   fontFamily: "Roboto",
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.bottomLeft,
//                           child: Container(
//                             width: 7,
//                             height: 15,
//                             margin: EdgeInsets.only(bottom: 3),
//                             child: Image.asset(
//                               "assets/images/icon-ionic-ios-arrow-forward-2.png",
//                               fit: BoxFit.none,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Opacity(
//                     opacity: 0.2,
//                     child: Container(
//                       height: 1,
//                       margin: EdgeInsets.only(left: 1),
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 216, 183, 7),
//                       ),
//                       child: Container(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Spacer(),
//             Container(
//               height: 230,
//               margin: EdgeInsets.only(bottom: 34),
//               decoration: BoxDecoration(
//                 color: AppColors.primaryBackground,
//                 boxShadow: [
//                   Shadows.secondaryShadow,
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Container(
//                       margin: EdgeInsets.only(left: 18, top: 10),
//                       child: Text(
//                         "Notifications",
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                           color: AppColors.primaryText,
//                           fontFamily: "Roboto",
//                           fontWeight: FontWeight.w700,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Opacity(
//                     opacity: 0.21598,
//                     child: Container(
//                       height: 2,
//                       margin: EdgeInsets.only(top: 6),
//                       decoration: BoxDecoration(
//                         color: AppColors.secondaryElement,
//                       ),
//                       child: Container(),
//                     ),
//                   ),
//                   Container(
//                     height: 45,
//                     margin: EdgeInsets.only(left: 39, top: 21, right: 18),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Container(
//                             width: 45,
//                             height: 45,
//                             child: Image.asset(
//                               "assets/images/ellipse-8.png",
//                               fit: BoxFit.none,
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Container(
//                             width: 121,
//                             height: 32,
//                             margin: EdgeInsets.only(left: 15, top: 8),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Text(
//                                     "Announcements 1",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       color: AppColors.primaryText,
//                                       fontFamily: "Roboto",
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ),
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Opacity(
//                                     opacity: 0.5,
//                                     child: Text(
//                                       "From Project Manager",
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                         color: AppColors.primaryText,
//                                         fontFamily: "Roboto",
//                                         fontWeight: FontWeight.w700,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Spacer(),
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Container(
//                             width: 7,
//                             height: 15,
//                             margin: EdgeInsets.only(top: 20),
//                             child: Image.asset(
//                               "assets/images/icon-ionic-ios-arrow-forward-2.png",
//                               fit: BoxFit.none,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Opacity(
//                     opacity: 0.2,
//                     child: Container(
//                       height: 1,
//                       margin: EdgeInsets.only(left: 1, top: 21),
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 216, 183, 7),
//                       ),
//                       child: Container(),
//                     ),
//                   ),
//                   Container(
//                     height: 45,
//                     margin: EdgeInsets.only(left: 39, top: 11, right: 18),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Container(
//                             width: 45,
//                             height: 45,
//                             child: Image.asset(
//                               "assets/images/ellipse-8-11.png",
//                               fit: BoxFit.none,
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Container(
//                             width: 98,
//                             height: 32,
//                             margin: EdgeInsets.only(left: 15, top: 6),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Text(
//                                     "Announcements 2",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       color: AppColors.primaryText,
//                                       fontFamily: "Roboto",
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ),
//                                 Align(
//                                   alignment: Alignment.topLeft,
//                                   child: Opacity(
//                                     opacity: 0.5,
//                                     child: Text(
//                                       "From admin",
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                         color: AppColors.primaryText,
//                                         fontFamily: "Roboto",
//                                         fontWeight: FontWeight.w700,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Spacer(),
//                         Align(
//                           alignment: Alignment.topLeft,
//                           child: Container(
//                             width: 7,
//                             height: 15,
//                             margin: EdgeInsets.only(top: 15),
//                             child: Image.asset(
//                               "assets/images/icon-ionic-ios-arrow-forward-2.png",
//                               fit: BoxFit.none,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Spacer(),
//                   Opacity(
//                     opacity: 0.2,
//                     child: Container(
//                       height: 1,
//                       margin: EdgeInsets.only(left: 1, bottom: 7),
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 216, 183, 7),
//                       ),
//                       child: Container(),
//                     ),
//                   ),
//                   Container(
//                     height: 18,
//                     margin: EdgeInsets.only(left: 34, right: 18, bottom: 8),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Align(
//                           alignment: Alignment.bottomLeft,
//                           child: Text(
//                             "All announcements ",
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               color: AppColors.primaryText,
//                               fontFamily: "Roboto",
//                               fontWeight: FontWeight.w700,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ),
//                         Spacer(),
//                         Align(
//                           alignment: Alignment.bottomLeft,
//                           child: Container(
//                             margin: EdgeInsets.only(right: 11, bottom: 1),
//                             child: Opacity(
//                               opacity: 0.6,
//                               child: Text(
//                                 "9",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: AppColors.primaryText,
//                                   fontFamily: "Roboto",
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.bottomLeft,
//                           child: Container(
//                             width: 7,
//                             height: 15,
//                             margin: EdgeInsets.only(bottom: 3),
//                             child: Image.asset(
//                               "assets/images/icon-ionic-ios-arrow-forward-2.png",
//                               fit: BoxFit.none,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Opacity(
//                     opacity: 0.2,
//                     child: Container(
//                       height: 1,
//                       margin: EdgeInsets.only(left: 1),
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 216, 183, 7),
//                       ),
//                       child: Container(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 56,
//               margin: EdgeInsets.only(bottom: 1),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Positioned(
//                     left: 0,
//                     right: 0,
//                     child: Container(
//                       height: 56,
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: Color.fromARGB(51, 0, 0, 0),
//                             offset: Offset(0, 1),
//                             blurRadius: 3,
//                           ),
//                         ],
//                       ),
//                       child: Image.asset(
//                         "assets/images/surface-2.png",
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 21,
//                     right: 21,
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Container(
//                             width: 34,
//                             height: 46,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Container(
//                                   height: 25,
//                                   margin: EdgeInsets.only(left: 3, right: 4),
//                                   child: Image.asset(
//                                     "assets/images/icon---favorite---filled.png",
//                                     fit: BoxFit.none,
//                                   ),
//                                 ),
//                                 Spacer(),
//                                 Text(
//                                   "Home",
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                     color: AppColors.secondaryText,
//                                     fontFamily: "Roboto",
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 12,
//                                     letterSpacing: 0.3804,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Container(
//                             width: 24,
//                             height: 46,
//                             margin: EdgeInsets.only(left: 58),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Container(
//                                   height: 24,
//                                   child: Image.asset(
//                                     "assets/images/icon---circle---filled.png",
//                                     fit: BoxFit.none,
//                                   ),
//                                 ),
//                                 Spacer(),
//                                 Container(
//                                   margin: EdgeInsets.only(left: 4, right: 3),
//                                   child: Text(
//                                     "HR",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       color: AppColors.secondaryText,
//                                       fontFamily: "Roboto",
//                                       fontWeight: FontWeight.w400,
//                                       fontSize: 12,
//                                       letterSpacing: 0.3804,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Spacer(),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Container(
//                             width: 37,
//                             height: 46,
//                             margin: EdgeInsets.only(right: 37),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Container(
//                                   height: 24,
//                                   margin: EdgeInsets.only(left: 4, right: 7),
//                                   child: Image.asset(
//                                     "assets/images/icon---event---filled.png",
//                                     fit: BoxFit.none,
//                                   ),
//                                 ),
//                                 Spacer(),
//                                 Text(
//                                   "Admin",
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                     color: AppColors.secondaryText,
//                                     fontFamily: "Roboto",
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 12,
//                                     letterSpacing: 0.3804,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Container(
//                             width: 52,
//                             height: 47,
//                             margin: EdgeInsets.only(right: 45),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Container(
//                                   height: 24,
//                                   margin: EdgeInsets.symmetric(horizontal: 14),
//                                   child: Image.asset(
//                                     "assets/images/icon---search---filled.png",
//                                     fit: BoxFit.none,
//                                   ),
//                                 ),
//                                 Spacer(),
//                                 Text(
//                                   "Message",
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                     color: AppColors.secondaryText,
//                                     fontFamily: "Roboto",
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 12,
//                                     letterSpacing: 0.3804,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Container(
//                             width: 30,
//                             height: 46,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Container(
//                                   height: 24,
//                                   margin: EdgeInsets.only(left: 4, right: 2),
//                                   child: Image.asset(
//                                     "assets/images/icon---thumbs-up---dark.png",
//                                     fit: BoxFit.none,
//                                   ),
//                                 ),
//                                 Spacer(),
//                                 Text(
//                                   "More",
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                     color: AppColors.secondaryText,
//                                     fontFamily: "Roboto",
//                                     fontWeight: FontWeight.w400,
//                                     fontSize: 12,
//                                     letterSpacing: 0.3804,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
