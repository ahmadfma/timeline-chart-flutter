import 'package:calendar_day_view/calendar_day_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:timeline_chart/calendar_view/utils.dart';

class CategoryOverflowDayViewTab extends HookWidget {
  const CategoryOverflowDayViewTab({
    super.key,
    required this.categories,
    required this.events,
    this.addEventOnClick,
  });
  final List<EventCategory> categories;
  final List<CategorizedDayEvent<String>> events;

  final Function(EventCategory, DateTime)? addEventOnClick;
  @override
  Widget build(BuildContext context) {
    return CalendarDayView.categoryOverflow(
      config: CategoryDavViewConfig(
        columnsPerPage: 2,
        startOfDay: const TimeOfDay(hour: 6, minute: 00),
        endOfDay: const TimeOfDay(hour: 20, minute: 00),
        time12: false,
        allowHorizontalScroll: true,
        currentDate: DateTime.now(),
        timeGap: 60,
        heightPerMin: 0.9,
        evenRowColor: Colors.white,
        oddRowColor: Colors.white,
        headerDecoration: BoxDecoration(
          color: Colors.grey[200]!,
        ),
        logo: Container(
          color: Colors.white,
        ),
        timeColumnWidth: 56,
        timeTextStyle: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 10,
        ),
        timeLabelBuilder: (context, time) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                timeFormat2.format(time),
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          );
        },
      ),
      categories: categories,
      events: events,
      onTileTap: (category, time) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text("This slot is available $time -- $category"),
          ),
        );
      },
      backgroundTimeTileBuilder: (context, constraints, rowTime, category, isOddRow) {
        return Container(
            constraints: constraints,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!, width: 0.5)
            ),
        );
      },
      controlBarBuilder: (goToPreviousTab, goToNextTab) => Container(),
      eventBuilder: (constraints, category, _, event) => GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.teal,
            content: Text(event.toString()),
          ));
        },
        child: IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.all(4),
            constraints: constraints,
            height: double.infinity,
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              color: Color(0xFFF4FCF8),
              border: Border.all(color: Colors.green, width: 1.5),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.value,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                  Text("${timeFormat2.format(event.start)} - ${timeFormat2.format(event.end!)}", maxLines: 2, overflow: TextOverflow.ellipsis,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}