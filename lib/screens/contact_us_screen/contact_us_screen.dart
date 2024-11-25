import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/screens/contact_us_screen/contact_us_screen_model.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContactUsScreenModel()),
      ],
      child: Consumer<ContactUsScreenModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text('Contact Us'),
            centerTitle: true,
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Mail',
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text('aslahmogral.dev@gmail.com'),
                  SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        model.sendMail();
                      },
                      child: Text('Click to Connect')),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Developer',
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        model.contactDeveloper();
                      },
                      child: Text('Contact Developer')),
                  SizedBox(
                    height: 26,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        model.moreApps();
                      },
                      child: Text('View More Apps'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
