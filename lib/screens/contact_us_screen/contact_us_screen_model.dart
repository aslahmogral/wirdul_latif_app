import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wirdul_latif/utils/constants.dart';
import 'package:wirdul_latif/api/firebase_analytics.dart';

class ContactUsScreenModel with ChangeNotifier {
  // static String? encodeQueryParameters(Map<String, String> params) {
  //   return params.entries
  //       .map((MapEntry<String, String> e) =>
  //           '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
  //       .join('&');
  // }
  // final Uri emailLaunchUri = Uri(
  //   scheme: 'mailto',
  //   path: 'aslahmogral.dev@gmail.com',
  //   query: encodeQueryParameters(<String, String>{
  //     'subject': 'Wird al Latif App Feedback',
  //   }),
  // );

  ContactUsScreenModel() {
    FirbaseApi.screenTracker('contact us screen');
  }

  sendMail() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'aslahmogral.dev@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Wird al Latif App Feedback',
      }),
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch';
    }
  }

  contactDeveloper() async {
    final Uri profileUrl = Uri.parse(
      "https://www.instagram.com/aslah_mogral/",
    );

    if (await canLaunchUrl(profileUrl)) {
      await launchUrl(profileUrl);
    } else {
      throw 'Could not launch';
    }
  }

  moreApps() async {
    final Uri moreAppsUrl = Uri.parse(
      Constants.moreAppLink,
    );

    if (await canLaunchUrl(moreAppsUrl)) {
      await launchUrl(moreAppsUrl);
    } else {
      throw 'Could not launch';
    }
  }
}
