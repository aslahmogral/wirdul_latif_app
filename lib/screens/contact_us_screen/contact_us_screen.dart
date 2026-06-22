import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wirdul_latif/screens/contact_us_screen/contact_us_screen_model.dart';
import 'package:wirdul_latif/utils/responsive.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ContactUsScreenModel(),
      child: Consumer<ContactUsScreenModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Contact Us'),
            centerTitle: true,
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: context.isTablet ? 600.0 : double.infinity,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      _buildContactCard(
                        context: context,
                        icon: Icons.mail_outline,
                        title: 'Email Support',
                        subtitle: 'aslahmogral.dev@gmail.com',
                        buttonText: 'Click to Connect',
                        onPressed: () => model.sendMail(),
                      ),
                      const SizedBox(height: 16),
                      _buildContactCard(
                        context: context,
                        icon: Icons.code,
                        title: 'Developer Profile',
                        subtitle: 'Connect with the developer of this app',
                        buttonText: 'Contact Developer',
                        onPressed: () => model.contactDeveloper(),
                      ),
                      const SizedBox(height: 16),
                      _buildContactCard(
                        context: context,
                        icon: Icons.apps,
                        title: 'More Apps',
                        subtitle: 'Check out our other Islamic applications',
                        buttonText: 'View More Apps',
                        onPressed: () => model.moreApps(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: isDark ? null : LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.teal.withOpacity(0.05),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.teal.withOpacity(0.1),
                    child: Icon(icon, color: Colors.teal),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
