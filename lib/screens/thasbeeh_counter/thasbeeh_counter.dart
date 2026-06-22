import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wirdul_latif/widgets/firebase_analytics.dart';
import 'package:wirdul_latif/utils/responsive.dart';

class TasbeehCounterScreen extends StatefulWidget {
  @override
  _TasbeehCounterScreenState createState() => _TasbeehCounterScreenState();
}

class _TasbeehCounterScreenState extends State<TasbeehCounterScreen> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    WfirebaseAnalytics.screenTracker('Tasbeeh Counter');
    _loadCounter();
  }

  Future<void> _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _count = prefs.getInt('counter') ?? 0;
    });
  }

  Future<void> _updateCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _count);
  }

  void _increment() {
    HapticFeedback.lightImpact();
    setState(() {
      _count++;
    });
    _updateCounter();
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
    _updateCounter();
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = context.isTablet;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 550.0 : double.infinity,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Reset button at the top
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: _reset,
                        style: ElevatedButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Display the count in the middle
                Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      '$_count',
                      style: TextStyle(
                        fontSize: isTablet ? 140 : 100,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[800],
                      ),
                    ),
                  ],
                ),

                // Counter button at the bottom
                Padding(
                  padding: EdgeInsets.only(bottom: isTablet ? 80 : 50),
                  child: ElevatedButton(
                    onPressed: _increment,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: EdgeInsets.all(isTablet ? 110 : 80),
                      elevation: 10,
                    ),
                    child: Icon(Icons.keyboard_arrow_up, size: isTablet ? 70 : 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
