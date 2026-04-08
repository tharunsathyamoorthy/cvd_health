import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController messageController = TextEditingController();

  // ✅ UPDATED EMAIL FUNCTION (FIXED)
  Future<void> sendEmail() async {
    String message = messageController.text.trim();

    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your message")),
      );
      return;
    }

    final Uri emailUri = Uri.parse(
      "mailto:tharunkumars.22it@kongu.edu"
      "?subject=Feedback from CVD App"
      "&body=${Uri.encodeComponent(message)}",
    );

    try {
      await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication, // ✅ forces email app
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No email app found on device")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us"),
        backgroundColor: const Color(0xFFb71c1c),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Get in Touch",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            const Text("📧 Email"),
            const Text("support@cvdapp.com"),
            const SizedBox(height: 15),

            const Text("📞 Phone"),
            const Text("+91 73971 10669"),
            const SizedBox(height: 15),

            const Text("📍 Address"),
            const Text("Kongu Engineering College, Tamil Nadu, India"),
            const SizedBox(height: 25),

            const Text(
              "Send us your feedback",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: "Enter your message",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLines: 4,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFb71c1c),
                ),
                onPressed: sendEmail,
                child: const Text("Send"),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
