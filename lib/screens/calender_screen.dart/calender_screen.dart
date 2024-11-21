import 'package:flutter/material.dart';
import 'package:streak_calendar/streak_calendar.dart';
import 'package:wirdul_latif/data/wirddata.dart';
import 'package:wirdul_latif/screens/home_screen/home_screen_model.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<DateTime> morningDatesForStreaks = WirdulLatif.progressList
        .where((e) => e.count >= 10 && e.type == WirdType.morning.name)
        .map<DateTime>((e) => e.time as DateTime)
        .toList();

        List<DateTime> eveningDatesForStreaks = WirdulLatif.progressList
        .where((e) => e.count >= 10 && e.type == WirdType.evening.name)
        .map<DateTime>((e) => e.time as DateTime)
        .toList();
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text("Streak Calendar"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            
            SizedBox(height: 16,),
            Text(
              'Morning Wird',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16,),

            CleanCalendar(
              datesForStreaks: [
                ...morningDatesForStreaks,
              ],
              currentDateProperties: DatesProperties(
                datesDecoration: DatesDecoration(
                  datesBorderRadius: 1000,
                  datesBackgroundColor: Colors.lightGreen.shade100,
                  datesBorderColor: Colors.green,
                  datesTextColor: Colors.black,
                ),
              ),
              streakDatesProperties: DatesProperties(
                datesDecoration: DatesDecoration(
                  datesBorderRadius: 1000,
                  datesBackgroundColor: Colors.green,
                  datesBorderColor: Colors.blue,
                  datesTextColor: Colors.white,
                ),
              ),
              leadingTrailingDatesProperties: DatesProperties(
                datesDecoration: DatesDecoration(
                  datesBorderRadius: 1000,
                ),
              ),
            ),

            SizedBox(height: 16,),

            Text(
              'Evening Wird',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                // color: Colors.black,
              ),
            ),
            SizedBox(height: 16,),

            CleanCalendar(
              datesForStreaks: [
                ...eveningDatesForStreaks,
              ],
              currentDateProperties: DatesProperties(
                datesDecoration: DatesDecoration(
                  datesBorderRadius: 1000,
                  datesBackgroundColor: Colors.lightGreen.shade100,
                  datesBorderColor: Colors.green,
                  datesTextColor: Colors.black,
                ),
              ),
              streakDatesProperties: DatesProperties(
                datesDecoration: DatesDecoration(
                  datesBorderRadius: 1000,
                  datesBackgroundColor: Colors.green,
                  datesBorderColor: Colors.blue,
                  datesTextColor: Colors.white,
                ),
              ),
              leadingTrailingDatesProperties: DatesProperties(
                datesDecoration: DatesDecoration(
                  datesBorderRadius: 1000,
                ),
              ),
            ),
            SizedBox(height: 16,),

          ],
        ),
      ),
    );
  }
}
