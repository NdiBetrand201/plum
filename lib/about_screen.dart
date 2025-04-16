import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  // Launch URL for external links
  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4CAF50),
              Color(0xFF81C784),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Info
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: _buildInfoCard(
                  title: 'Plum Classifier',
                  icon: Icons.info,
                  content: '''
Version: 1.0.0
Developed by: Plum AI Team

Plum Classifier is an innovative app powered by a PyTorch model trained to classify six varieties of plums with high accuracy. Whether you're a farmer, a chef, or a curious enthusiast, this app helps you identify plums effortlessly using advanced AI technology.
''',
                ),
              ),
              // Model Info
              FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: _buildInfoCard(
                  title: 'About the Model',
                  icon: Icons.model_training,
                  content: '''
The plum classification model is built using PyTorch and trained on a diverse dataset of six plum varieties: Purple Plum, Red Plum, Yellow Plum, Green Plum, Black Plum, and Blue Plum. Hosted on Render, the model processes images via a REST API, delivering fast and accurate predictions with confidence scores.
''',
                ),
              ),
              // Contact Info
              FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: _buildInfoCard(
                  title: 'Contact Us',
                  icon: Icons.contact_support,
                  content: '''
Have questions or feedback? Reach out to us!

Email: support@plumclassifier.com
Website: www.plumclassifier.com
''',
                  onTap: () => _launchURL('mailto:support@plumclassifier.com'),
                ),
              ),
              // Legal Links
              FadeInUp(
                duration: const Duration(milliseconds: 1400),
                child: _buildInfoCard(
                  title: 'Legal',
                  icon: Icons.gavel,
                  content: '''
Privacy Policy
Terms of Use
''',
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.privacy_tip,
                                  color: Color(0xFF4CAF50)),
                              title: const Text('Privacy Policy'),
                              onTap: () => _launchURL(
                                  'https://www.plumclassifier.com/privacy'),
                            ),
                            ListTile(
                              leading: const Icon(Icons.description,
                                  color: Color(0xFF4CAF50)),
                              title: const Text('Terms of Use'),
                              onTap: () => _launchURL(
                                  'https://www.plumclassifier.com/terms'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Footer
              FadeInUp(
                duration: const Duration(milliseconds: 1600),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: Text(
                      '© 2025 Plum Classifier. All rights reserved.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                        fontFamily: 'Poppins',
                      ),
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

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required String content,
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      color: Colors.white.withOpacity(0.9),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 30,
                    color: const Color(0xFF4CAF50),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4CAF50),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                content,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
