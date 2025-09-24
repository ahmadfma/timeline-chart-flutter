import 'package:calendar_day_view/calendar_day_view.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:timeline_chart/calendar_view/date_picker.dart';
import 'package:timeline_chart/calendar_view/tabs/category_overflow_day_view_tab.dart';

class CalendarDayPage extends StatefulWidget {
  const CalendarDayPage({super.key});

  @override
  State<CalendarDayPage> createState() => _CalendarDayPageState();
}

class _CalendarDayPageState extends State<CalendarDayPage> {

  final _selectedDateNotifier = ValueNotifier<DateTime>(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final categories = [
      EventCategory(id: "1", name: "R.Banda Neira"),
      EventCategory(id: "2", name: "R.Raja Ampat Kiri"),
      EventCategory(id: "3", name: "R.Papuma"),
      EventCategory(id: "4", name: "R.Raja Ampat Kanan"),
      EventCategory(id: "5", name: "R.Meeting Counceling"),
      EventCategory(id: "6", name: "R.Bunaken"),
    ];
    final categoryEvents = getEvents();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          title: Text(
            "Booking Ruang",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
        ),
        body: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: _selectedDateNotifier,
              builder: (context, value, child) {
                return DatePicker(
                  selectedTime: value,
                  onSelected: (date) {
                    _selectedDateNotifier.value = date;
                  },
                );
              },
            ),
            Expanded(
              child: CategoryOverflowDayViewTab(
                events: categoryEvents,
                categories: categories,
                addEventOnClick: (cate, time) {},
              ),
            ),
          ],
        ),
      ),
    );
  }

}


List<CategorizedDayEvent<String>> getEvents() {
  return [
    CategorizedDayEvent(
      categoryId: "1",
      start: DateTime.now().copyWith(hour: 7, minute: 00),
      end: DateTime.now().copyWith(hour: 8, minute: 0),
      value: "Monthly Meeting"
    ),
    CategorizedDayEvent(
        categoryId: "1",
        start: DateTime.now().copyWith(hour: 9, minute: 0),
        end: DateTime.now().copyWith(hour: 12, minute: 0),
        value: "Monthly Meeting",
      name: "1231"
    ),
    CategorizedDayEvent(
        categoryId: "1",
        start: DateTime.now().copyWith(hour: 12, minute: 0),
        end: DateTime.now().copyWith(hour: 14, minute: 0),
        value: "Monthly Meeting",
        name: "1231"
    ),
    CategorizedDayEvent(
        categoryId: "2",
        start: DateTime.now().copyWith(hour: 9, minute: 0),
        end: DateTime.now().copyWith(hour: 11, minute: 0),
        value: "Monthly Meeting",
        name: "1231"
    ),
    CategorizedDayEvent(
        categoryId: "3",
        start: DateTime.now().copyWith(hour: 7, minute: 0),
        end: DateTime.now().copyWith(hour: 8, minute: 0),
        value: "Monthly Meeting"
    ),
    CategorizedDayEvent(
        categoryId: "3",
        start: DateTime.now().copyWith(hour: 9, minute: 0),
        end: DateTime.now().copyWith(hour: 12, minute: 0),
        value: "Monthly Meeting",
        name: "1231"
    ),
  ];
}

List<CategorizedDayEvent<String>> genEvents(int categoryLength) =>
    faker.randomGenerator.amount(
          (i) {
        final hour = faker.randomGenerator.integer(17, min: 7);
        final start = DateTime.now().copyWith(
          hour: hour,
          minute: faker.randomGenerator.element([0, 15, 20]),
          second: 0,
        );
        return CategorizedDayEvent(
            categoryId: faker.randomGenerator
                .integer(categoryLength + 1, min: 1)
                .toString(),
            value: faker.conference.name(),
            start: start,
            end: start.add(
              Duration(minutes: faker.randomGenerator.element([90, 60])),
            )
        );
      },
      categoryLength * 5,
      min: 10,
    );