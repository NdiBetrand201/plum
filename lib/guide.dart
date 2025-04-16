import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class GuideScreen extends StatefulWidget {
  const GuideScreen({super.key});

  @override
  GuideScreenState createState() => GuideScreenState();
}

class GuideScreenState extends State<GuideScreen> {
  bool _isDownloading = false;

  // Generate and share PDF guide
  Future<void> _generateAndSharePDF(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) => [
          pw.Header(
              level: 0,
              child: pw.Text('Plum Classification Model Integration Guide')),
          pw.Paragraph(
              text:
                  'Learn how to integrate the plum classification model hosted on Render.'),
          pw.Header(level: 1, child: pw.Text('API Overview')),
          pw.Paragraph(
              text:
                  'The model is accessible via a REST API at https://plum-classifier.onrender.com.'),
          pw.Header(level: 1, child: pw.Text('Authentication')),
          pw.Paragraph(
              text:
                  'Obtain an API key from the Render dashboard and include it in the Authorization header.'),
          pw.Header(level: 1, child: pw.Text('Sample Code')),
          pw.Paragraph(
            text: '''
Python Example:
```python
import requests
url = "https://plum-classifier.onrender.com/classify"
headers = {"Authorization": "Bearer YOUR_API_KEY"}
files = {"image": open("plum.jpg", "rb")}
response = requests.post(url, headers=headers, files=files)
print(response.json())
```
''',
          ),
          pw.Header(level: 1, child: pw.Text('Endpoints')),
          pw.Paragraph(text: '''
- POST /classify: Upload an image to classify a plum.
  - Request: multipart/form-data with an image file.
  - Response: JSON with class and confidence (e.g., {"class": "Purple Plum", "confidence": 0.92}).
'''),
          pw.Header(level: 1, child: pw.Text('Model Download')),
          pw.Paragraph(text: '''
The model weights can be downloaded for local use. Visit https://plum-classifier.onrender.com/model-download for access.
- File format: PyTorch (.pth)
- Requirements: PyTorch 2.0+, Python 3.8+
'''),
          pw.Header(level: 1, child: pw.Text('Best Practices')),
          pw.Paragraph(
            text: '''
- Use high-resolution images.
- Ensure proper lighting and focus.
- Handle API errors gracefully.
- For local model use, optimize preprocessing to match training conditions.
''',
          ),
        ],
      ),
    );

    // Save PDF to temporary directory
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/plum_classifier_guide.pdf');
    await file.writeAsBytes(await pdf.save());

    // Share PDF
    await Share.shareXFiles([XFile(file.path)],
        text: 'Plum Classification Model Integration Guide');
  }

  // Download model file
  Future<void> _downloadModel(BuildContext context) async {
    const modelUrl =
        'https://plum-classifier.onrender.com/model-download'; // Placeholder URL
    const modelFileName = 'plum_classifier.pth';

    // Request storage permission
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
      return;
    }

    setState(() {
      _isDownloading = true;
    });

    try {
      // Get external storage directory
      final dir = await getExternalStorageDirectory();
      final file = File('${dir?.path}/$modelFileName');

      // Download file
      final response = await http.get(Uri.parse(modelUrl));
      if (response.statusCode == 200) {
        await file.writeAsBytes(response.bodyBytes);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Model downloaded to ${file.path}')),
        );
      } else {
        throw 'Failed to download model: ${response.statusCode}';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading model: $e')),
      );
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }

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
          'Integration Guide',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _generateAndSharePDF(context),
            tooltip: 'Download & Share Guide',
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
                    'Integrate Plum Classifier',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              // API Overview
              FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: _buildSectionCard(
                  title: 'API Overview',
                  content:
                      'The plum classification model is hosted on Render and accessible via a REST API. '
                      'Use the endpoint https://plum-classifier.onrender.com to classify plum images.',
                  icon: Icons.api,
                ),
              ),
              // Authentication
              FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: _buildSectionCard(
                  title: 'Authentication',
                  content: 'Secure your requests with an API key. '
                      'Obtain it from the Render dashboard and include it in the Authorization header: '
                      'Bearer YOUR_API_KEY.',
                  icon: Icons.lock,
                ),
              ),
              // Sample Code
              FadeInUp(
                duration: const Duration(milliseconds: 1400),
                child: _buildSectionCard(
                  title: 'Sample Code',
                  content: '''
• Python:
```python
import requests
url = "https://plum-classifier.onrender.com/classify"
headers = {"Authorization": "Bearer YOUR_API_KEY"}
files = {"image": open("plum.jpg", "rb")}
response = requests.post(url, headers=headers, files=files)
print(response.json())
```

• Flutter:
```dart
import 'package:http/http.dart' as http;
var url = Uri.parse('https://plum-classifier.onrender.com/classify');
var request = http.MultipartRequest('POST', url);
request.headers['Authorization'] = 'Bearer YOUR_API_KEY';
request.files.add(await http.MultipartFile.fromPath('image', 'path/to/plum.jpg'));
var response = await request.send();
print(await response.stream.bytesToString());
```
''',
                  icon: Icons.code,
                ),
              ),
              // Endpoints
              FadeInUp(
                duration: const Duration(milliseconds: 1600),
                child: _buildSectionCard(
                  title: 'Endpoints',
                  content: '''
• POST /classify
  - Request: multipart/form-data with an image file (JPEG/PNG).
  - Response: JSON object containing the predicted class and confidence score.
  - Example Response:
    ```json
    {
      "class": "Purple Plum",
      "confidence": 0.92,
      "probabilities": {
        "Purple Plum": 0.92,
        "Red Plum": 0.05,
        "Yellow Plum": 0.02,
        ...
      }
    }
    ```
''',
                  icon: Icons.link,
                ),
              ),
              // Model Download
              FadeInUp(
                duration: const Duration(milliseconds: 1800),
                child: _buildSectionCard(
                  title: 'Download Model',
                  content: '''
The plum classification model weights are available for local use. Download the PyTorch (.pth) file to run the model offline.
- File size: ~100 MB
- Requirements: PyTorch 2.0+, Python 3.8+
- Preprocessing: Resize images to 224x224, normalize with mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]

Click the button below to download or visit https://plum-classifier.onrender.com/model-download.
''',
                  icon: Icons.download,
                  actionButton: _isDownloading
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                        )
                      : ElevatedButton.icon(
                          onPressed: () => _downloadModel(context),
                          icon: const Icon(Icons.download),
                          label: const Text(
                            'Download Model',
                            style: TextStyle(fontFamily: 'Poppins'),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                        ),
                ),
              ),
              // Best Practices
              FadeInUp(
                duration: const Duration(milliseconds: 2000),
                child: _buildSectionCard(
                  title: 'Best Practices',
                  content: '''
• Use high-resolution images (at least 224x224 pixels).
• Ensure the plum is well-lit and centered.
• Handle API errors (e.g., 429 for rate limits, 400 for invalid inputs).
• For local model use, match preprocessing steps used during training.
• Cache responses to reduce redundant calls.
• Test with diverse plum images for robustness.
''',
                  icon: Icons.lightbulb,
                ),
              ),
              // Footer
              FadeInUp(
                duration: const Duration(milliseconds: 2200),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      children: [
                        const Text(
                          'Ready to integrate or run locally? Start building now!',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => _generateAndSharePDF(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF4CAF50),
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
                                'Download Guide',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: () => _launchURL(
                                  'https://plum-classifier.onrender.com'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: const Color(0xFF4CAF50),
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
                                'Visit Render',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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

  Widget _buildSectionCard({
    required String title,
    required String content,
    required IconData icon,
    Widget? actionButton,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontFamily: 'Poppins',
                height: 1.5,
              ),
            ),
            if (actionButton != null) ...[
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: actionButton,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
