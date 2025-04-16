import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  // Simulated history data (replace with actual storage solution)
  final List<Map<String, dynamic>> _history = [
    {
      'imagePath': 'assets/images/plum.jpeg',
      'class': 'Purple Plum',
      'confidence': 0.92,
      'date': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'imagePath': 'assets/images/plum2.jpg',
      'class': 'Red Plum',
      'confidence': 0.85,
      'date': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'imagePath': 'assets/images/plum3.jpg',
      'class': 'Yellow Plum',
      'confidence': 0.78,
      'date': DateTime.now().subtract(const Duration(days: 3)),
    },
  ];

  void _deleteHistoryItem(int index) {
    setState(() {
      _history.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('History item deleted')),
    );
  }

  void _shareHistoryItem(Map<String, dynamic> item) {
    // Implement sharing logic (e.g., via share_plus package)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sharing ${item['class']} result')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Classification History',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _history.isEmpty
                ? null
                : () {
                    setState(() {
                      _history.clear();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('History cleared')),
                    );
                  },
          ),
        ],
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
        child: _history.isEmpty
            ? const Center(
                child: Text(
                  'No classifications yet!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontFamily: 'Poppins',
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  final item = _history[index];
                  return FadeInUp(
                    duration: Duration(milliseconds: 500 + index * 100),
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      color: Colors.white.withOpacity(0.9),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            // Thumbnail
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                item['imagePath'],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 15),
                            // Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['class'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF4CAF50),
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Confidence: ${(item['confidence'] * 100).toStringAsFixed(1)}%',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Date: ${DateFormat('MMM dd, yyyy').format(item['date'])}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Actions
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.share,
                                      color: Color(0xFF4CAF50)),
                                  onPressed: () => _shareHistoryItem(item),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.redAccent),
                                  onPressed: () => _deleteHistoryItem(index),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
