import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streak_calendar/streak_calendar.dart';
import 'package:wirdul_latif/screens/calender_screen.dart/calender_screen_model.dart';
import 'package:wirdul_latif/utils/colors.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CalenderScreenModel()),
      ],
      child: Consumer<CalenderScreenModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              title: const Text("Streak Calendar"),
              
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cleanCalender(
                          model.morningDatesForStreaks, context, "Morning"),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  cleanCalender(
                      model.eveningDatesForStreaks, context, "Evening"),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Padding cleanCalender(
      List<DateTime> datesForStreaks, BuildContext context, String typeName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Text(
                    typeName,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: WirdColors.primaryDaycolor),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.local_fire_department,
                        color: Colors.orange,
                      )
                    ],
                  ),
                  Text(
                    datesForStreaks.length.toString(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: WirdColors.primaryDaycolor),
                  ),
                ],
              ),
            ),
            CleanCalendar(
              datesForStreaks: datesForStreaks,
              currentDateProperties: DatesProperties(
                datesDecoration: DatesDecoration(
                  datesBorderRadius: 1000,
                  datesBackgroundColor: Colors.lightGreen.shade100,
                  datesBorderColor: Colors.black,
                  datesTextColor: Colors.black,
                ),
              ),
              streakDatesProperties: DatesProperties(
                datesDecoration: DatesDecoration(
                  // datesBorderRadius: 1000,
                  datesBackgroundColor: Colors.green,
                  datesBorderColor: Colors.green,
                  datesTextColor: Colors.white,
                ),
              ),
              generalDatesProperties: DatesProperties(
                datesDecoration: DatesDecoration(
                    datesBorderRadius: 0, datesBorderColor: Colors.transparent),
              ),
              leadingTrailingDatesProperties: DatesProperties(
                datesDecoration: DatesDecoration(
                    datesBorderRadius: 1000,
                    datesBorderColor: Colors.transparent,
                    datesTextColor: Colors.transparent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
