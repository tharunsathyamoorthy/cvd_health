import 'package:flutter/material.dart';

class HowToUseScreen extends StatelessWidget {
  const HowToUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text("How to Use This Application"),
        backgroundColor: const Color(0xFFB11226),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB11226), Color(0xFFF5F5F5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Application Usage Guide",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  StepTile(
                    step: "1",
                    title: "Open Risk Calculator",
                    description:
                        "From the home screen, select the risk calculator option to begin cardiovascular risk assessment.",
                  ),

                  StepTile(
                    step: "2",
                    title: "Enter Patient Information",
                    description:
                        "Provide accurate values for age, blood pressure, cholesterol, glucose level, and lifestyle details.",
                  ),

                  StepTile(
                    step: "3",
                    title: "Select Lifestyle Factors",
                    description:
                        "Choose gender, smoking status, and physical activity level using the provided options.",
                  ),

                  StepTile(
                    step: "4",
                    title: "Calculate Risk",
                    description:
                        "Tap the 'Calculate Risk' button to send the data to the AI model for prediction.",
                  ),

                  StepTile(
                    step: "5",
                    title: "View Results",
                    description:
                        "Review your cardiovascular risk prediction, probability, model accuracy, and best model used.",
                  ),

                  StepTile(
                    step: "6",
                    title: "Use Results Responsibly",
                    description:
                        "The results are for educational purposes only and should not replace professional medical advice.",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StepTile extends StatelessWidget {
  final String step;
  final String title;
  final String description;

  const StepTile({
    super.key,
    required this.step,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: const Color(0xFFB11226),
            child: Text(
              step,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
