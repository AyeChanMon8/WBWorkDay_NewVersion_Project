
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:winbrother_hr_app/my_class/my_style.dart';
import '../controllers/calendar_controller.dart';
import '../localization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarControllers controller = Get.put(CalendarControllers());
  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.day,
    CalendarView.week,
    CalendarView.workWeek,
    CalendarView.month,
    CalendarView.schedule
  ];
  List<String> subjectCollection = [];
  List<Color> colorCollection = [];
  List<Appointment> appointments = [];
  DataSource? events;

  @override
  void initState() {
    appointments = <Appointment>[];
    addAppointmentDetails();
    addAppointments();
    events = DataSource(appointments);
    super.initState();
  }
  /// Creates the required appointment details as a list.
  void addAppointmentDetails() {
    subjectCollection = <String>[];
    subjectCollection.add('General Meeting');
    subjectCollection.add('Plan Execution');
    subjectCollection.add('Project Plan');
    subjectCollection.add('Consulting');
    subjectCollection.add('Support');
    subjectCollection.add('Development Meeting');
    subjectCollection.add('Project Completion');
    subjectCollection.add('Release updates');
    subjectCollection.add('Performance Check');

    colorCollection = <Color>[];
    colorCollection.add(const Color(0xFF0F8644));
    colorCollection.add(const Color(0xFF8B1FA9));
    colorCollection.add(const Color(0xFFD20100));
    colorCollection.add(const Color(0xFFFC571D));
    colorCollection.add(const Color(0xFF36B37B));
    colorCollection.add(const Color(0xFF01A1EF));
    colorCollection.add(const Color(0xFF3D4FB5));
    colorCollection.add(const Color(0xFFE47C73));
    colorCollection.add(const Color(0xFF636363));
    colorCollection.add(const Color(0xFF0A8043));
  }

  /// Method that creates the collection the data source for calendar, with
  /// required information.
  void addAppointments() {
    final Random random = Random();
    final DateTime rangeStartDate =
    DateTime.now().add(const Duration(days: -(365 ~/ 2)));
    final DateTime rangeEndDate = DateTime.now().add(const Duration(days: 365));
    /*for (DateTime i = rangeStartDate;
    i.isBefore(rangeEndDate);
    i = i.add(Duration(days: random.nextInt(10)))) {
      final DateTime date = i;
      final int count = 1 + random.nextInt(3);
      for (int j = 0; j < count; j++) {
        final DateTime startDate = DateTime(
            date.year, date.month, date.day, 8 + random.nextInt(8), 0, 0);
        final DateTime endDate = startDate.add(Duration(days: 1));
        appointments.add(Appointment(
          subject: subjectCollection[random.nextInt(7)],
          startTime: startDate,
         // endTime: startDate.add(Duration(hours: random.nextInt(3))),
          endTime: endDate,
          color: colorCollection[random.nextInt(9)],
          isAllDay: false,
        ));
      }
    }*/

    DateTime date = DateTime.now();
    date = DateTime(date.year, date.month, date.day, 11, 0, 0);
    // added recurrence appointment
    appointments.add(Appointment(
      subject: 'Scrum',
      startTime: date,
      endTime: date.add(const Duration(hours: 1)),
      color: colorCollection[random.nextInt(9)],
      isAllDay: false,
    ));
  }

  @override
  Widget build(BuildContext context) {
    var labels = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(labels!.calendar,style: appBarTextStyle(),),
          backgroundColor: backgroundIconColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Obx(
            ()=> SfCalendar(
              showDatePickerButton: true,
              showTodayButton: true,
              allowedViews: _allowedViews,
              dataSource: controller.source.value,
              view: CalendarView.month,
              scheduleViewMonthHeaderBuilder: scheduleViewBuilder,
              initialDisplayDate: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 00, 00, 00),
              // monthViewSettings: MonthViewSettings(
              //     appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              //     appointmentDisplayCount: 4),
              monthViewSettings: MonthViewSettings(showAgenda: true,agendaItemHeight: 90,),
              timeSlotViewSettings: TimeSlotViewSettings(
                  minimumAppointmentDuration: const Duration(minutes: 60))
          ),
        )
    );
  }
  String _getMonthDate(int month) {
    
    if (month == 01) {
      return 'January';
    } else if (month == 02) {
      return 'February';
    } else if (month == 03) {
      return 'March';
    } else if (month == 04) {
      return 'April';
    } else if (month == 05) {
      return 'May';
    } else if (month == 06) {
      return 'June';
    } else if (month == 07) {
      return 'July';
    } else if (month == 08) {
      return 'August';
    } else if (month == 09) {
      return 'September';
    } else if (month == 10) {
      return 'October';
    } else if (month == 11) {
      return 'November';
    } else {
      return 'December';
    }
  }


  Widget scheduleViewBuilder(
      BuildContext buildContext, ScheduleViewMonthHeaderDetails details) {
    final String monthName = _getMonthDate(details.date.month);
    return Stack(
      children: [
        Image(
            image: ExactAssetImage('assets/images/' + monthName + '.png'),
            fit: BoxFit.cover,
            width: details.bounds.width,
            height: details.bounds.height),
        Positioned(
          left: 55,
          right: 0,
          top: 20,
          bottom: 0,
          child: Text(
            monthName + ' ' + details.date.year.toString(),
            style: TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }
}

class DataSource extends CalendarDataSource {
  DataSource(this.source);

  List<Appointment> source;

  @override
  List<dynamic> get appointments => source;
}

