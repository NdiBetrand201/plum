import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:plum/applications_screen.dart';
import 'classification _input screen.dart'; // Placeholder for navigation

import 'history.dart'; // Placeholder for navigation
import 'guide.dart'; // Placeholder for navigation
import 'setting.dart'; // Placeholder for navigation

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4CAF50), // Vibrant green
              Color(0xFF81C784), // Light green
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with animated title
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 44,
                        ),
                        const Text(
                          'Plum Classifier',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SettingsScreen(),
                                ),
                              );
                            },
                            child: Icon(Icons.settings,
                                size: 30, color: Colors.orange)),
                      ],
                    ),
                  ),
                ),
              ),
              // Welcome message
              FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Discover the power of AI in classifying plums with precision!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Main action buttons
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    _buildActionCard(
                      context,
                      title: 'Classify Plum',
                      icon: Icons.camera_alt,
                      color: Colors.white.withOpacity(0.2),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ClassificationInputScreen(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      context,
                      title: 'History',
                      icon: Icons.history,
                      color: Colors.white.withOpacity(0.2),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HistoryScreen(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      context,
                      title: 'Integration Guide',
                      icon: Icons.book,
                      color: Colors.white.withOpacity(0.2),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GuideScreen(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      context,
                      title: 'Applications',
                      icon: Icons.airline_seat_flat_outlined,
                      color: Colors.white.withOpacity(0.2),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ModelApplicationsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Plum image carousel for visual appeal
              FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: Container(
                  height: 150,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildPlumImage('assets/images/plum.jpeg'),
                      _buildPlumImage('assets/images/plum2.jpg'),
                      _buildPlumImage('assets/images/plum3.jpg'),
                      _buildPlumImage('assets/images/plum4.jpg'),
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

  Widget _buildActionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return FadeIn(
      duration: const Duration(milliseconds: 1000),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlumImage(String imagePath) {
    return Container(
      width: 120,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(imagePath), // Placeholder for plum images
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
