import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/screens/settings_screen/setting_screen_model.dart';
import 'package:wirdul_latif/utils/theme_provider_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SettingsScreenModel(),
        ),

      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Settings'),
            ),
            body: Consumer<SettingsScreenModel>(
              builder: (context, model, child) {
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.dark_mode),
                      title: Text('Dark Mode'),
                      trailing: Switch(
                        activeColor: Colors.teal,
                        value: themeProvider.isDarkMode,
                        onChanged: (value) {
                          themeProvider.toggleDarkMode();
                        },
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.share),
                      title: Text('Share this App'),
                      onTap: () {
                        model.shareApp();
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.sync),
                      title: Text('check for correction updates'),
                      onTap: () {
                        model.checkForUpdates(context);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.rate_review),
                      title: Text('Rate this App'),
                      onTap: () {
                        model.rateApp();
                      },
                    ),
                    // ListTile(
                    //   leading: Icon(Icons.apps),
                    //   title: Text('For More App'),
                    //   onTap: () {
                    //     model.moreApps();
                    //   },
                    // ),
                    ListTile(
                      leading: Icon(Icons.delete_forever),
                      title: Text('Reset Stats'),
                      onTap: () {
                        // model.clearStats(context);
                      },
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
