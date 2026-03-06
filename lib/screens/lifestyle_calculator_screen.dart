import 'package:flutter/material.dart';

class LifestyleCalculatorScreen extends StatefulWidget {
  const LifestyleCalculatorScreen({super.key});

  @override
  State<LifestyleCalculatorScreen> createState() =>
      _LifestyleCalculatorScreenState();
}

class _LifestyleCalculatorScreenState extends State<LifestyleCalculatorScreen> {
  bool smoker = false;
  bool physicallyActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lifestyle Risk Calculator'),
        backgroundColor: const Color(0xFFb71c1c),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Select lifestyle factors',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            SwitchListTile(
              title: const Text('Smoker'),
              value: smoker,
              onChanged: (v) => setState(() => smoker = v),
            ),

            SwitchListTile(
              title: const Text('Physically Active'),
              value: physicallyActive,
              onChanged: (v) => setState(() => physicallyActive = v),
            ),

            const SizedBox(height: 24),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFb71c1c),
              ),
              onPressed: () {
                String result;

                if (smoker && !physicallyActive) {
                  result = 'High Lifestyle Risk';
                } else if (smoker || !physicallyActive) {
                  result = 'Moderate Lifestyle Risk';
                } else {
                  result = 'Low Lifestyle Risk';
                }

                showDialog(
                  context: context,
                  builder:
                      (_) => AlertDialog(
                        title: const Text('Result'),
                        content: Text(result),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                );
              },
              child: const Text('Evaluate Risk'),
            ),
          ],
        ),
      ),
    );
  }
}
