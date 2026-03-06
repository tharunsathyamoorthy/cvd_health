import 'package:flutter/material.dart';

class DiabetesCalculatorScreen extends StatefulWidget {
  const DiabetesCalculatorScreen({super.key});

  @override
  State<DiabetesCalculatorScreen> createState() =>
      _DiabetesCalculatorScreenState();
}

class _DiabetesCalculatorScreenState extends State<DiabetesCalculatorScreen> {
  final TextEditingController sugarController = TextEditingController();

  String selectedType = 'Fasting';
  String result = '';
  Color resultColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diabetes Risk Calculator'),
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
              /// INPUT CARD
              _card(
                child: Column(
                  children: [
                    _input(sugarController, 'Blood Glucose (mg/dL)'),
                    const SizedBox(height: 12),
                    _typeSelector(),
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

              /// RESULT DASHBOARD
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

              /// INFO CARDS
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

  // ================= LOGIC =================

  void _calculate() {
    final value = int.tryParse(sugarController.text);
    if (value == null || value <= 0) return;

    setState(() {
      if (selectedType == 'Fasting') {
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
      } else {
        if (value < 140) {
          result = 'Normal';
          resultColor = Colors.green;
        } else if (value < 200) {
          result = 'Prediabetes';
          resultColor = Colors.orange;
        } else {
          result = 'Diabetes';
          resultColor = Colors.red;
        }
      }
    });
  }

  String _resultMessage() {
    switch (result) {
      case 'Normal':
        return 'Your blood glucose level is within the healthy range.';
      case 'Prediabetes':
        return 'Your glucose level is slightly elevated. Lifestyle changes are recommended.';
      case 'Diabetes':
        return 'Your glucose level is high. Please consult a healthcare provider.';
      default:
        return '';
    }
  }

  // ================= UI COMPONENTS =================

  Widget _input(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _typeSelector() {
    return DropdownButtonFormField<String>(
      value: selectedType,
      items: const [
        DropdownMenuItem(value: 'Fasting', child: Text('Fasting')),
        DropdownMenuItem(value: 'After Meal', child: Text('After Meal')),
        DropdownMenuItem(value: 'Random', child: Text('Random')),
      ],
      onChanged: (v) => setState(() => selectedType = v!),
      decoration: const InputDecoration(
        labelText: 'Test Type',
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
