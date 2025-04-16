import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'home_screen.dart'; // Placeholder for the next screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to HomeScreen after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CAF50), // Vibrant green background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated logo
            FadeInDown(
              duration: const Duration(milliseconds: 1000),
              child: Image.asset(
                'assets/images/plum logo.jpeg', // Placeholder for logo asset
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(height: 20),
            // App title with animation
            FadeInUp(
              duration: const Duration(milliseconds: 1000),
              child: const Text(
                'Plum Classifier',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Tagline
            FadeInUp(
              duration: const Duration(milliseconds: 1200),
              child: const Text(
                'Classify Plums with AI',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Loading indicator
            Spin(
              duration: const Duration(milliseconds: 1500),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
