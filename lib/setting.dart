import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkTheme = false;
  String _selectedLanguage = 'English';
  final TextEditingController _apiKeyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Simulated clear history action
  void _clearHistory() {
    // Replace with actual history clearing logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Classification history cleared')),
    );
  }

  // Submit feedback
  void _submitFeedback(String feedback) {
    // Replace with actual feedback submission logic (e.g., API call)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Feedback submitted: $feedback')),
    );
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
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
              // Theme Toggle
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: _buildSettingsCard(
                  title: 'Theme',
                  icon: Icons.brightness_6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Dark Theme',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Switch(
                        value: _isDarkTheme,
                        onChanged: (value) {
                          setState(() {
                            _isDarkTheme = value;
                          });
                          // Implement theme change logic here
                        },
                        activeColor: const Color(0xFF4CAF50),
                      ),
                    ],
                  ),
                ),
              ),
              // Language Selection
              FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: _buildSettingsCard(
                  title: 'Language',
                  icon: Icons.language,
                  child: DropdownButtonFormField<String>(
                    value: _selectedLanguage,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    items: ['English', 'Spanish', 'French']
                        .map((language) => DropdownMenuItem(
                              value: language,
                              child: Text(language),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedLanguage = value!;
                      });
                      // Implement language change logic here
                    },
                  ),
                ),
              ),
              // API Key Input
              FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: _buildSettingsCard(
                  title: 'API Key',
                  icon: Icons.vpn_key,
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _apiKeyController,
                      decoration: const InputDecoration(
                        labelText: 'Enter API Key',
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an API key';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (_formKey.currentState!.validate()) {
                          // Save API key (implement storage logic)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('API Key saved')),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              // Clear History
              FadeInUp(
                duration: const Duration(milliseconds: 1400),
                child: _buildSettingsCard(
                  title: 'Clear History',
                  icon: Icons.delete_sweep,
                  child: ElevatedButton(
                    onPressed: _clearHistory,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Clear Classification History',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ),
              // Feedback Form
              FadeInUp(
                duration: const Duration(milliseconds: 1600),
                child: _buildSettingsCard(
                  title: 'Feedback',
                  icon: Icons.feedback,
                  child: Column(
                    children: [
                      TextFormField(
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Your Feedback',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                        ),
                        onFieldSubmitted: _submitFeedback,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _submitFeedback(_apiKeyController.text);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF4CAF50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Submit Feedback',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      color: Colors.white.withOpacity(0.9),
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
            child,
          ],
        ),
      ),
    );
  }
}
