import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:plum/guide.dart';

class ModelApplicationsScreen extends StatelessWidget {
  const ModelApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of real-life applications
    final List<Map<String, dynamic>> applications = [
      {
        'title': 'Agricultural Sorting',
        'description':
            'Use the plum classification model to automate sorting in orchards. Identify plum varieties in real-time to streamline harvesting and packaging processes, ensuring quality control and efficiency.',
        'icon': Icons.agriculture,
        'image': 'assets/images/Gemini_Generated_Image_scchg9scchg9scch.jpeg',
      },
      {
        'title': 'Culinary Arts',
        'description':
            'Integrate the model into kitchen apps to suggest recipes based on plum types. Chefs and home cooks can scan plums to get tailored dish ideas, enhancing creativity and flavor pairing.',
        'icon': Icons.restaurant,
        'image': 'assets/images/Gemini_Generated_Image_27o5zm27o5zm27o5.jpeg',
      },
      {
        'title': 'Educational Tools',
        'description':
            'Incorporate the model into learning apps for botany students. Allow users to identify plum varieties in the field, fostering hands-on education and research in horticulture.',
        'icon': Icons.school,
        'image': 'assets/images/Gemini_Generated_Image_nzr73vnzr73vnzr7.jpeg',
      },
      {
        'title': 'Quality Inspection',
        'description':
            'Use the model in food processing to inspect plum quality. Detect defects or misclassifications during production, ensuring only the best plums reach consumers.',
        'icon': Icons.check_circle,
        'image': 'assets/images/Gemini_Generated_Image_bouvmdbouvmdbouv.jpeg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Model Applications',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              FadeInDown(
                duration: const Duration(milliseconds: 800),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Real-Life Applications',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              // Introduction
              FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Discover how the Plum Classification Model can transform industries and projects with its powerful AI capabilities.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontFamily: 'Poppins',
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Carousel of Applications
              FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 400,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    enlargeCenterPage: true,
                    viewportFraction: 0.85,
                    aspectRatio: 2.0,
                  ),
                  items: applications.map((app) {
                    return Builder(
                      builder: (BuildContext context) {
                        return _buildApplicationCard(
                          title: app['title'],
                          description: app['description'],
                          icon: app['icon'],
                          image: app['image'],
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              // Call to Action
              FadeInUp(
                duration: const Duration(milliseconds: 1400),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    color: Colors.white.withOpacity(0.9),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4CAF50),
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Ready to apply the model in your project? Explore the integration guide or contact our team for support!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontFamily: 'Poppins',
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {
                              // Navigate to Integration Guide Screen
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GuideScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4CAF50),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              'View Integration Guide',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildApplicationCard({
    required String title,
    required String description,
    required IconData icon,
    required String image,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Background Image
            Image.asset(
              image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            // Overlay Gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(
                        icon,
                        size: 30,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      height: 1.5,
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
