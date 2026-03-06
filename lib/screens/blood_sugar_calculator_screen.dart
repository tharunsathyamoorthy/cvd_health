import 'package:flutter/material.dart';

class BloodSugarCalculatorScreen extends StatefulWidget {
  const BloodSugarCalculatorScreen({super.key});

  @override
  State<BloodSugarCalculatorScreen> createState() =>
      _BloodSugarCalculatorScreenState();
}

class _BloodSugarCalculatorScreenState
    extends State<BloodSugarCalculatorScreen> {
  final TextEditingController sugarController = TextEditingController();

  String result = '';
  Color resultColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Sugar Checker'),
        backgroundColor: const Color(0xFFB71C1C),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD32F2F), Color.fromARGB(255, 221, 201, 201)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _card(
                child: Column(
                  children: [
                    _input(sugarController, 'Fasting Blood Sugar (mg/dL)'),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: _calculate,
                        child: const Text('Analyze'),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              if (result.isNotEmpty)
                _card(
                  child: Column(
                    children: [
                      Text(
                        result,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: resultColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _resultMessage(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(child: _infoCard('Normal', '70–99', Colors.green)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _infoCard('Prediabetes', '100–125', Colors.orange),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: _infoCard('Diabetes', '≥ 126', Colors.red)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== LOGIC =====

  void _calculate() {
    final value = int.tryParse(sugarController.text);
    if (value == null || value <= 0) return;

    setState(() {
      if (value < 100) {
        result = 'Normal';
        resultColor = Colors.green;
      } else if (value < 126) {
        result = 'Prediabetes';
        resultColor = Colors.orange;
      } else {
        result = 'Diabetes';
        resultColor = Colors.red;
      }
    });
  }

  String _resultMessage() {
    switch (result) {
      case 'Normal':
        return 'Your blood sugar level is normal.';
      case 'Prediabetes':
        return 'Your blood sugar level is slightly high.';
      case 'Diabetes':
        return 'Your blood sugar level is high.';
      default:
        return '';
    }
  }

  // ===== UI HELPERS =====

  Widget _input(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Blood Sugar (mg/dL)',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(padding: const EdgeInsets.all(16), child: child),
    );
  }

  Widget _infoCard(String title, String value, Color color) {
    return Card(
      color: color.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
