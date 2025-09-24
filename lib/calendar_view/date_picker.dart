import 'package:flutter/material.dart';
import 'package:timeline_chart/calendar_view/utils.dart';

class DatePicker extends StatefulWidget {

  final DateTime? selectedTime;
  final Function(DateTime) onSelected;

  const DatePicker({
    super.key,
    this.selectedTime,
    required this.onSelected
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

  DateTime selectedTime = DateTime.now();
  final _scrollController = ScrollController();

  @override
  void initState() {
    if(widget.selectedTime != null) selectedTime = widget.selectedTime!;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToItem();
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    if(widget.selectedTime != null) selectedTime = widget.selectedTime!;
    final dates = getListDates();
    return Container(
      //margin: EdgeInsets.only(bottom: 6),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 12),
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios, size: 18, color: Colors.grey,),
                Expanded(
                  child: Center(
                    child: Text(
                      "September 2025",
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey,)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 6, bottom: 8),
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...dates.map((item) {
                    final isActive = isSameDate(item, selectedTime);
                    return InkWell(
                      onTap: () {
                        widget.onSelected(item);
                      },
                      child: SizedBox(
                        width: 60,
                        child: Column(
                          spacing: 6,
                          children: [
                            Text(
                              dayFormat.format(item),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isActive ? Colors.blue : Colors.white
                              ),
                              child: Center(
                                child: Text(
                                  dayDateFormat.format(item),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: isActive ? Colors.white : Colors.black
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[200],
          ),
        ],
      ),
    );
  }

  List<DateTime> getListDates() {
    final date = DateTime.now();
    final firstDay = DateTime(date.year, date.month, 1);
    final lastDay = DateTime(date.year, date.month + 1, 0);
    return List.generate(
      lastDay.day,
          (index) => DateTime(date.year, date.month, index + 1),
    );
  }

  void scrollToItem() {
    final index = getListDates().indexWhere((d) =>
    d.year == selectedTime.year &&
        d.month == selectedTime.month &&
        d.day == selectedTime.day);

    if (index != -1) {
      // Item width (card width + margin)
      const double itemWidth = 60.0;

      // Screen width
      final screenWidth = MediaQuery.of(context).size.width;

      // Calculate target offset so the item is centered
      double targetOffset = index * itemWidth - (screenWidth / 2) + (itemWidth / 2);

      // Prevent going out of bounds
      if (targetOffset < 0) targetOffset = 0;
      final maxScroll = _scrollController.position.maxScrollExtent;
      if (targetOffset > maxScroll) targetOffset = maxScroll;

      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

}
