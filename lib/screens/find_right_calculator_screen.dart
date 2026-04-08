import 'package:flutter/material.dart';

class FindRightCalculatorScreen extends StatefulWidget {
  const FindRightCalculatorScreen({super.key});

  @override
  State<FindRightCalculatorScreen> createState() =>
      _FindRightCalculatorScreenState();
}

class _FindRightCalculatorScreenState extends State<FindRightCalculatorScreen> {
  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFFb71c1c);

    return Scaffold(
      backgroundColor: Colors.white,

      // ===================== APP BAR =====================
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('CVD Risk Chart'),
        centerTitle: true,
      ),

      // ===================== BODY =====================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===================== TITLE =====================
            const Text(
              "WHO Cardiovascular Risk Chart",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "This chart is used to estimate the 10-year risk of cardiovascular diseases based on health parameters.",
              style: TextStyle(color: Colors.black87),
            ),

            const SizedBox(height: 20),

            // ===================== CHART IMAGE =====================
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/cvd_chart.png', // 🔥 ADD IMAGE HERE
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ===================== POINTS =====================
            const Text(
              "Key Points:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text("• Green (<5%) → Low risk"),
            const Text("• Yellow (5–10%) → Mild risk"),
            const Text("• Orange (10–20%) → Moderate risk"),
            const Text("• Red (20–30%) → High risk"),
            const Text("• Dark Red (≥30%) → Very high risk"),

            const SizedBox(height: 15),

            const Text(
              "Factors Used:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text("• Age"),
            const Text("• Systolic Blood Pressure (SBP)"),
            const Text("• Cholesterol Level"),
            const Text("• Smoking Status"),
            const Text("• Diabetes Condition"),

            const SizedBox(height: 15),

            const Text(
              "How to Use:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text("• Select your age group and blood pressure level"),
            const Text("• Check smoker/non-smoker and diabetes condition"),
            const Text("• Match cholesterol level with chart"),
            const Text("• Identify color zone to find your risk percentage"),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
