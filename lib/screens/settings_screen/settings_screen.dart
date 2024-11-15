import 'package:flutter/material.dart';
import 'package:wirdul_latif/utils/constants.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings'),),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text('Dark Mode'),
            trailing: Switch(
              value: Settings.isDarkMode,
              onChanged: (value) {
                // Settings.isDarkMode = value;
              },
            ),
          )
        ],
      ),
    );
  }
}