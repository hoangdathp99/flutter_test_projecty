// ignore: file_names
import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  String chosenDate =
      '${DateTime.now().day > 10 ? '' : 0}${DateTime.now().day}-${DateTime.now().month > 10 ? '' : 0}${DateTime.now().month}-${DateTime.now().year}';
  String chosenTime = '';
  List<String> unavailableDates = ["25-02", "26-02", "27-02", "04-03", "01-03"];
  int leadTime = 5;
  String startTime = "8:00";
  String endTime = "20:00";
  List<String> disabledDatesFormatted() {
    return unavailableDates
        .map((date) => '$date-${DateTime.now().year}')
        .toList();
  }

  List<int> weekdays = [];
  List<String> availableHour = [];
  bool includeDate(DateTime dateTime) {
    return dateTime.weekday != 7 &&
        dateTime.weekday != 6 &&
        !disabledDatesFormatted().contains(
            '${dateTime.day > 10 ? '' : 0}${dateTime.day}-${dateTime.month > 10 ? '' : 0}${dateTime.month}-${dateTime.year}');
  }

  DateTime getTomorrow(DateTime date) {
    return date.add(const Duration(days: 1));
  }

  int addAvailableDay(max) {
    DateTime nextAvailable = DateTime.now();
    int count = 0;
    int extra = 0;
    while (count < max) {
      nextAvailable = getTomorrow(nextAvailable);
      if (includeDate(nextAvailable) == false) {
        extra++;
      } else {
        count++;
      }
    }
    return max + extra;
  }

  List<String> renderHour() {
    List<String> arr = [];
    int startHour = int.parse(startTime.split(":")[0]);
    int startMinute = int.parse(startTime.split(":")[1]);
    int endHour = int.parse(endTime.split(":")[0]);
    int endMinute = int.parse(endTime.split(":")[1]);
    for (int i = startHour; i <= endHour; i++) {
      if ((i == startHour && startMinute > 0 && startMinute <= 30) ||
          (i == endHour && endMinute <= 30)) {
        arr.add("$i:30");
      } else if (i == startHour && startMinute > 30 && startMinute < 59) {
      } else if (i == endHour && endMinute < 30) {
        arr.add("$i:00");
      } else {
        arr.add("$i:00");
        arr.add("$i:30");
      }
    }
    return arr;
  }
  List<String> getHourPerDay() {
    var newListHour = renderHour();
    String today =
        '${DateTime.now().day > 10 ? '' : 0}${DateTime.now().day}-${DateTime.now().month > 10 ? '' : 0}${DateTime.now().month}-${DateTime.now().year}';
    int currentHour = DateTime.now().hour;
    int currentMinute = DateTime.now().minute;
    if (today == chosenDate) {
      for (int i = 0; i < newListHour.length; i++) {
        if (int.parse(newListHour[i].split(":")[0]) > currentHour + leadTime ||
            (int.parse(newListHour[i].split(":")[0]) ==
                    currentHour + leadTime &&
                int.parse(newListHour[i].split(":")[1]) > currentMinute)) {
          availableHour.add(newListHour[i]);
        }
      }
      return availableHour;
    } else {
      return newListHour;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
    GestureDetector(
        onTap: () {
          showDatePicker(
              context: context,
              initialDate: includeDate(DateTime.now()) ? DateTime.now() : DateTime.now().add(Duration(days: addAvailableDay(1))),
              firstDate: DateTime.now(),
              lastDate:
                  DateTime.now().add(Duration(days: addAvailableDay(5))),
              selectableDayPredicate: (DateTime dateTime) =>
                  includeDate(dateTime)).then((value) => {
                if (value != null)
                  {
                    setState(() {
                      chosenDate =
                          '${value.day > 10 ? '' : 0}${value.day}-${value.month > 10 ? '' : 0}${value.month}-${value.year}';
                    }),
                  }
              });
        },
        child: Text(chosenDate, style:const TextStyle(fontWeight: FontWeight.w700),)),
    DropdownButton(
          alignment: Alignment.center,
          items: getHourPerDay().map<DropdownMenuItem<String>>((String e) {
            return DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            );
          }).toList(),
          hint: Text(chosenTime != '' ? chosenTime : getHourPerDay()[0], style:const TextStyle(color: Colors.black),),
          borderRadius: BorderRadius.circular(10),
          dropdownColor:const Color(0xfff4f4f4),
          onChanged: (e) {
            setState(() {
              chosenTime = e.toString();
            });
          })
      ],
    );
  }
}
