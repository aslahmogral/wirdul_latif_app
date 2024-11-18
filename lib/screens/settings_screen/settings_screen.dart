import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'package:wirdul_latif/screens/settings_screen/setting_screen_model.dart';
import 'package:wirdul_latif/utils/constants.dart';
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
                        value: themeProvider.isDarkMode,
                        onChanged: (value) {
                          themeProvider.toggleTheme();
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
                      leading: Icon(Icons.rate_review),
                      title: Text('Rate this App'),
                      onTap: () {
                        // Replace with your app's link
                        // launchUrl(
                        //   Uri.parse(
                        //   Constants.appLink,
                        //   ),
                        // );
                      },
                    )
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
