import 'package:get/get.dart';
import '../bindings/business_travel_update_bindings.dart';
import '../bindings/leave_request_update_bindings.dart';
import '../bindings/out_of_pocket_update_bindings.dart';
import '../bindings/overtime_list_tabbar_binding.dart';
import '../bindings/purchase_order_binding.dart';
import '../bindings/travel_request_update_binding.dart';
import '../pages/TripExpenseApproval.dart';
import '../pages/admin_page.dart';
import '../pages/announcement_approval_detail_page.dart';
import '../pages/announcement_approve_tab_page.dart';
import '../pages/announcements_details.dart';
import '../pages/announcements_list.dart';
import '../pages/approval_attendance_details.dart';
import '../pages/approval_attendance_list.dart';
import '../pages/approval_details.dart';
import '../pages/approval_details_page/approved_outofpocket_details.dart';
import '../pages/approval_details_page/approved_travel_expense_details.dart';
import '../pages/approval_details_page/expense_travel_approval.dart';
import '../pages/approval_details_page/out_of_pocket_approval.dart';
import '../pages/approval_employee_change_details.dart';
import '../pages/approval_loan_details.dart';
import '../pages/approval_ot_detail.dart';
import '../pages/approval_ot_list.dart';
import '../pages/approval_page.dart';
import '../pages/approval_resignation_details.dart';
import '../pages/approval_route_details.dart';
import '../pages/approval_suspension_details.dart';
import '../pages/approval_travel_details.dart';
import '../pages/approved_employee_change_details.dart';
import '../pages/approved_leave_details.dart';
import '../pages/approved_loan_details.dart';
import '../pages/approved_manintenance_detail_page.dart';
import '../pages/approved_resignation_details.dart';
import '../pages/approved_route_details.dart';
import '../pages/approved_suspension_details.dart';
import '../pages/approved_travel_details.dart';
import '../pages/approved_travel_list_page.dart';
import '../pages/attendance_approval_list.dart';
import '../pages/attendance_report.dart';
import '../pages/attendance_request.dart';
import '../pages/bottom_navigation.dart';
import '../pages/business_travel_create.dart';
import '../pages/business_travel_update.dart';
import '../pages/calendar_page.dart';
import '../pages/calendar_profile_deatil_list.dart';
import '../pages/change_password_page.dart';
import '../pages/chat.dart';
import '../pages/claim_insurance_detail.dart';
import '../pages/claim_insurance_page.dart';
import '../pages/configuration_page.dart';
import '../pages/create_day_trip.dart';
import '../pages/create_employee_change_form.dart';
import '../pages/create_insurance_page.dart';
import '../pages/create_plan_trip.dart';
import '../pages/create_request_page.dart';
import '../pages/create_route_date_plantrip_waybill_page.dart';
import '../pages/day_trip_list.dart';
import '../pages/daytrip_tabbar.dart';
import '../pages/document_list.dart';
import '../pages/documentation.dart';
import '../pages/employee_approval_tabar.dart';
import '../pages/employee_benefit_page/employee_benefit_detail_page.dart';
import '../pages/employee_benefit_page/employee_benefit_list_page.dart';
import '../pages/employee_changes_details.dart';
import '../pages/employee_changes_list.dart';
import '../pages/employee_document_details.dart';
import '../pages/employee_document_list.dart';
import '../pages/employee_insurance_detail_page.dart';
import '../pages/expense_report_tabbar.dart';
import '../pages/expense_tab.dart';
import '../pages/first_approval_employee_change_details.dart';
import '../pages/fleet_insurance_detail.dart';
import '../pages/fleet_list_page.dart';
import '../pages/fleet_page.dart';
import '../pages/forget_password.dart';
import '../pages/home_page.dart';
import '../pages/hr_page.dart';
import '../pages/insurance_page.dart';
import '../pages/insurance_page/approved_insurance_details.dart';
import '../pages/insurance_page/insurance_approval.dart';
import '../pages/insurance_page/insurance_approval_tabar.dart';
import '../pages/language.dart';
import '../pages/leave_approval_tabbar.dart';
import '../pages/leave_detail.dart';
import '../pages/leave_request_update.dart';
import '../pages/leave_trip_report.dart';
import '../pages/leave_trip_request.dart';
import '../pages/leave_trip_tabbar.dart';
import '../pages/loan_approval_tabar.dart';
import '../pages/loan_details_page.dart';
import '../pages/loan_list_page.dart';
import '../pages/login_page.dart';
import '../pages/maintenance_detail_page.dart';
import '../pages/maintenance_request.dart';
import '../pages/maintenance_tabbar.dart';
import '../pages/notification_details.dart';
import '../pages/notification_list.dart';
import '../pages/organization_chart.dart';
import '../pages/otp_confirm_page.dart';
import '../pages/out_of_pocket_create.dart';
import '../pages/out_of_pocket_page/out_of_pocket_detail.dart';
import '../pages/out_of_pocket_page/outofpocket_approval_tabar.dart';
import '../pages/out_of_pocket_update.dart';
import '../pages/over_time.dart';
import '../pages/overtime_decline.dart';
import '../pages/overtime_details.dart';
import '../pages/overtime_list_tabbar.dart';
import '../pages/overtime_response_details.dart';
import '../pages/pay_slip_list.dart';
import '../pages/payslip_page.dart';
import '../pages/plantrip_details.dart';
import '../pages/plantrip_tabbar.dart';
import '../pages/plantrip_waybill_details.dart';
import '../pages/plantrip_waybill_tabar.dart';
import '../pages/pms_details.dart';
import '../pages/pms_done_details.dart';
import '../pages/pms_force_manager_detail_page.dart';
import '../pages/pms_hod_manager_detail_page.dart';
import '../pages/pms_manager_approval_detail.dart';
import '../pages/pms_tabbar.dart';
import '../pages/profile_page.dart';
import '../pages/ptp_ptw_route_page/plantrip_product_route_approval.dart';
import '../pages/ptp_ptw_route_page/plantrip_waybill_route_approval.dart';
import '../pages/ptp_ptw_route_page/ptp_route_approval_tabar.dart';
import '../pages/ptp_ptw_route_page/ptw_route_approval_tabar.dart';
import '../pages/ptp_route_replacement_approval/ptp_route_approval_replace_tabar.dart';
import '../pages/ptp_route_replacement_approval/ptp_route_approval_replacement_detail.dart';
import '../pages/ptp_route_replacement_approval/ptw_route_approval_replace_tabar.dart';
import '../pages/ptp_route_replacement_approval/ptw_route_approval_replacement_detail.dart';
import '../pages/purchase_order_detail.dart';
import '../pages/purchase_order_list.dart';
import '../pages/reminder_approve_tabbar.dart';
import '../pages/reminders_details.dart';
import '../pages/reminders_list.dart';
import '../pages/request_list.dart';
import '../pages/resignation_approval_tabar.dart';
import '../pages/reward_approve_tabbar.dart';
import '../pages/reward_details_page.dart';
import '../pages/reward_page.dart';
import '../pages/route_approval_tabbar.dart';
import '../pages/setting_page.dart';
import '../pages/splash_page.dart';
import '../pages/suspension_approval_tabbar.dart';
import '../pages/travel_approval_tabbar.dart';
import '../pages/travel_details.dart';
import '../pages/travel_expense_page/travel_expense_approval_tabar.dart';
import '../pages/travel_expense_page/travel_expense_detail.dart';
import '../pages/travel_list.dart';
import '../pages/travel_request.dart';
import '../pages/travel_request_update.dart';
import '../pages/trip_expense_approval_tabar.dart';
import '../pages/tripexpense_approved_details.dart';
import '../pages/warning_approve_tabbar.dart';
import '../pages/warning_details_page.dart';
import '../pages/warning_page.dart';
part './app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.INITIAL, page: () => SplashPage()),
    GetPage(name: Routes.LOGIN, page: () => LoginPage()),
    GetPage(name: Routes.FORGET_PASSWORD, page: () => ForgetPasswordPage()),
    GetPage(
        name: Routes.BOTTOM_NAVIGATION, page: () => BottomNavigationWidget()),
    GetPage(name: Routes.PROFILE_PAGE, page: () => ProfilePage()),

    GetPage(name: Routes.REQUEST_LIST, page: () => RequestListPage()),
    GetPage(name: Routes.ATTENDANCE, page: () => AttendanceRequest()),
    GetPage(name: Routes.ATTENDANCE_REPORT, page: () => AttendanceReport()),
    GetPage(name: Routes.APPROVAL, page: () => ApprovalPage()),
    GetPage(
        name: Routes.ANNOUNCEMENTS_DETAILS, page: () => AnnouncementsDetails()),
    GetPage(
        name: Routes.REMINDERS_DETAILS, page: () => RemindersDetails()),
    GetPage(
        name: Routes.APPROVAL_ANNOUNCEMENTS_DETAILS,
        page: () => AnnouncementApprovalDetails()),
    GetPage(
        name: Routes.NOTIFICATION_DETAILS, page: () => NotificationDetails()),
    GetPage(name: Routes.LEAVE_TRIP_REPORT, page: () => LeaveTripReport()),
    GetPage(name: Routes.EMPLOYEE_CHANGE, page: () => EmployeeChangeList()),
    GetPage(name: Routes.LEAVE_TRIP_TAB_BAR, page: () => LeaveTripTabBar()),
    GetPage(name: Routes.ORGANIZATION_CHART, page: () => OrganizationChart()),
    GetPage(name: Routes.PMS_PAGE, page: () => PmsTabBar()),
    GetPage(name: Routes.PAY_SLIP_PAGE, page: () => PayslipListPage()),
    GetPage(name: Routes.PAY_SLIP_DETAIL_PAGE, page: () => PaySlipPage()),
    GetPage(name: Routes.LOAN_PAGE, page: () => LoanListPage()),
    GetPage(name: Routes.INSURANCE, page: () => InsurancePage()),
    GetPage(name: Routes.CREATE_INSURANCE, page: () => CreateInsurancePage()),
    GetPage(name: Routes.CLAIM_INSURANCE, page: () => ClaimInsurancePage()),
    GetPage(
        name: Routes.OVER_TIME_LIST_PAGE,
        page: () => OverTimeListTabBar(),
        binding: OverTimeTabbarBinding()),
    GetPage(name: Routes.OVER_TIME_PAGE, page: () => OverTimePage()),
    GetPage(
        name: Routes.CREATE_EMPLOYEE_CHANGE,
        page: () => EmployeeChangeCreateForm()),
    GetPage(
        name: Routes.OVER_TIME_RESPONSE_DETAILS_PAGE,
        page: () => OvertimeResponseDetails()),
    GetPage(name: Routes.EXPENSE_REPORT, page: () => ExpenseReportTabBar()),
    GetPage(name: Routes.CREATE_EXPENSE, page: () => ExpenseTabBar()),
    GetPage(name: Routes.FLEET_LIST_PAGE, page: () => FleetListPage()),
    GetPage(name: Routes.FLEET_PAGE, page: () => FleetPage()),
    GetPage(name: Routes.CREATE_PLAN_TRIP, page: () => CreatePlanTrip()),
    GetPage(name: Routes.APPROVAL, page: () => ApprovalPage()),
    GetPage(name: Routes.REWARD_PAGE, page: () => RewardPage()),
    GetPage(
        name: Routes.REWARD_APPROVE_TAB_PAGE,
        page: () => RewardApproveTabbar()),
    GetPage(
        name: Routes.REMINDER_APPROVE_TAB_PAGE,
        page: () => ReminderApproveTabbar()),

    GetPage(name: Routes.WARNING_PAGE, page: () => WarningPage()),
    GetPage(
        name: Routes.WARNING_APPROVE_TAB_PAGE,
        page: () => WarningApprovalTabBar()),
    GetPage(
        name: Routes.BUSINESS_TRAVEL_CREATE,
        page: () => BusinessTravelCreate()),
    GetPage(name: Routes.CHANGE_PASSWORD, page: () => ChangePasswordPage()),
    GetPage(name: Routes.EXPENSE_PAGE, page: () => CreateRequestPage()),
    GetPage(name: Routes.APPROVAL_REQUEST, page: () => ApprovalDetails()),
    GetPage(name: Routes.ANNOUNCEMENTS_LIST, page: () => AnnouncementsList()),
    GetPage(name: Routes.REMINDERS_LIST, page: () => RemindersList()),
    GetPage(
        name: Routes.NOTIFICATION_LIST, page: () => NotificationMessageList()),
    GetPage(name: Routes.LEAVE_REQUEST, page: () => LeaveTripRequest()),
    GetPage(name: Routes.TRAVEL_REQUEST, page: () => TravelRequest()),
    // GetPage(name: Routes.PMS_PAGE, page: () => PmsPage()),
    GetPage(name: Routes.PMS_DETAILS_PAGE, page: () => PmsDetails()),
    GetPage(
        name: Routes.PMS_Manager_DETAILS_PAGE,
        page: () => PmsManagerApprovalDetails()),
    GetPage(
        name: Routes.PMS_Manager_DONE_DETAILS_PAGE,
        page: () => PmsDoneDetails()),
    GetPage(name: Routes.OUT_OF_POCKET_PAGE, page: () => OutOfPocketCreate()),
    GetPage(name: Routes.APPROVAL_LIST, page: () => LeaveApprovalTabBar()),
    GetPage(name: Routes.REWARD_DETAILS_PAGE, page: () => RewardsDetailsPage()),
    GetPage(
        name: Routes.WARNING_DETAILS_PAGE, page: () => WarningDetailsPage()),
    GetPage(name: Routes.TRAVEL_REQUEST_LIST, page: () => TravelListPage()),
    GetPage(
      name: Routes.TRAVEL_DETAILS,
      page: () => TravelDetails(),
    ),
    GetPage(name: Routes.LEAVE_DETAILS, page: () => LeaveDetails()),
    GetPage(
        name: Routes.LEAVE_REQUEST_UPDATE,
        page: () => LeaveRequestUpdate(),
        binding: LeaveRequestUpdateBinding()),
    GetPage(
        name: Routes.TRAVEL_REQUEST_UPDATE,
        page: () => TravelRequestUpdate(),
        binding: TravelRequestUpdateBinding()),
    GetPage(name: Routes.LANGUAGE_PAGE, page: () => LanguagePage()),
    GetPage(name: Routes.OVERTIME_DETAILS, page: () => OvertimeDetails()),
    GetPage(name: Routes.OVERTIME_DECLINE, page: () => OverTimeDeclinePage()),
    GetPage(name: Routes.LOAN_DETAILS, page: () => LoanDetailsPage()),
    GetPage(name: Routes.EMPLOYEE_BENEFIT_DETAILS, page: () => EmployeeBenefitDetailsPage()),
    GetPage(name: Routes.HOME_PAGE, page: () => HomePage()),
    GetPage(name: Routes.HR_PAGE, page: () => HRPage()),
    GetPage(name: Routes.ADMIN_PAGE, page: () => AdminPage()),
    GetPage(name: Routes.MESSAGE_PAGE, page: () => ChatPage()),
    GetPage(name: Routes.MORE_PAGE, page: () => SettingPage()),
    GetPage(name: Routes.MAINTENANCE_REQUEST, page: () => MaintenanceRequest()),
    GetPage(name: Routes.MAINTENANCE_LIST, page: () => MaintenanceTabBar()),
    GetPage(name: Routes.CREATE_DAY_TRIP, page: () => CreateDayTrip()),
    GetPage(name: Routes.DOCUMENTS, page: () => Documentation()),
    GetPage(name: Routes.CALENDAR, page: () => CalendarPage()),
    GetPage(name: Routes.DETAILS_LIST, page: () => DetailsList()),
    GetPage(
        name: Routes.APPROVAL_ATTENDANCE_LIST,
        page: () => ApprovalAttendanceList()),
    GetPage(name: Routes.DOCUMENT_LIST, page: () => DocumentList()),
    GetPage(
        name: Routes.APPROVAL_ATTENDANCE_DETAILS,
        page: () => ApprovalAttendanceDetails()),
    GetPage(
        name: Routes.APPROVAL_TRAVEL_LIST, page: () => TravelApprovalTabBar()),
    GetPage(
        name: Routes.APPROVED_TRAVEL_LIST, page: () => ApprovedTravelList()),
    GetPage(
        name: Routes.APPROVAL_TRAVEL_DETAILS,
        page: () => ApprovalTravelDetails()),
    GetPage(
        name: Routes.APPROVED_TRAVEL_DETAILS,
        page: () => ApprovedTravelDetails()),
    GetPage(
        name: Routes.EMPLOYEE_DOCEMENT_PAGE,
        page: () => EmployeeDocumentList()),
    GetPage(
        name: Routes.EMPLOYEE_DOCEMENT_DETAILS_PAGE,
        page: () => EmployeeDocumentDetails()),

    GetPage(
        name: Routes.APPROVAL_ROUTE_LIST, page: () => RouteApprovalTabBar()),

    GetPage(name: Routes.APPROVAL_LOAN_LIST, page: () => LoanApprovalTabBar()),
    GetPage(
        name: Routes.APPROVAL_LOAN_DETAILS, page: () => ApprovalLoanDetails()),
    GetPage(
        name: Routes.APPROVED_LOAN_DETAILS, page: () => ApprovedLoanDetails()),
    GetPage(
        name: Routes.APPROVAL_RESIGNATION_LIST,
        page: () => ResignationApprovalTabBar()),
    GetPage(
        name: Routes.APPROVAL_RESIGNATION_DETAILS,
        page: () => ApprovalResignationDetails()),
    GetPage(
        name: Routes.APPROVED_RESIGNATION_DETAILS,
        page: () => ApprovedResignationDetails()),
    GetPage(
        name: Routes.APPROVAL_EMPLOYEE_CHANGES_LIST,
        page: () => EmployeeChangeApprovalTabBar()),
    GetPage(
        name: Routes.FIRST_APPROVAL_EMPLOYEE_CHANGES_DETAILS,
        page: () => FirstApprovalEmployeeChangeDetails()),
    GetPage(
        name: Routes.APPROVAL_EMPLOYEE_CHANGES_DETAILS,
        page: () => ApprovalEmployeeChangeDetails()),
    GetPage(
        name: Routes.APPROVED_EMPLOYEE_CHANGES_DETAILS,
        page: () => ApprovedEmployeeChangeDetails()),
    GetPage(
        name: Routes.EMPLOYEE_CHANGES_DETAILS,
        page: () => EmployeeChangeDetails()),
    GetPage(
        name: Routes.APPROVAL_ROUTE_DETAILS,
        page: () => ApprovalRouteDetails()),
    GetPage(
        name: Routes.APPROVED_ROUTE_DETAILS,
        page: () => ApprovedRouteDetails()),
    GetPage(
        name: Routes.APPROVAL_OVERTIME_LIST,
        page: () => OvertimeApprovalList()),
    GetPage(
        name: Routes.APPROVAL_OVERTIME_DETAILS,
        page: () => OvertimeApprovalDetail()),
    GetPage(
        name: Routes.ATTENDANCE_APPROVAL_LIST,
        page: () => AttendanceApprovalList()),
    GetPage(
        name: Routes.APPROVED_LEAVE_DETAIL, page: () => ApprovedLeaveDetails()),
    GetPage(
        name: Routes.OUT_OF_POCKET_DETAILS, page: () => OutOfPocketDetails()),
    GetPage(
        name: Routes.OUT_OF_POCKET_UPDATE,
        page: () => OutOfPocketUpdate(),
        binding: OutOfPocketUpdateBinding()),
    GetPage(
        name: Routes.EXPENSE_TRAVEL_DETAILS,
        page: () => ExpenseTravelDetails()),
    GetPage(
        name: Routes.EXPENSE_TRAVEL_UPDATE,
        page: () => BusinessTravelUpdate(),
        binding: BusinessTravelUpdateBinding()),
    GetPage(
        name: Routes.OUT_OF_POCKET_APPROVAL, page: () => OutOfPocketApproval()),
    GetPage(
        name: Routes.TRAVEL_EXPENSE_APPROVAL,
        page: () => TravelExpenseApproval()),
    GetPage(
        name: Routes.INSURANCE_APPROVAL,
        page: () => InsuranceApproval()),
     GetPage(
        name: Routes.PlanTrip_PRODUCT_ROUTE_APPROVAL,
        page: () => PlanTripProductRouteApproval()),
    GetPage(
        name: Routes.PlanTrip_WAYBILL_ROUTE_APPROVAL,
        page: () => PlanTripWaybillRouteApproval()),
    GetPage(
        name: Routes.TRIP_EXPENSE_APPROVAL, page: () => TripExpenseApproval()),
    GetPage(
        name: Routes.APPROVAL_OUTOFPOCKET_LIST,
        page: () => OutOfPocketApprovalTabar()),
    GetPage(
        name: Routes.APPROVAL_TRIPEXPENSE_LIST,
        page: () => TripExpenseApprovalTabar()),
    GetPage(
        name: Routes.APPROVAL_TRAVEL_EXPENSE_LIST,
        page: () => TravelExpenseApprovalTabar()),
    GetPage(
      name: Routes.APPROVAL_INSURANCE_LIST,
      page: () => InsuranceApprovalTabar()
    ),
    GetPage(
      name: Routes.APPROVAL_PTP_ROUTE_LIST,
      page: () => PTPRouteApprovalTabar()
    ),
    GetPage(
      name: Routes.APPROVAL_PTW_ROUTE_LIST,
      page: () => PTWRouteApprovalTabar()
    ),
    GetPage(
      name: Routes.PTP_ROUTE_APPROVAL_REPLACE_TABAR,
      page: () => PTPRouteApprovalReplaceTabar()
    ),
    GetPage(
      name: Routes.PTP_ROUTE_REPLACEMENT_DETAIL,
      page: () => PTPRouteReplacementDetail()
    ),
    GetPage(
      name: Routes.PTW_ROUTE_REPLACEMENT_DETAIL,
      page: () => PTWRouteApprovalReplacementDetail()
    ),
    GetPage(
      name: Routes.PTW_ROUTE_APPROVAL_REPLACE_TABAR,
      page: () => PTWRouteApprovalReplaceTabar()
    ),
    GetPage(
        name: Routes.APPROVED_OUTOFPOCKET_APPROVED_DETAILS,
        page: () => OutOfPocketApprovedDetails()),
    GetPage(
        name: Routes.APPROVED_TRIPEXXPENSE_APPROVED_DETAILS,
        page: () => TripExpenseApprovedDetails()),
    GetPage(
        name: Routes.APPROVED_TRAVEL_EXPENSE_DETAILS,
        page: () => TravelExpenseApprovedDetails()),
    GetPage(name: Routes.CONFIGURATION_PAGE, page: () => ConfigurationPage()),
    GetPage(name: Routes.PLAN_TRIP_PAGE, page: () => PlanTripTabBar()),
    GetPage(
        name: Routes.PLAN_TRIP_WAYBILL_PAGE,
        page: () => PlanTripWayBillTabBar()),
    GetPage(name: Routes.DAY_TRIP_PAGE, page: () => DayTripListPage('open')),

    GetPage(
        name: Routes.ANNOUNCEMENTS_APPROVAL_TAB_PAGE,
        page: () => AnnouncementApprovalTabBar()),
    GetPage(
        name: Routes.FLEET_INSURANCE_DETAIL,
        page: () => FleetInsuranceDetail()),
    GetPage(name: Routes.PLANTRIP_DETAILS, page: () => PlanTripDetails()),
    GetPage(
        name: Routes.PLANTRIP_WAYBILL_DETAILS,
        page: () => PlanTripWayBillDetails()),

    GetPage(
        name: Routes.INSURANCEDETAIL,
        page: () => EmployeeInsuranceDetailPage()),
    GetPage(
        name: Routes.CLAIMINSURANCEDETAIL,
        page: () => ClaimInsuranceDetailPage()),
    GetPage(
        name: Routes.MAINTENANCEDETAILPAGE,
        page: () => MaintenanceDetailPage()),
    GetPage(name: Routes.DAY_TRIP_TABAR, page: () => DayTripTabBar()),
    GetPage(
        name: Routes.CREATEROUTEDATEWAYBILL,
        page: () => CreateRouteDatePlanTripWaybill()),
    GetPage(name: Routes.OTPCONFIRM, page: () => OtpConfirmPage()),
      GetPage(name: Routes.PURCHASE_ORDER_LIST,
    binding: PurchaseOrderBinding(), page: () => PurchaseOrderListPage()),
    GetPage(
        name: Routes.PURCHASE_ORDER_DETAIL, page: () => PurchaseOrderDetails()),
    GetPage(
        name: Routes.EMPLOYEE_BENEFIT_LIST, page: () => EmployeeBenefitListPage()),
    GetPage(
        name: Routes.APPROVAL_SUSPENSION_LIST,
        page: () => SuspensionApprovalTabBar()),
    GetPage(
        name: Routes.APPROVAL_SUSPENSION_DETAILS,
        page: () => ApprovalSuspensionDetails()),
    GetPage(
        name: Routes.APPROVED_SUSPENSION_DETAILS,
        page: () => ApprovedSuspensionDetails()),
    GetPage(
        name: Routes.APPROVEDMAINTENANCEDETAILPAGE,
        page: () => ApprovedMaintenanceDetailPage()),
    GetPage(
      name: Routes.APPROVED_INSURANCE_DETAILS,
      page: () => ApprovedInsuranceDetailsPage()
    ),
    GetPage(
        name: Routes.PMS_Force_Manager_Detail_Page,
        page: () => PMSForceManagerDetailPage()),
    GetPage(
        name: Routes.PMS_HOD_Force_Manager_Detail_Page,
        page: () => PMSHODForceManagerDetailPage()),


  ];
}
