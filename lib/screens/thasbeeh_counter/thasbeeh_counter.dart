import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wirdul_latif/widgets/firebase_analytics.dart';

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
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                        icon: Icon(Icons.arrow_back)),
                    Spacer(),
                    ElevatedButton(
                      onPressed: _reset,
                      style: ElevatedButton.styleFrom(
                        // primary: Colors.redAccent,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
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
                  SizedBox(height: 10),
                  Text(
                    '$_count',
                    style: TextStyle(
                      fontSize: 100,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[800],
                    ),
                  ),
                ],
              ),

              // Counter button at the bottom
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: ElevatedButton(
                  onPressed: _increment,
                  style: ElevatedButton.styleFrom(
                    // primary: Colors.teal,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(80),
                    elevation: 10,
                  ),
                  child: Icon(Icons.keyboard_arrow_up, size: 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
