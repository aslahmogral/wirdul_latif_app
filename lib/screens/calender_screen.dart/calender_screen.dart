import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:streak_calendar/streak_calendar.dart';
import 'package:wirdul_latif/screens/calender_screen.dart/calender_screen_model.dart';
import 'package:wirdul_latif/utils/colors.dart';

class CalenderScreen extends StatelessWidget {
  final currentStreak;
  const CalenderScreen({super.key, this.currentStreak});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => CalenderScreenModel(currentStreak)),
      ],
      child: Consumer<CalenderScreenModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Streak Calendar"),
              actions: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                size: 50,
                                Icons.local_fire_department,
                                color: Colors.orange[700],
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                model.currentStreak.toString(),
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          content: Text(
                              '“To maintain your streak, make sure to read at least 10 wirds of Morning or Evening every day.\n\nKeep it simple, stay consistent, and keep your streak alive!”.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                'OK',
                                style: TextStyle(color: Colors.teal),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Stack(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 50,
                            // color: Colors.yellow,
                            child: Lottie.asset('asset/onboarding/streak.json',
                                height: 40.0),
                          ),
                          Positioned(
                            right: 0,
                            bottom: -8,
                            child: Container(
                              height: 50,
                              // color: Colors.green,
                              child: Center(
                                child: Text(
                                  model.currentStreak.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 16,
                      )
                    ],
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     cleanCalender(
                  //         model.morningDatesForStreaks, context, "Morning"),
                  //   ],
                  // ),
                  heatMapCalender(model.morningDatesForStreaks, context,
                      'Morning', model.showMoreMorningDatesForStreaks),
                  SizedBox(
                    height: 16,
                  ),
                  heatMapCalender(model.eveningDatesForStreaks, context,
                      'Evening', model.showMoreEveningDatesForStreaks),
                  SizedBox(
                    height: 16,
                  ),
                  // cleanCalender(
                  //     model.eveningDatesForStreaks, context, "Evening"),
                  // SizedBox(
                  //   height: 16,
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Padding heatMapCalender(Map<DateTime, int> datesForStreaks,
      BuildContext context, String typeName, List<DateTime> showMoreList) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        // width: MediaQuery.of(context).size.width / 1.2,
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
                  Text('Total : '),
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
            SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.teal, width: 2), // Added border color
                borderRadius: BorderRadius.circular(15),
                //  color: Colors.grey[200],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    HeatMap(
                      // textColor: Colors.teal,
                      datasets: datesForStreaks,
                      defaultColor: Colors.grey.withOpacity(0.5),
                      startDate: DateTime.now().subtract(Duration(days: 60)),
                      endDate: DateTime.now(),
                      colorMode: ColorMode.opacity,
                      showColorTip: false,
                      showText: true,
                      scrollable: true, fontSize: 12,
                      colorsets: {
                        11: const Color.fromARGB(255, 88, 176, 91),
                      },
                      onClick: (value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                '${DateFormat('MMMM d yyyy').format(value)}')));
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Calender'),
                                content: cleanCalender(
                                    showMoreList, context, typeName),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      'OK',
                                      style: TextStyle(color: Colors.teal),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: Text('show more...',
                          style: TextStyle(color: Colors.teal)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
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
                  Text('Total : '),
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
                    // Theme.of(context).scaffoldBackgroundColor)
                    datesBackgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                    datesBorderColor: Theme.of(context).scaffoldBackgroundColor,
                    datesTextColor: Theme.of(context).scaffoldBackgroundColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
